package TOTP::Simple;

use 5.012003;
use strict;
use warnings;
use TOTP::OTP;

require Exporter;

our @ISA = qw(Exporter TOTP::OTP);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use TOTP::Simple ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';


# Preloaded methods go here.

sub new 
{
        my ($class, $secret, $digits, $digest, $interval) = @_; 
        $interval = 30 unless defined $interval;

        my $self = $class->SUPER::new($secret, $digits, $digest);

        $self->{_interval} = $interval;

        bless $self, $class;
        return $self;
}

sub at 
{
        my ($self, $for_time) = @_; 
        return $self->generate_otp($self->timecode($for_time));
}

sub verify
{
        my ($self, $otp, $for_time) = @_; 

        $for_time = time() unless defined $for_time; 

        return $otp == $self->at($for_time);
}

sub now 
{
        my $self = shift;
    
        return $self->generate_otp($self->timecode(time()));
}

sub timecode 
{
        my ($self, $for_time) = @_; 

        my $i = $for_time;
        return int($i / $self->{_interval});
}

sub provisioning_uri
{
        my ($self, $name) = @_;
        my $secret = $self->{_secret} or die "secret cannot be empty";

        return "otpauth://totp/$name?secret=$secret";
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

TOTP::Simple - Perl extension for blah blah blah

=head1 SYNOPSIS

  use TOTP::Simple;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for TOTP::Simple, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Ken Tran, E<lt>gonewiththewind152@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Ken Tran

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.3 or,
at your option, any later version of Perl 5 you may have available.


=cut
