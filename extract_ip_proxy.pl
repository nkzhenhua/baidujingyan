#!/user/bin/perl -w
use strict;
use LWP::UserAgent;
use HTTP::Request; 
use HTTP::Cookies; 
use LWP::ConnCache;
use URI::URL;

my $user_agent = new LWP::UserAgent();
my @urls;
push(@urls,"http://www.xici.net.co/nn/");
push(@urls,"http://www.xici.net.co/wn/");
push(@urls,"http://www.xici.net.co/qq/");
push(@urls,"http://www.itmop.com/proxy/post/1889.html");
push(@urls,"http://www.itmop.com/proxy/post/1890.html");

foreach my $url ( @urls ){
my $response = $user_agent->get($url);

my $page = $response->{_content};

while ($page =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?(\d{2,6})(.*?)(HTTP|HTTPS|QQ代理)[^S]/sigm )
{
	my $ip = $1;
	my $port = $2;
	my $anoy = $3;
	my $type = $4;

	if( $anoy =~ /透明/sim){
		next;
	}
	if( $type =~ /QQ代理/i){
		$type='socket';
	}elsif( $type =~ /HTTPS/i ){
		$type = 'https';
	}elsif( $type =~ /HTTP/i ){
		$type = 'http';
	}
	print $ip."\t".$port."\t".$type."\n";
}
}


my @httpproxy;
push(@httpproxy,"http://pachong.org/anonymous.html");
foreach my $oneurl ( @httpproxy ){
$response = $user_agent->get($oneurl);

$page = $response->{_content};

while ($page =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?(\d{2,6})/sigm )
{
	my $ip = $1;
	my $port = $2;
	print $ip."\t".$port."\t".$type."\n";
}
}


