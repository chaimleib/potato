# Be sure to restart your server when you modify this file.
assets = Rails.application.config.assets
# Version of your assets, change this if you want to expire all your assets.
assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
assets.paths += [
  %w(vendor assets components bootstrap-sass assets fonts),
].map{|pathlist| Rails.root.join(*pathlist)}

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

app_asset_filter = lambda {|filename, path|
  return false if filename.first == '_'
  path =~ /app\/assets/ && 
    %w(.js .css).include?(File.extname(filename))
}
bootstrap_font_filter = lambda {|filename, path|
  return false if filename.first == '_'
  path =~ /bootstrap-sass\/assets\/fonts\/bootstrap/ && 
    %w(.eot .svg .woff2 .woff .ttf).include?(File.extname(filename))
}

assets.precompile += [
  app_asset_filter,
  bootstrap_font_filter
]

# sprockets.append_path Rails.root.join('vendor', 'assets', 'components', 'bootstrap-sass', 'assets')
