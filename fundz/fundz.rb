#!/usr/bin/env ruby

require 'sinatra'
require 'json'

get '/' do
    'this is fundz version 0.0.2'
end

get '/status' do
    content_type :json
    { :name => 'fundz', :status => 'ok', :version => '0.0.2' }.to_json
end

