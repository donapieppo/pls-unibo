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
BOOKING_WATCHERS = ['mirella.manaresi@unibo.it']

ACCROCCHIO_VECCHIO_SITO  = [
  "", 
  "http://www.pls.unibo.it/it/biologia-e-biotecnologie", 
  "http://www.pls.unibo.it/it/chimica",
  "http://www.pls.unibo.it/it/fisica",
  "http://www.pls.unibo.it/it/geologia", 
  "http://www.pls.unibo.it/it/informatica",
  "http://www.pls.unibo.it/it/matematica", 
  "http://www.pls.unibo.it/it/scienze-naturali-ambientali",
  "http://www.pls.unibo.it/it/statistica"
]

SOFIA_LINK = 'https://sofia.istruzione.it/'

module PlsUnibo
  class Application < Rails::Application
    config.domain_name = 'dm.unibo.it'

    config.header_title    = 'PLS'
    config.header_subtitle = 'del Dipartimento di Matematica'
    config.header_icon     = 'bullhorn'
    config.repayment_deadline = 14 # 8 days for working on repayment/refund before speaker arrival
    config.on_line_repayment_deadline_1 = 5  # 5 giorni prima della giunta
    config.on_line_repayment_deadline_2 = 10 # 10 fra la giunta e inizio del seminario

    config.host = 'dm.unibo.it'
    config.interceptor_mails = 'donatini@dm.unibo.it'
    config.default_from      = 'Organizzazione PLS <notifica.inviodlist.08218@unibo.it>'
    config.reply_to          = 'dipmat-supportoweb@unibo.it'

    config.impersonate_admins = CESIA_UPN
    config.main_impersonations = []
  end
end


