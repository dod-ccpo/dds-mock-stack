#!/usr/bin/env perl

use Mojolicious::Lite;
use experimental 'signatures';

our $VERSION = 0.0.1;

plugin 'yaml_config';

get '/' => sub($c) {
  for my $service (qw/cloud fundz/) {
    my $url = Mojo::URL->new($c->config->{services}{$service}->{url})
      ->path('/status');
    my $tx = $c->ua->get($url);
    if (my $res = $tx->success) {
      $c->stash($service => $res->json);
    }
    else {
      $c->stash($service => $tx->{error} // 'no connection');
    }
  }
} => 'index';

get '/status' => {json => {version => $VERSION, status => 'ok'}};

app->start;

__DATA__
@@ index.html.ep
This is AT-AT.

<pre>
%= dumper(config);
</pre>

<h1>cloud</h1>
<pre>
%= dumper(stash 'cloud');
</pre>

<h1>fundz</h1>
<pre>
%= dumper(stash 'fundz');
</pre>

