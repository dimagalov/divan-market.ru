# encoding: utf-8
Dir.chdir File.dirname __FILE__
require 'bundler/setup'
Bundler.require :default

set :views, 'templates'
set :styles, 'styles'

get '/ha/?' do
  slim :notfound, layout: false
end

get '/*.css' do |css|
  content_type 'text/css', charset: 'utf-8'
  if File.exists? file = "#{settings.styles}/#{css}.css"
    return File.read(file)
  end
  sass css.to_sym, Compass.sass_engine_options
    .merge(views: settings.styles, style: :compact)
end

get '/' do
  call env.merge 'PATH_INFO' => '/index'
end

get '/*/?' do |page|
  slim page.to_sym
end
