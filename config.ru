$:.unshift File.expand_path("../", __FILE__)
require "./server"
require 'rubygems'
require 'sinatra'
require './web'
run Sinatra::Application
