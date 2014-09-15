#!/user/bin/perl -w
package MimicUser;
use strict;
use LWP::UserAgent;
use HTTP::Request; 
use HTTP::Cookies; 
use LWP::ConnCache;
use Data::Dumper;
use URI::URL;

sub new {
	my $class = shift;
	my ($protocal,$host,$agentFile,$docListFile) = @_;
#read agent from file
	my $agent = &randomAgent($agentFile);
	print "agent:".$agent."\n";
#read doc list from file
	my $urlHashRef = &readUrl($docListFile);

#new user agent
	my $user_agent = new LWP::UserAgent();
	$user_agent->cookie_jar(HTTP::Cookies->new);
	$user_agent->agent($agent);
	$user_agent->timeout(30);
	print "protocal:${protocal}://$host"."\n";
	$user_agent->proxy($protocal,"${protocal}://$host");
	$user_agent->conn_cache(LWP::ConnCache->new);
	$user_agent->default_header('Accept-Encoding'=>'gzip, deflate');
	$user_agent->default_header('Accept-Language'=>'zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3');
	$user_agent->default_header('Accept'=>'image/gif, image/jpeg, text/html,application/xhtml+xml,application/xml,*/*;q=0.9,*/*;q=0.8');

my $self = {
	browser => $user_agent,
	urlList => $urlHashRef,
	hostname => $host,
	ref360 => 'http://www.so.com/s?ie=utf-8&shb=1&src=360sou_newhome&q=',
	refbd => 'http://jingyan.baidu.com/search?word='
};

	bless $self, $class;
	return $self;
}

sub clickStream {
	my ($self) = @_;
	my $browser = $self->{browser};
	my $urlList = $self->{urlList};
	my $hostname = $self->{hostname};
	my $firstUrl = &randomeUrl($urlList);
	my $ref="";
	if( &genRandom(2) == 1 ){
		$ref =  $self->{ref360};
	}else{
		$ref = $self->{refbd};
	}
	my $kw = $urlList->{$firstUrl};
	my $referer = &refUrl($ref,$kw);

	#access ref first
	$browser->get($referer);
	# do the real access
	print "host: ${hostname}"."\n";
	print Dumper($firstUrl);
#the fist time refer from 360 search or jingyan search 
	my $response = $browser->get($firstUrl, 'Referer' => $referer);
#print $response->{_content};
 	my $docSize = keys %{$urlList};
	while( $docSize > 0 ){
		$docSize -= 1;
		my $curUrl = &randomeUrl($urlList);
		if( $curUrl eq $firstUrl ){
			next;
		}
		#90% probability click this article
		if( &genRandom(100) < 60 ){
		#sleep 0-6 min
		my $sleepTime = &genRandom(200) + 30;
		print "${hostname} sleep $sleepTime secds ..."."\n";
		sleep( $sleepTime );
		#get url
		my $response = $browser->get($curUrl, 'Referer' => $firstUrl);
		print "host: ${hostname}"."\n";
		print Dumper($curUrl);
		}
	}
}
sub refUrl {
	my ( $base, $kw) = @_;
	my $encoded = URI::URL->new( $kw );
	return $base.$encoded;
};
sub readUrl {
	my $file = shift;
	open( URLS, $file);
	my @urls = <URLS>;
	my %urlhash;
	foreach my $url (@urls){
		chomp($url);
		my @kwUrl = split(/\t/,$url);
		$urlhash{$kwUrl[0]}=$kwUrl[1];
	}
	close(URLS);
	return \%urlhash;
};
sub randomeUrl {
	my $urlhash = shift;
	my @allkeys = keys %{$urlhash};
	my $size = @allkeys;
	my $random = &genRandom($size);
	my $result = $allkeys[$random];
	return $result;
};
sub randomAgent {
    my $agfile = shift;
    open( AGENT, $agfile );
    my @agents = <AGENT>;
    my $size = @agents;
    my $random = &genRandom($size);
    my $result = $agents[$random];
	close(AGENT);
    return $result;
};
sub genRandom {
	my $maxnum = shift;
	return int( rand($maxnum));
};
1;
