# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

asset_filter = lambda do |filename, path|
  path =~ /app\/assets/ && 
    %w(.js .css).include?(File.extname(filename)) &&
    filename.first != '_'
end
Rails.application.config.assets.precompile << asset_filter


