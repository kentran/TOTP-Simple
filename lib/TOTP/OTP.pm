package TOTP::OTP;

use strict;
use Digest::HMAC;
use Digest::SHA1;
use Convert::Base32;

sub new 
{
	my ($class, $secret, $digits, $digest) = @_;
	$digest = "Digest::SHA1" unless defined $digest;
	$digits = 6 unless defined $digits;
        $secret = &random_base32() unless defined $secret;

	my $self = {
		_secret	=> $secret,
		_digits => $digits,
		_digest => $digest,
	};

	bless $self, $class;
	return $self;
}

sub random_base32
{
	my ($self, $length) = @_;
	$length = 16 unless defined $length;

	my $s = "234567QWERTYUIOPASDFGHJKLZXCVBNM";
	my @b32 = split('', $s);

	my $result = "";

	for (my $i = 0; $i < $length; $i ++)
	{
		$result .= $b32[rand(32)];
	}

	return $result;
}

sub generate_otp 
{
	my ($self, $input) = @_;

	my $hmac = Digest::HMAC->new(
		$self->byte_secret(),
		$self->{_digest}
	);
	$hmac->add($self->int_to_bytestring($input));
	my $hmac_hash = $hmac->digest();

        my @hmac_hash = split("", $hmac_hash);
        my $offset = ord($hmac_hash[19]) & 0xf;
	my $code = ((ord($hmac_hash[$offset]) & 0x7f) << 24 |
		(ord($hmac_hash[$offset + 1]) & 0xff) << 16 |
		(ord($hmac_hash[$offset + 2]) & 0xff) << 8 |
		(ord($hmac_hash[$offset + 3]) & 0xff));
	
	return $code % 10 ** $self->{_digits};
}

sub byte_secret 
{
	my $self = shift;

	return decode_base32($self->{_secret});
}

sub int_to_bytestring 
{
	my ($self, $int) = @_;
	return pack('N*', 0) . pack('N*', $int);	
}
1;
