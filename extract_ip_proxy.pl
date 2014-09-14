#!/user/bin/perl -w
use strict;
use LWP::UserAgent;
use HTTP::Request; 
use HTTP::Cookies; 
use LWP::ConnCache;
use URI::URL;

my $user_agent = new LWP::UserAgent();
my @urls;
$urls[0] = "http://www.xici.net.co/";
$urls[1]="http://www.itmop.com/proxy/";
$urls[2]="http://www.xici.net.co/nn/";
$urls[3]="http://www.xici.net.co/nt/";
$urls[4]="http://www.xici.net.co/wn/";
$urls[5]="http://www.xici.net.co/wt/";
$urls[6]="http://www.xici.net.co/qq/";
$urls[7]="http://www.itmop.com/proxy/post/1889.html";

foreach my $url ( @urls ){
my $response = $user_agent->get($url);

my $page = $response->{_content};

while ($page =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?(\d{2,6}).*?(HTTP|HTTPS|QQ代理)[^S]/sigm )
{
	my $ip = $1;
	my $port = $2;
	my $type = $3;
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
