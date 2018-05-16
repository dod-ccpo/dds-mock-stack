#!/usr/bin/env perl

use Mojolicious::Lite;
use experimental 'signatures';

our $VERSION = "0.0.1";

plugin 'yaml_config';

app->helper( version => sub { "$VERSION" } );

# User agents for services
for my $service (qw/cloud fundz/) {
    helper $service => sub($c) {
        my $base = Mojo::URL->new( $c->config->{services}{$service}->{url} );
        $c->ua->on(start => sub ($ua,$tx) {
            $tx->req->url->host($base->host);
            $tx->req->url->port($base->port);
        });
        $c->ua;
    };
}

get '/' => 'index';

get '/status' => {json => {version => $VERSION, status => 'ok', name => 'atat' }};

app->start;

__DATA__
@@ index.html.ep
<h1>AT-AT version <%= version %></h1>

<pre>
<h1>cloud</h1>
%= config->{services}{cloud}{url};
%= dumper( cloud->get('/status')->result->json );

<h1>fundz</h1>
%= config->{services}{fundz}{url};
%= dumper( fundz->get('/status')->result->json );
</pre>

