ActionController::Base.asset_host = Proc.new { |source, request|
  if request.env["REQUEST_PATH"].include? ".pdf"
    "file://#{Rails.root.join('public')}"
  else
    "#{request.protocol}#{request.host_with_port}"
  end
}

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '2.1'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
