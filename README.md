Iplist
======

Given an IP range as a string (either CIDR or start..finish), list all IP numbers in the range.

Usage:

  cat foo | mix run -e Iplist.Lister.readlines

Where foo contains lines such as;

  1.2.3.4
  1.2.3.0/24
  1.2.3.4..1.2.3.5

Output is a list of IPs, one per line
