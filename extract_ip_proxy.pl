#!/user/bin/perl -w
use strict;
use LWP::UserAgent;
use HTTP::Request; 
use HTTP::Cookies; 
use LWP::ConnCache;
use URI::URL;

my $user_agent = new LWP::UserAgent();
#my $url="http://www.itmop.com/proxy/post/1889.html";
my $url="http://www.freeproxylists.net/?pr=HTTP&page=1";
my $response = $user_agent->get($url);

my $page = $response->{_content};
print $page."\n";

while ($page =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?(\d{2,6}).*?(HTTP[S]?)/ig )
{
	print $1."\t".$2."\t".$3."\n";
}
