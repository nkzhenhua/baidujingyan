#!/user/bin/perl -w 
use strict;
use MimicUser;
use threads;
#user number parallel
my $userNumber = 10;
open( IPFILE, 'ip.data');
my @ips = <IPFILE>;
my $threadNum=0;
my @threads;
my $size = @ips;
#foreach my $ip ( @ips ){
while( 1 ) {
	my $idx = int( rand( $size ));
	my $ip = $ips[$idx];
	my $threadid = threads->new(\&userthread, $ip);
	push( @threads, $threadid);
	$threadNum += 1;
	if( $threadNum == $userNumber ){
		print "wait for thread finish"."\n";
		while(@threads){
			$threadid = pop(@threads);
			$threadid->join();
		}
		$threadNum = 0;
	}
	sleep( int(rand(100)));
}

sub userthread {
	my ( $userinfo ) = @_;
	chomp($userinfo);
	print "create thread for $userinfo"."\n";
	my ( $host,$port,$protocal) = split(/\t/,$userinfo);
	my $user1 = new MimicUser(${protocal},"$host:$port","ie_agent.data","docs.data");
	$user1->clickStream();
	print "out thread for $userinfo"."\n";
}
