#!/usr/bin/env ruby

require 'sinatra'
require 'json'

version = '0.0.2'

get '/' do
    'this is fundz version ' + version
end

get '/status' do
    content_type :json
    { :name => 'fundz', :status => 'ok', :version => version }.to_json
end

