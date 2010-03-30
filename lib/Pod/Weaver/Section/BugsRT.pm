package Pod::Weaver::Section::BugsRT;

# ABSTRACT: Add a BUGS pod section

use Moose;

with 'Pod::Weaver::Role::Section';

use Moose::Autobox;

=method weave_section

adds the BUGS section.

=cut

sub weave_section {
    my ($self, $document, $input) = @_;

    my $zilla = $input->{zilla} or return;
    my $name = $zilla->name;

    my $bugtracker =
        sprintf 'http://rt.cpan.org/Public/Dist/Display.html?Name=%s', $name;

    # I prefer all lower case emails.
    my $email = "bug-".lc($name).'@rt.cpan.org';

    my $text =
        "Please report any bugs or feature requests to $email ".
        "or through the web interface at:\n".
        " $bugtracker";

    $document->children->push(
        Pod::Elemental::Element::Nested->new({
            command => 'head1',
            content => 'BUGS',
            children => [
                Pod::Elemental::Element::Pod5::Ordinary->new({content => $text}),
            ],
        }),
    );
}

no Moose;
1;

__END__

=head1 SYNOPSIS

In C<weaver.ini>:

 [BugsRT]

=head1 OVERVIEW

This section plugin will produce a hunk of Pod that describes how to report bugs to rt.cpan.org.
