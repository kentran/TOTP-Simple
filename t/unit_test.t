use strict;

use Test;

BEGIN { plan tests => 5 }
use TOTP::Simple;

ok (1);

my $totp = TOTP::Simple->new();

ok ($totp);

my $digits = $totp->now();

ok ($digits);

my $totp2 = TOTP::Simple->new("IO2NZPTG4K6E4DNW");

ok ($totp2);

my $digits2 = $totp2->now();

ok ($digits2);
