#!c:\cygwin\bin\awk -f

BEGIN {
	FS="";
	space="^ ";
	nsl=0;
	p=0;
}

function printorstore(line)
{
	if(p == 0) {
		sectionlines[nsl] = line;
		nsl++;
	}
	if(p == 1)
		print line;
}

function printsectionlines()
{
	for(i = 0; i < nsl; i++) {
		print sectionlines[i];
	}
	purgesectionlines();
}

function purgesectionlines()
{
	for(i = nsl-1; i >= 0; i--) {
		delete sectionlines[i];
	}
	nsl = 0;
}

# If this line does not start w/ a space and is not a comment,
# purge the buffer

$0 !~ space && $0 !~ "^!" {
	p = 0;
	purgesectionlines();
}

# If we have a match on the searchexp, immediately dump all lines
# in the buffer array

$0 ~ searchexp && p == 0 {
	p = 1;
	printsectionlines();
}

# For all lines...

{
	printorstore($0);
}
