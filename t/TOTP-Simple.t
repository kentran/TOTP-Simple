# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl TOTP-Simple.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 6;
BEGIN { use_ok('TOTP::Simple') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

ok (1);

my $totp = TOTP::Simple->new();

ok ($totp);

my $digits = $totp->now();

ok ($digits);

my $totp2 = TOTP::Simple->new("IO2NZPTG4K6E4DNW");

ok ($totp2);

my $digits2 = $totp2->now();

ok ($digits2);
