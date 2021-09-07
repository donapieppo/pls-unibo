# if Rails.configuration.dm_unibo_common[:smtp_password] 
#   ActionMailer::Base.smtp_settings = {
#     address:        'mail.unibo.it',
#     port:           587,
#     user_name:      'notifica.inviodlist.08218@unibo.it',
#     password:       Rails.configuration.dm_unibo_common[:smtp_password],
#     authentication: :login,
#     enable_starttls_auto: true
#   }
# end

CURRENT_ACADEMIC_YEAR = 2021
CESIA_UPN = ['pietro.donatini@unibo.it', 'valeria.montesi3@unibo.it']

module PlsUnibo
  class Application < Rails::Application
    config.domain_name = 'dm.unibo.it'

    config.header_title    = 'PLS'
    config.header_subtitle = 'del Dipartimento di Matematica'
    config.header_icon     = 'bullhorn'
    config.repayment_deadline = 14 # 8 days for working on repayment/refund before speaker arrival
    config.on_line_repayment_deadline_1 = 5  # 5 giorni prima della giunta
    config.on_line_repayment_deadline_2 = 10 # 10 fra la giunta e inizio del seminario

    config.default_from    = 'PLS <notifica.inviodlist.08218@unibo.it>'
    config.reply_to        = 'dipmat-supportoweb@unibo.it'
  end
end


