#!c:\cygwin\bin\awk -f

BEGIN {
	FS="";
	space="^ ";
	p=0;
	afsec=0;
}

# If we are considered in the config section and the number of spaces
# matches, print the line

$0 ~ space && p == 1 { print; }

# If we are considered in the config section and the number of spaces
# does not match,
#  then if the line is a comment, print the line anyway
#  but if the line is not, we are no longer in the section - set p=0

$0 !~ space && p == 1 {
	if ($0 ~ "^!")
		print;
	else
		p=0;
}

# If we have a match on the searchexp and we are not in a section,
# we are now in one
#  compute the number of spaces and add that to the "space" variable
#  (used above to test lines whether we are in a section or not)

$0 ~ searchexp && p == 0 {
	print;
	ret = match($0, /^( *)/, spaces);
	space=sprintf("^%s ", spaces[1]);
	# printf ("ret=%d, space=%s, space_len=%d\n", ret, space, length(space));

	# Thanks, Cisco, for making the address-family command within
	# BGP config the exception to the rule.
	# If this is an address-family config, make the spaces equal
	# to what prefaces the start line.
	# Set the special afsec variable to 1.
	if (searchexp ~ /address-family/) {
		ac = 1;
		space=sprintf("^%s", spaces[1]);
	}
	# printf ("ret=%d, space=%s, space_len=%d\n", ret, space, length(space));
	p=1;
}

# If we are in address-family search mode, and we encounter a line
# that says exit-address-family, this is the end of the section.
/exit-address-family/ && ac == 1 {
	p=0;
	ac=0;
}

# { printf("%d: p=%d, ac=%d, space='%s'\n", NR, p, ac, space); }
