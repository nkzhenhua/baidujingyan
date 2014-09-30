#!/user/bin/perl -w 
use strict;
use MimicUser;
use threads;
#user number parallel
my $ipNumber= $ARGV[0];
my $userNumber = $ARGV[1];
print "ipNumber:${ipNumber};userNumber:${userNumber}"."\n";
open( IPFILE, 'ip.data');
my @ips = <IPFILE>;
close(IPFILE);
my $threadNum=0;
my @threads;
my $size = @ips;
my %taken;
#foreach my $ip ( @ips ){
while( $ipNumber > 0 ) {
	my $idx = int( rand( $size ));
	my $ip = $ips[$idx];
	if( exists $taken{$ip} ){
		sleep(2);
		next;
	}else{
		$taken{$ip}=1;
	}
	$ipNumber --;
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
