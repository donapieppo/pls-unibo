require 'json' 

# https://dati.istruzione.it/opendata/opendata/catalogo/elements1/leaf/?area=Scuole&datasetId=DS0400SCUANAGRAFESTAT
# https://dati.istruzione.it/opendata/opendata/catalogo/elements1/?area=Scuole
#
# togliere solo SCUOLA INFANZIA SCUOLA PRIMARIA SCUOLA PRIMO GRADO
#
#JSON_FILE = "/home/rails/pls-unibo/doc/SCUANAGRAFESTAT20222320220901.json"; PARITARIE = false
JSON_FILE = "/home/rails/pls-unibo/doc/SCUANAGRAFEPAR20222320220901.json"; PARITARIE = true

def ok?(str)
  str =~ /IST [PROF|TEC]/ || str =~ /ISTITUTO / || str =~ /LICEO / || str =~ /SCUOLA MAGISTRALE/ || str =~ /SCUOLA SEC\. SECONDO GRADO/
end

namespace :pls do
  desc "informazioni sul json delle scuole"
  task json_informations: :environment do
    f = File.read(JSON_FILE)
    JSON.parse(f)["@graph"].each do |row|
      puts row["miur:DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA"]
    end
  end

  desc "aggiorna le scuole dal json scaricato da https://dati.istruzione.it/opendata/opendata/catalogo/elements1/?area=Scuole"
  task update_schools: :environment do
    f = File.read(JSON_FILE)
    JSON.parse(f)["@graph"].each do |row|
      # non prendiamo  
      # CodiceScuola: Testo Codice della scuola (plesso)
      # CodiceIstitutoRiferimento: Testo Codice dell' istituto a cui fa riferimento la scuola (plesso)
      unless PARITARIE
        next unless row["miur:CODICEISTITUTORIFERIMENTO"] == row["miur:CODICESCUOLA"]
      end
      next unless ok?(row["miur:DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA"])

      row.each do |k, v|
        row[k] = nil if v == 'Non Disponibile' 
      end

      name = row['miur:DENOMINAZIONESCUOLA'].strip.gsub(/^"(.*)"/, '\1')

      s = School.find_or_initialize_by(code: row['miur:CODICESCUOLA'])
      s.attributes = { name: name, 
                       school_type: row['miur:DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA'],
                       email: row['miur:INDIRIZZOEMAILSCUOLA'],
                       pec_email: row['miur:INDIRIZZOPECSCUOLA'],
                       url: row['miur:SITOWEBSCUOLA'],
                       province: row['miur:PROVINCIA'],
                       municipality: row['miur:DESCRIZIONECOMUNE'],
                       cap: row['miur:CAPSCUOLA'].to_i,
                       address: row['miur:INDIRIZZOSCUOLA'], 
                       private_school: PARITARIE }
      s.save!
      p s
    end
  end

  desc "Pulisce i dati del miur"
  task clean_schools: :environment do
    School.find_each do |s|
      name2 = s.name.gsub('"', '').strip
      if name2 != s.name
        puts "#{s.name} -> #{name2}"
        s.update(name: name2)
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

