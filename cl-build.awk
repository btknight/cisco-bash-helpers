#!/usr/bin/gawk -f
#
# cl-build.awk
#
# one-off script to help with goofy L3VPN turnup in CHI1 2015-08-17

BEGIN {
	FS="\t"
}

{ 
	n = "    neighbor " $3 " ";
	print "interface Gig0/0/2." $2;
	print "  encapsulation dot1Q " $2;
	print "  no cdp enable";
	print "  description |MPLS|5M|CVPN:" $1 "|" $3;
	print "  ip vrf forwarding NNI-HOLD";
	print "  ip address " $4 " 255.255.255.252";
	print "  no shutdown";
	print "  no ip redirects";
	print "  no ip directed-broadcast";
	print "  no ip proxy-arp";
	print "  no cdp enable";
	print "router bgp 53828";
	print "  address-family ipv4 vrf NNI-HOLD";
	print n "remote-as 209";
	print n "description |CVPN:" $1 "|" $3;
	print n "activate";
	print n "send-community both";
	print n "soft-reconfig inbound";
	print n "maximum-prefix 500 80 restart 1";
}
