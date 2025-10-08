CURRENT_ACADEMIC_YEAR = 2025
CESIA_UPN = ["pietro.donatini@unibo.it", "valeria.montesi3@unibo.it"]
BOOKING_WATCHERS = ["mirella.manaresi@unibo.it", "alessia.cattabriga@unibo.it"]

SOFIA_LINK = "https://sofia.istruzione.it/"

module Pls
  class Application < Rails::Application
    config.archive_url_root = "https://www.dm.unibo.it/archivio-pls/it"
    config.project_hightlights = config.project_hightlights = [734, 742]
  end
end
