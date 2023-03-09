package App::ModuleReleaseSelectUtils;

use 5.010001;
use strict;
use warnings;
use Log::ger;

# AUTHORITY
# DATE
# DIST
# VERSION

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Utilities related to Module::Release::Select',
};

$SPEC{check_release_matches} = {
    v => 1.1,
    summary => "Given an expression and one or more releases, show which releases match the expression",
    args => {
        expr => {
            schema => 'str*',
            req => 1,
            pos => 0,
        },
        releases => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'release',
            schema => ['array*', of=>'str*'],
            req => 1,
            pos => 1,
            slurpy => 1,
        },
        quiet => {
            schema => 'bool*',
            cmdline_aliases => {q=>{}},
        },
    },
    examples => [
        {
            argv => [">1.31", "0.23", "1.3", "1.31", "1.8"],
            test => 0,
        },
    ],
};
sub check_release_matches {
    require Module::Release::Select;
    my %args = @_;

    my @rels = Module::Release::Select::select_releases($args{expr}, $args{releases});

    if (@rels) {
        return [200, "OK (matches)", $args{quiet} ? "Release(s) match expression" : undef, {"cmdline.exit_code"=>0}];
    } else {
        return [200, "OK (no match)", $args{quiet} ? "Release(s) do NOT match expression" : undef, {"cmdline.exit_code"=>1}];
    }
}

1;
# ABSTRACT:

=head1 DESCRIPTION

This distribution contains the following CLI utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<Module::Release::Select>
