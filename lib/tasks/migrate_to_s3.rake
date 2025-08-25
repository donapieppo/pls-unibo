namespace :active_storage do
  desc "Migrate files from local storage to S3"
  task migrate_to_s3: :environment do
    ActiveStorage::Blob.first
    local_service = ActiveStorage::Service.configure(:local, Rails.configuration.active_storage.service_configurations)
    s3_service = ActiveStorage::Service.configure(:amazon, Rails.configuration.active_storage.service_configurations)

    ActiveStorage::Blob.find_each do |blob|
      next if s3_service.exist?(blob.key)
      p blob

      file = local_service.download(blob.key)
      s3_service.upload(blob.key, StringIO.new(file), checksum: blob.checksum)
      puts "Migrated #{blob.filename}"
      sleep 1
    end
  end
end
