class DevelopmentMailInterceptor  
  def self.delivering_email(message)  
    if Rails.env.development?
      Rails.logger.info("Development env: modify recipient mail to interceptor_mails: #{Rails.configuration.interceptor_mails}")
      message.subject = "[to :#{message.to} cc:#{message.cc} bcc:#{message.bcc}] #{message.subject}"
      message.to  = Rails.configuration.interceptor_mails
      message.cc  = nil
      message.bcc = nil
    else
      if ! message.bcc.kind_of?(Array)
        message.bcc = message.bcc ? [message.bcc] : []
      end
    end
    if Rails.configuration.message_footer && ! Rails.configuration.message_footer.blank?
      message.body = message.body.to_s + "\n ------------------- \n" + Rails.configuration.message_footer
    end
  end  
end  

Rails.application.reloader.to_prepare do
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) 
  Rails.application.routes.default_url_options[:host] = Rails.configuration.host
end
