#!c:\cygwin\bin\awk -f

BEGIN {
	nbr="";
	vrf="";
	FS=" ";
}

# To be called when neighbor changes or when section changes.
function print_sri()
{
	if(nbr != "")
		printf("clear ip bgp %s vrf %s soft\n", nbr, vrf);
	nbr="";
}

/^router bgp / { print_sri(); print $0; }

/^ *address-family / { print_sri(); vrf=$4; }

/^ *neighbor/ {
	if(nbr != $2)
	{
		print_sri();
		nbr=$2;
	}
}

! /^ *neighbor/ { print_sri(); }
