#!/usr/bin/env perl

use Mojolicious::Lite;

get '/' => {text => 'authz!'};

get '/status' => {
    json => {name => 'authz', status => 'ok', version => '0.0.3'}
};

app->start;

