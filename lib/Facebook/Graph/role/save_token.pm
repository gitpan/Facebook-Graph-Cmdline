package Facebook::Graph::role::save_token;
{
  $Facebook::Graph::role::save_token::VERSION = '0.123460';
}

#ABSTRACT: Provides a save_token method to save token value to YAML config file.

use v5.10;
use Any::Moose 'Role';
use YAML::Any;

requires qw( get_config_from_file configfile token );
# MooseX::SimpleConfig or MouseX::SimpleConfig will provide
# both get_config_from_file and configfile


sub save_token
{
    my $self = shift;
    if ( !$self->configfile )
    {
        say "please save token: " . $self->token;
        return 1;
    }

    my $config = $self->get_config_from_file( $self->configfile );
    if ( !exists $config->{token} or $self->token ne $config->{token} )
    {
        $config->{token} = $self->token;
        YAML::Any::DumpFile( $self->configfile, $config );
    }
}

1;

__END__
=pod

=head1 NAME

Facebook::Graph::role::save_token - Provides a save_token method to save token value to YAML config file.

=head1 VERSION

version 0.123460

=head1 METHODS

=head2 save_token

Updates token value in configfile and saves as YAML if modified.

If configfile is not defined, the token is printed to STDOUT for manual saving.

=head1 AUTHOR

Andrew Grangaard <spazm@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Andrew Grangaard.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

