Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.ignore_actions = ["Rails::HealthController#show"]
  config.lograge.formatter = Lograge::Formatters::Json.new
  # hook for accessing controller methods directly (e.g. request and current_user)
  config.lograge.custom_payload do |controller|
    if !controller.is_a?(Rails::HealthController)
      res = {}
      res[:remote_ip] = controller.request.remote_ip
      res[:host] = controller.request.host
      res[:current_user] = controller.current_user&.email if controller.respond_to?(:current_user)
      if controller.respond_to?(:true_user) && controller.current_user != controller.true_user
        res[:true_user] = controller.true_user&.email
      end
      res
    end
  end
  config.lograge.custom_options = lambda do |event|
    {
      params: event.payload[:params].except(*%w[controller action format id])
    }
  end
end
