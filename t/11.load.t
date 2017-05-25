use v6;

use Test;

plan 4;

use YAML;

my $api = yaml();
my $yaml = q:to/END/;
foo: 23
seq: &seq
- a
- b
- c
seq-alias: *seq
map: &map
  a: 1
  b: 2
map-alias: *map
scalar: &s 42
scalar-alias: *s
END
my $docs = $api.load($yaml);
my %data = $docs[0];
cmp-ok(%data<foo>, '==', 23, "load works");

%data<seq>[0] = "A";
cmp-ok(%data<seq-alias>[0], 'eq', "A", "sequence aliases work");

%data<map><b>++;
cmp-ok(%data<map-alias><b>,'==', 3, "mapping aliases work");

cmp-ok(%data<scalar-alias>, '==', 42, "scalar aliases work");

done-testing;
