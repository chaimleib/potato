# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

app_asset_filter = lambda {|filename, path|
  path =~ /app\/assets/ && 
    %w(.js .css).include?(File.extname(filename)) &&
    filename.first != '_'
}
Rails.application.config.assets.precompile << app_asset_filter

bootstrap_font_filter = lambda {|filename, path|
  path =~ /vendor\/assets\/components\/bootstrap-sass\/assets\/fonts/ && 
    %w(.woff2 .woff .ttf).include?(File.extname(filename)) &&
    filename.first != '_'
}
Rails.application.config.assets.precompile << bootstrap_font_filter
