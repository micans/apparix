#!/usr/bin/perl

use strict;
use warnings;

local $/ = undef;
open(R, '<README.md') || die "No read";
open(S, '>rrrrme.md') || die "No write";

my $text = <R>; close(R);

my $anchor = 'ahoy helper function):';
my $ahoy = qx{'bash' '-c' 'source .bourne-apparix; ahoy'};

if ($text =~ s/\Q$anchor\E\s+```(.*?)```/$anchor\n\n```\n$ahoy```/s) {
  print S "$text";
}

close(S);
print STDERR "Updated file written to rrrrme.md. Executing diff:\n";

system 'diff', 'README.md', 'rrrrme.md';

