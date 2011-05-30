use inc::Module::Install;
use Module::Install::AuthorTests;
use Module::Install::ReadmeMarkdownFromPod;

name 'Net-Hatena';
all_from 'lib/Net/Hatena.pm';
readme_markdown_from 'lib/Net/Hatena.pm';

requires 'OAuth::Lite';
requires 'LWP::Authen::OAuth';
requires 'Class::Accessor::Lite';
requires 'UNIVERSAL::require';

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';

test_requires 'Test::More' => 0.96; # done_testing, subtest
test_requires 'URI::Escape';

author_tests('xt');
WriteAll;
