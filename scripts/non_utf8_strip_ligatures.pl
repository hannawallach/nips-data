#!/usr/bin/perl -w

# ef ac 80 20 ef ac 81 20 ef ac 82 a 
# ef ac 83 20 ef ac 84 20 ef ac 85 a 

while (<STDIN>) {

    s/\x{ef}\x{ac}\x{80}/ff/g;
    s/\x{ef}\x{ac}\x{81}/fi/g;
    s/\x{ef}\x{ac}\x{82}/fl/g;
    s/\x{ef}\x{ac}\x{83}/ffi/g;
    s/\x{ef}\x{ac}\x{84}/ffl/g;
    s/\x{ef}\x{ac}\x{85}/ft/g;

    print;
}
