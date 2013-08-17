TOTP-Simple version 0.01
========================

TOTP::Simple is a perl module that creates Time-based One Time Password (TOTP).
This module is ported from the Python One Time Password Library by Nathan Reynolds
https://github.com/nathforge/pyotp

TOTP::Simple, by default, is compatible with Google Authenticator apps available for Android and IOS

##INSTALLATION

To install this module type the following:
```
   perl Makefile.PL 
   make 
   make test
   make install
```

##DEPENDENCIES

This module requires these other modules and libraries:
```
  Convert::Base32
  Digest::HMAC
  Digest::SHA1
  Test::More
```

##Usage

```
my $totp = TOTP::Simple->new('base32secret1234');
# if parameters is undefined, a random base 32 secret is generated

# Generate the 6 digits OTP for the current time
$totp->now(); # => 984979

# OTP verified for current time
$totp->verify('984979'); # => true
sleep(30);
$totp->verify('984979'); # => false
```

##Generate link for Google Authenticator
```
$totp->provisioning_uri('my_account_name'); # => 'otpauth://totp/my_account_name?secret=IO2NZPTG4K6E4DNW'
```

This can be rendered as QRCode using [HTML::QRCode](http://search.cpan.org/~hide/HTML-QRCode-0.01/lib/HTML/QRCode.pm) module

##See also:
Python Version of pyotp by [Nathan Reynolds](https://github.com/nathforge/pyotp)

