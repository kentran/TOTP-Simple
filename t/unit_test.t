use strict;

use Test;

BEGIN { plan tests => 3 }
use TOTP::Simple;

ok (1);

my $totp = OTP::TOTP->new();

ok ($totp);

my $digits = $totp->now();

ok ($digits);
