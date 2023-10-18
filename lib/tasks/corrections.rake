namespace :pls do
  desc "correct resource type"
  task correct_resource_type: :environment do
    connection = ActiveRecord::Base.connection
    Resource.find_each do |resource|
      if resource.image?
        connection.execute("UPDATE resources SET typology='image' where id=#{resource.id.to_i}")
      elsif resource.video?
        connection.execute("UPDATE resources SET typology='video' where id=#{resource.id.to_i}")
      elsif !resource.url.blank?
        connection.execute("UPDATE resources SET typology='url' where id=#{resource.id.to_i}")
      else
        connection.execute("UPDATE resources SET typology='document' where id=#{resource.id.to_i}")
      end
    end
  end
end
