#!c:\cygwin\bin\awk -f

BEGIN {
	nbr="";
	sri_present=0;
	FS=" ";
}

# To be called when neighbor changes or when section changes.
function print_sri()
{
	if(nbr != "" && sri_present==0)
		printf("  %s soft-reconfiguration inbound\n", nbr);
	nbr="";
	sri_present=0;
}

/^router bgp / { print_sri(); print $0; }

/^ *address-family / { print_sri(); print $0; }

/^ *neighbor/ {
	if(nbr != sprintf("%s %s", $1, $2))
	{
		print_sri();
		nbr=sprintf("%s %s", $1, $2);
	}
	if(match($0, /soft-reconfiguration inbound/))
		sri_present=1;
}

! /^ *neighbor/ { print_sri(); }
