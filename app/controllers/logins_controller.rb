class LoginsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :developer
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
    user = User.find_by_email(@email)
    if !user
      logger.info "Authentication: google_oauth2 user #{@email} not present in db."
      user = create_logged_user
      sign_in_and_redirect user, myedit_users_path
    else
      logger.info "Authentication: google_oauth2 user #{user.inspect} found in db."
      sign_in_and_redirect user, root_path
    end
  end

  def entra_id
    parse_entra_id
    user = User.find_by_email(@email)
    if !user
      logger.info "Authentication: entra_id user #{@email} not present in db."
      user = create_logged_user
      sign_in_and_redirect user, myedit_users_path
    else
      logger.info "Authentication: entra_id user #{user.inspect} found in db."
      sign_in_and_redirect user, root_path
    end
  end

  def developer
    parse_developer_omniauth
    check_developer!
    user = User.find_by_email(@email)
    if !user
      logger.info "Developer Authentication: User #{@email} to be CREATED"
      user = create_logged_user
      sign_in_and_redirect user, myedit_users_path
    else
      logger.info "Developer Authentication found user #{user.inspect}"
      sign_in_and_redirect user, root_path
    end
  end

  def check_developer!
    (Rails.env.development? || Rails.env.test?) or raise "NOT IN DEVELOPMENT"
    request.remote_ip == "127.0.0.1" or raise "ONLY LOCAL OF DOCKER. YOU ARE #{request.remote_ip}"
    # request.remote_ip =~ /^192\.\d+\.\d+\.\d+/ or
    # request.remote_ip == '::1' or
    # request.remote_ip =~ /^172\.\d+\.\d+\.\d+/ or raise "ONLY LOCAL OF DOCKER. YOU ARE #{request.remote_ip}"
  end

  def logout
    logger.info("Chiamato Logout")
    logger.info("session_user_id: #{session[:user_id]}")

    session[:user_id] = nil
    reset_session
    cookies.clear

    logger.info "redirect to https://login.microsoftonline.com/common/oauth2/v2.0/logout?post_logout_redirect_uri=#{root_url}"
    redirect_to "https://login.microsoftonline.com/common/oauth2/v2.0/logout?post_logout_redirect_uri=#{root_url}", allow_other_host: true
  end

  def glogout
    logger.info("Chiamato Logout per Google")
    logger.info("session_user_id: #{session[:user_id]}")

    session[:user_id] = nil
    reset_session
    cookies.clear
    redirect_to "https://accounts.google.com/Logout?hl=it&continue=#{root_url}", allow_other_host: true
  end

  private

  # omniauth.auth: #<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=true expires_at=... token="..."> extra=#<OmniAuth::AuthHash id_info=#<OmniAuth::AuthHash at_hash="..." aud="..." azp="..." email="donapieppo@gmail.com" email_verified=true exp=1472639186 iat=1472635586 iss="accounts.google.com" sub="..."> id_token="..." raw_info=#<OmniAuth::AuthHash email="donapieppo@gmail.com" email_verified="true" family_name="Dona" gender="male" given_name="Pieppo" kind="plus#personOpenIdConnect" locale="it" name="Pieppo Dona" picture="..." profile="..." sub="...">> info=#<OmniAuth::AuthHash::InfoHash email="donapieppo@gmail.com" first_name="Pieppo" image="https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg" last_name="Dona" name="Pieppo Dona" urls=#<OmniAuth::AuthHash Google="https://plus.google.com/104065190780467868357">> provider="google_oauth2" uid="104065190780467868357">
  def parse_google_omniauth
    # logger.info("omniauth.auth: #{request.env['omniauth.auth'].inspect}")
    oinfo = request.env["omniauth.auth"].info
    @email = oinfo.email
    @name = oinfo.firstname
    @surname = oinfo.last_name
  end

  def parse_entra_id
    if (oa = request.env["omniauth.auth"]["extra"]["raw_info"])
      @email = oa.email
      @name = oa.given_name
      @surname = oa.family_name
      @id_anagrafica_unica = oa.idAnagraficaUnica.to_i
    end
  end

  def parse_developer_omniauth
    oinfo = request.env["omniauth.auth"].info
    @email = oinfo.upn
    @name = "Pippo"
    @surname = "Pluto"
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
    # user = @idAnagraficaUnica ? ::User.where(id: @idAnagraficaUnica).first : ::User.where(email: @email).first
    user = User.find_by_email(@email)
    if !user
      logger.info "Authentication: allow_and_create user #{@email} to be CREATED."
      h = {
        # id:      @idAnagraficaUnica || 0,
        email: @email,
        name: @name,
        surname: @surname
      }
      user = User.create!(h)
    end
    logger.info "allow_and_create: #{user.inspect}"
    sign_in_and_redirect user, root_path
  end

  def create_logged_user
    logger.info "Authentication: create_logged_user user #{@email} to be CREATED"
    logger.info "name: #{@name}, surname: #{@surname}, email: #{@email}"
    User.create!(name: @name, surname: @surname, email: @email)
  end

  def no_access
  end
end
