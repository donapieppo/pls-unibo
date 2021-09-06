class LoginsController < ApplicationController
  before_action :skip_authorization
  skip_before_action :force_sso_user, raise: false

  def index
    @no_container = true
    if params[:for]
      session[:activity_asked] = params[:for].to_i
    end
    # render layout: nil
  end

  # env['omniauth.auth'].info = {email, name, last_name}
  def google_oauth2
    parse_google_omniauth
    user = User.where(email: @email).first
    if ! user
      logger.info "Authentication: User #{@email} to be CREATED"
      user = create_logged_user
      sign_in_and_redirect user, myedit_users_path
    else
      logger.info "Authentication: allow_and_create found user #{user.inspect}"
      sign_in_and_redirect user, root_path
    end
  end

  # email="usrBase@testtest.unibo.it" last_name="Base" name="SSO"
  def shibboleth
    log_unibo_omniauth
    parse_unibo_omniauth

    if @email =~ /@unibo.it$/
      allow_and_create
    else
      logger.info "Students are not allowed: #{@email} user not allowed."
      redirect_to no_access_path and return
    end
  end

  def developer
    parse_developer_omniauth
    check_developer!
    user = User.where(email: @email).first
    if ! user
      logger.info "Developer Authentication: User #{@email} to be CREATED"
      user = create_logged_user
      sign_in_and_redirect user, myedit_users_path
    else
      logger.info "Developer Authentication: allow_and_create found user #{user.inspect}"
      sign_in_and_redirect user, root_path
    end
  end

  def check_developer!
    # Socket.gethostname == 'tester' or Socket.gethostname == 'casa' or raise "NOT IN TRUFFAUT"
    Rails.env.development? or raise "NOT IN DEVELOPMENT"
    request.remote_ip == '137.204.134.32' or 
      request.remote_ip == '127.0.0.1' or 
      request.remote_ip =~ /^192\.\d+\.\d+\.\d+/ or request.remote_ip == '::1' or request.remote_ip =~ /^172\.\d+\.\d+\.\d+/ or raise "ONLY LOCAL OF DOCKER. YOU ARE #{request.remote_ip}"
  end

  def logout
    session[:user_id] = nil
    reset_session
    # logger.info("after logout we redirect to params[:return] = #{params[:return]}")
    # redirect_to (params[:return] || 'https://www.muriditalia.it')
    redirect_to root_path, notice: "Uscito correttamente."
  end

  private 

  # omniauth.auth: #<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=true expires_at=... token="..."> extra=#<OmniAuth::AuthHash id_info=#<OmniAuth::AuthHash at_hash="..." aud="..." azp="..." email="donapieppo@gmail.com" email_verified=true exp=1472639186 iat=1472635586 iss="accounts.google.com" sub="..."> id_token="..." raw_info=#<OmniAuth::AuthHash email="donapieppo@gmail.com" email_verified="true" family_name="Dona" gender="male" given_name="Pieppo" kind="plus#personOpenIdConnect" locale="it" name="Pieppo Dona" picture="..." profile="..." sub="...">> info=#<OmniAuth::AuthHash::InfoHash email="donapieppo@gmail.com" first_name="Pieppo" image="https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg" last_name="Dona" name="Pieppo Dona" urls=#<OmniAuth::AuthHash Google="https://plus.google.com/104065190780467868357">> provider="google_oauth2" uid="104065190780467868357">
  def parse_google_omniauth
    # logger.info("omniauth.auth: #{request.env['omniauth.auth'].inspect}")
    oinfo  = request.env['omniauth.auth'].info
    @email = oinfo.email
    @name  = oinfo.firstname
    @surname = oinfo.last_name
  end

  def parse_developer_omniauth
    oinfo  = request.env['omniauth.auth'].info
    @email = oinfo.name
    @name  = "Pippo"
    @surname = "Pluto"
  end

  def parse_unibo_omniauth
    @upn  = request.env['omniauth.auth'].uid
    oinfo = request.env['omniauth.auth'].info
    extra = request.env['omniauth.auth'].extra.raw_info

    @idAnagraficaUnica = extra.idAnagraficaUnica.to_i
    @idAnagraficaUnica > 0 or raise "NO idAnagraficaUnica"

    @email         = @upn
    @name          = oinfo.first_name || oinfo.name
    @surname       = oinfo.last_name
    @nationalpin   = extra.codiceFiscale
  end

  def sign_in_and_redirect(user, url)
    session[:user_id] = user.id
    user.update(last_login: Time.now)
    if user.last_login
      if session[:activity_asked]
        url = Activity.find(session[:activity_asked])
        session.delete(:activity_asked)
      end
      redirect_to url
    else
      redirect_to myedit_users_path
    end
  end

  def allow_and_create
    user = @idAnagraficaUnica ? ::User.where(id: @idAnagraficaUnica).first : ::User.where(email: @email).first
    if ! user
      logger.info "Authentication: User #{@email} to be CREATED"
      h = {id:      @idAnagraficaUnica || 0,
           email:   @email,
           name:    @name, 
           surname: @surname }
      h[:nationalpin] = @nationalpin if ::User.column_names.include?('nationalpin')
      user = ::User.create!(h)
    end
    logger.info "Authentication: allow_and_create as #{user.inspect}"
    sign_in_and_redirect user, root_path
  end

  def create_logged_user
    logger.info "Authentication: User #{@email} to be CREATED"
    User.create(name: @name, surname: @surname, email: @email)
  end

  def log_unibo_omniauth
    request.env['omniauth.auth'] or return
    logger.info("Authentication: uid   = #{request.env['omniauth.auth'].uid}")
    logger.info("Authentication: info  = #{request.env['omniauth.auth'].info}")
    logger.info("Authentication: extra = #{request.env['omniauth.auth'].extra}")
  end

  def no_access
  end
end
