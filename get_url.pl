#!/user/bin/perl -w
use strict;
use LWP::UserAgent;
use HTTP::Request; 
use HTTP::Cookies; 
use LWP::ConnCache;
use URI::URL;

my %headers=('Accept'=>'image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/QVOD,text/html,application/xhtml+xml,application/xml, */*;q=0.9,*/*;q=0.8',
'Accept-Encoding'=>'gzip, deflate',
'Accept-Language'=>'zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3'
);
my $query="如何制定周期性的约会，会议提醒";
#http://jingyan.baidu.com/search?word=
my $ref = 'http://www.so.com/s?ie=utf-8&shb=1&src=360sou_newhome&q=';
#set ref
my $encoded = URI::URL->new( $query );
print $encoded."\n";
my $referer = $ref.$encoded;

my $user_agent = new LWP::UserAgent();
$user_agent->cookie_jar(HTTP::Cookies->new);
$user_agent->agent("Mozilla/4.76 [en] (Windows NT 5.0; U)");
$user_agent->timeout(30);
$user_agent->proxy('http',"http://211.151.13.22:81");
$user_agent->conn_cache(LWP::ConnCache->new);
#$user_agent->default_header('Accept-Encoding'=>'gzip, deflate');
$user_agent->default_header('Accept-Language'=>'zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3');
$user_agent->default_header('Accept'=>'image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/QVOD,text/html,application/xhtml+xml,application/xml, */*;q=0.9,*/*;q=0.8');
my $url="http://jingyan.baidu.com/article/09ea3ede3a2797c0afde3941.html";
my $response = $user_agent->get($url,
'Referer' => $referer);

open FILEHANDLE, ">oschina.txt";

print FILEHANDLE $response->{_content};

close FILEHANDLE;
