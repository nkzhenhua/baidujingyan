#!/user/bin/perl -w 
use strict;
use MimicUser;

#my $user1 = new MimicUser("socket","123.133.25.137:6668","ie_agent.data","docs.data");
#my $user1 = new MimicUser("https","183.221.217.144:8123","ie_agent.data","docs.data");
my $user1 = new MimicUser("socket","115.236.59.194:3128","ie_agent.data","docs.data");
$user1->clickStream();

