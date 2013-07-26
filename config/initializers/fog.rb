module Readit
	class Application < Rails::Application
    # create a connection
    config.storage_connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => ENV['AWS_ACCESS_KEY'],
      :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY']
    })

    # First, a place to contain the glorious details
    config.storage_dir = config.storage_connection.directories.create(
      :key    => "readit-web-thumbs", # globally unique name
      :public => true
    )
  end
end