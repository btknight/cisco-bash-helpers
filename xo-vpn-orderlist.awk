function zerovalues() {
	vpn="";
	vlan="";
	ipblock="";
	lanipblock="";
}

function printvpn()
{
	if(vpn != "") {
		print "MS-" vpn "-NETWORKINNOVATIONS," vlan "," ipblock "," lanipblock;
	}
	zerovalues()
}

BEGIN {
	FS=":";
	zerovalues()
}


/Private LAN/ {
	gsub(" ", "", $2);
	gsub("\t", "", $2);
	lanipblock=$2;
}

/VPN ID/ {
	printvpn();
	gsub(" ", "", $2);
	gsub("\t", "", $2);
	vpn=$2;
}

/MESH VLAN/ {
	gsub(" ", "", $2);
	gsub("\t", "", $2);
	vlan=$2;
}

/WAN BLOCK/ {
	gsub(" ", "", $2);
	gsub("\t", "", $2);
	ipblock=$2;
}

END {
	printvpn();
}
