use strict;
use warnings;
use List::Util 1.33;
use Test::More tests => 26;
use lib '../../../lib',;
use DateTimeX::Format::Excel;
BEGIN{
	$ENV{PERL_TYPE_TINY_XS} = 0;
}

sub round {
  my $v = shift;
  return sprintf('%9.7f', $v);
}  

my @test_data = (
    {   year    => 2003,
        month   => 2,
        day     => 28,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 37680,
        iso8601 => '2003-02-28T00:00:00',
    },
    #~ {   year    => 1899,#Not really an Excel result
        #~ month   => 12,
        #~ day     => 31,
        #~ hour    => 0,
        #~ minute  => 0,
        #~ second  => 0,
        #~ excel   => 1,
        #~ iso8601 => '1899-12-31T00:00:00',
    #~ },
    {   year    => 1900,
        month   => 1,
        day     => 1,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 1,#DateTime Excel gives 2
        iso8601 => '1900-01-01T00:00:00',
    },
    {   year    => 1900,
        month   => 1,
        day     => 2,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 2,#DateTime Excel gives 3
        iso8601 => '1900-01-02T00:00:00',
    },
    {   year    => 1900,
        month   => 1,
        day     => 3,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 3,#DateTime Excel gives 4
        iso8601 => '1900-01-03T00:00:00',
    },
    {   year    => 1970,
        month   => 1,
        day     => 1,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 25569,
        iso8601 => '1970-01-01T00:00:00',
    },
    {   year    => 9999,
        month   => 12,
        day     => 31,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 2958465,
        iso8601 => '9999-12-31T00:00:00',
    },
    {   year    => 1900,
        month   => 2,
        day     => 28,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 59,#DateTime Excel gives 60
        iso8601 => '1900-02-28T00:00:00',
    },
    {   year    => 1900,
        month   => 3,
        day     => 1,
        hour    => 0,
        minute  => 0,
        second  => 0,
        excel   => 61,
        iso8601 => '1900-03-01T00:00:00',
    },
    {   year    => 2007,
        month   => 9,
        day     => 9,
        hour    => 23,
        minute  => 56,
        second  => 29,
        excel   => 39334.9975578706,
        iso8601 => '2007-09-09T23:56:29',
    },
    {   year    => 2007,
        month   => 9,
        day     => 9,
        hour    => 23,
        minute  => 56,
        second  => 30,
        excel   => 39334.9975694446,
        iso8601 => '2007-09-09T23:56:30',
    },
    {   year    => 2007,
        month   => 9,
        day     => 9,
        hour    => 23,
        minute  => 56,
        second  => 45,
        excel   => 39334.9977430557,
        iso8601 => '2007-09-09T23:56:45',
    },
    {   year    => 1985,
        month   => 10,
        day     => 26,
        hour    => 1,
        minute  => 17,
        second  => 00,
        excel   => 31346.0534722223,
        iso8601 => '1985-10-26T01:17:00',
    },
    {   year    => 1955,
        month   => 11,
        day     => 12,
        hour    => 9,
        minute  => 28,
        second  => 00,
        excel   => 20405.3944444442,
        iso8601 => '1955-11-12T09:28:00',
    },
);
my	$parser = DateTimeX::Format::Excel->new;
foreach my $test_data (@test_data) {
    my $dt = DateTime->new(
        year   => $test_data->{year},
        month  => $test_data->{month},
        day    => $test_data->{day},
        hour   => $test_data->{hour},
        minute => $test_data->{minute},
        second => $test_data->{second}
    );
    my $got_excel = round($parser->format_datetime($dt));
    my $testdata = round($test_data->{excel});
    is( $got_excel => $testdata, " \$got_excel ($got_excel) ~ excel ($testdata)" );
    my $got_dt      = $parser->parse_datetime( $test_data->{excel} );
    my $got_iso8601 = $got_dt->iso8601();
    is( $got_iso8601 => $test_data->{iso8601}, " \$got_iso8601 ($got_iso8601) ~ iso8601 ($test_data->{iso8601})" );
}
