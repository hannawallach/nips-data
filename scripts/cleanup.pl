#!/usr/bin/perl -w

while (<STDIN>) {

    s/\x{AD}/-/g; # replace soft hyphen with "-"
    s/-\s*\n//g; # fix up words split over line breaks

    print;
}
