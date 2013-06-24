# encoding: utf-8
Dir.chdir File.dirname __FILE__
require 'bundler/setup'
Bundler.require :default

set :views, 'templates'
set :public_folder, 'assets'

helpers do
  def jquery(version = '1.8.3')
    "<script src='//ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js'></script>"
  end

  def fotorama_css(version = '4.1.5')
    "<link rel='stylesheet' href='//fotorama.s3.amazonaws.com/#{version}/fotorama.css'/>"
  end

  def fotorama_js(version = '4.1.5')
    "<script src='//fotorama.s3.amazonaws.com/#{version}/fotorama.js'></script>"
  end

  def fotorama(version = '4.1.5')
    fotorama_css(version) + fotorama_js(version)
  end
end

get '/style.css' do
  content_type 'text/css', charset: 'utf-8'
  sass :style, Compass.sass_engine_options.merge(views: '.', style: :compact)
end

get '/' do
  call env.merge 'PATH_INFO' => '/index'
end

get '/*/?' do |page|
  slim page.to_sym
end
