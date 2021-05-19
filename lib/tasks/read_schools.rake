require 'json' 

JSON_FILE = "/home/rails/pls-unibo/doc/scuole.json"

def ok?(str)
  str =~ /IST PROF/ ||
  str =~ /IST TEC/ || 
  str =~ /ISTITUTO D'ARTE/ ||
  str =~ /ISTITUTO MAGISTRALE/ ||
  str =~ /ISTITUTO SUPERIORE/ ||
  str =~ /ISTITUTO TECNICO/ ||
  str =~ /LICEO/ ||
  str =~ /CUOLA MAGISTRALE/
end
namespace :pls do
  desc "inserisce le scuole dal json"
  task :insert_schools => :environment do
    f = File.read(JSON_FILE)
    JSON.parse(f)["@graph"].each do |row|
      if row["miur:CODICEISTITUTORIFERIMENTO"] == row["miur:CODICESCUOLA"] && ok?(row["miur:DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA"])
        row.each do |k, v|
          row[k] = nil if v == 'Non Disponibile' 
        end
        School.create(name: row['miur:DENOMINAZIONESCUOLA'],
                      code: row['miur:CODICESCUOLA'],
                      school_type: row['miur:DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA'],
                      email: row['miur:INDIRIZZOEMAILSCUOLA'],
                      pec_email: row['miur:INDIRIZZOPECSCUOLA'],
                      url: row['miur:SITOWEBSCUOLA'],
                      province: row['miur:PROVINCIA'],
                      municipality: row['miur:DESCRIZIONECOMUNE'],
                      cap: row['miur:CAPSCUOLA'].to_i,
                      address: row['miur:INDIRIZZOSCUOLA'])
      end
    end
  end
end

# "@id"=>"_:b0", "http://w3c/future-csv-vocab/row"=>5106, 
# "miur:ANNOSCOLASTICO"=>202021.0, "miur:AREAGEOGRAFICA"=>"ISOLE", "miur:CAPSCUOLA"=>7010.0, 
# "miur:CODICECOMUNESCUOLA"=>"A379", "miur:CODICEISTITUTORIFERIMENTO"=>"SSIC848002", 
# "miur:CODICESCUOLA"=>"SSEE84809C", "miur:DENOMINAZIONEISTITUTORIFERIMENTO"=>"ISTITUTO COMPRENSIVO OZIERI", 
# "miur:DENOMINAZIONESCUOLA"=>"GIOVANNA FRANCESCA MARONGIU", "miur:DESCRIZIONECARATTERISTICASCUOLA"=>"NORMALE", 
# "miur:DESCRIZIONECOMUNE"=>"ARDARA", "miur:DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA"=>"SCUOLA PRIMARIA", 
# "miur:INDICAZIONESEDEDIRETTIVO"=>"NO", "miur:INDICAZIONESEDEOMNICOMPRENSIVO"=>"Non Disponibile", 
# "miur:INDIRIZZOEMAILSCUOLA"=>"SSIC848002@istruzione.it", "miur:INDIRIZZOPECSCUOLA"=>"Non Disponibile", 
# "miur:INDIRIZZOSCUOLA"=>"VIA SASSARI", "miur:PROVINCIA"=>"SASSARI", "miur:REGIONE"=>"SARDEGNA", 
# "miur:SEDESCOLASTICA"=>"NO", "miur:SITOWEBSCUOLA"=>"www.dirdidozieri2.it"

