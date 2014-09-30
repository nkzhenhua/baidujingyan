#!/user/bin/perl -w
use strict;
my @page = <>;
foreach my $line ( @page){
	while ($line =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?(\d{2,6})(.*?)(高匿|匿名)/sigm )
	{
		my $ip = $1;
		my $port = $2;
		print $ip."\t".$port."\t"."http\n";
	}
}
