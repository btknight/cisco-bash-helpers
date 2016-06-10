#!c:\cygwin\bin\awk -f

BEGIN {
  vrf="";
  rd="";
  FS=" ";
}

{ $0 = substr($0, 4); }

$0 ~ /te Distinguisher:/ {
  ret = match($0, /te Distinguisher: ([0-9:]*)/, rds);
  rd = rds[1];
  vrf = "";
}

$0 ~ /default for vrf/ {
  ret = match($0, /default for vrf ([0-9:]*)/, vrfs);
  vrf = vrfs[1];
}

/^...[0-9\.]*\/30/ { print $1, rd, vrf; }
