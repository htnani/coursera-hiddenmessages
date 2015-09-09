#!/usr/bin/env perl

# PODNAME: reverse-complement.pl
# ABSTRACT: Reverse Complement

## Author     : Ian Sealy
## Maintainer : Ian Sealy
## Created    : 2015-09-07

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use Path::Tiny;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $input_file = 'reverse-complement-sample-input.txt';
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my ($pattern) = path($input_file)->lines( { chomp => 1 } );

printf "%s\n", reverse_complement($pattern);

sub reverse_complement {
    my ($pattern) = @_;    ## no critic (ProhibitReusedNames)

    $pattern =~ tr/AGCTagct/TCGAtcga/;
    $pattern = reverse $pattern;

    return $pattern;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'input_file=s' => \$input_file,
        'debug'        => \$debug,
        'help'         => \$help,
        'man'          => \$man,
    ) or pod2usage(2);

    # Documentation
    if ($help) {
        pod2usage(1);
    }
    elsif ($man) {
        pod2usage( -verbose => 2 );
    }

    return;
}

__END__
=pod

=encoding UTF-8

=head1 NAME

reverse-complement.pl

Reverse Complement

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Reverse Complement Problem.

Input: A DNA string I<Pattern>.

Output: I<Pattern>, the reverse complement of I<Pattern>.

=head1 EXAMPLES

    perl reverse-complement.pl

    perl reverse-complement.pl --input_file reverse-complement-extra-input.txt

    diff <(perl reverse-complement.pl) reverse-complement-sample-output.txt

    diff \
        <(perl reverse-complement.pl \
            --input_file reverse-complement-extra-input.txt) \
        reverse-complement-extra-output.txt

    perl reverse-complement.pl --input_file dataset_3_2.txt \
        > dataset_3_2_output.txt

    perl reverse-complement.pl --input_file <(echo "GATTACA")

=head1 USAGE

    reverse-complement.pl
        [--input_file FILE]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--input_file FILE>

The input file containing "A DNA string I<Pattern>".

=item B<--debug>

Print debugging information.

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print this script's manual page and exit.

=back

=head1 DEPENDENCIES

None

=head1 AUTHOR

=over 4

=item *

Ian Sealy

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Ian Sealy.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
