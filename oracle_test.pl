#!/usr/bin/perl

use strict;
use DBI;

#Take Env Variable
my $workdir = $ENV{'MYWORKINGDIR'};  #Takes the variables

print "Hello World\n";

#database

my $db = DBI->connect("dbi:Oracle:host=your.database.host;sid=yoursid;port=yourport","youruser/yourpassword", "") || die( $DBI::errstr . "\n" );

$db->{AutoCommit}    = 0;
$db->{RaiseError}    = 1;
$db->{ora_check_sql} = 0;
$db->{RowCacheSize}  = 16;

my $SEL = "SELECT * FROM dual";
my $sth = $db->prepare($SEL);
$sth->execute();
 
while ( my @row = $sth->fetchrow_array() ) {
    foreach (@row) {
        $_ = "\t" if !defined($_);
        print "$_\t";
    }
    print "\n";
}
 
END {
    $db->disconnect if defined($db);
}


print "----- End of perl file ------\n"
