$:.unshift File.expand_path("../", __FILE__)
require "./server"
require 'sinatra'
run Sinatra::Application
