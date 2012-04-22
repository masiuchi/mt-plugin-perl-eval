package MT::Plugin::PerlEval;
use strict;
use warnings;
use base 'MT::Plugin';

our $VER  = '0.01';
our $NAME = ( split /::/, __PACKAGE__ )[-1];

my $plugin = __PACKAGE__->new({
    name        => $NAME,
    id          => lc $NAME,
    key         => lc $NAME,
    version     => $VER,
    author_name => 'masiuchi',
    author_link => 'https://github.com/masiuchi/',
    plugin_link => 'https://github.com/masiuchi/mt-plugin-perl-eval/',
    description => 'You can write perl codes in "MTPerlEval" tag.',
    registry => {
        tags => {
            block => {
                PerlEval => \&_perl_eval,
            },
        },
    },
});
MT->add_plugin( $plugin );

sub _perl_eval {
    my ( $ctx, $args, $cond ) = @_;

    my $uncompiled = $ctx->stash( 'uncompiled' );
    my $eval       = eval $uncompiled;
    if ( $@ ) {
        $eval = $@;
    }

    return $eval;
}

1;
__END__
