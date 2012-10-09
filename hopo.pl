#! /usr/bin/perl
use uni::perl;

use Tenjin;
use LWP::Simple;
use Lingua::RU::Numeric::Declension qw/numdecl/;

$Tenjin::ENCODING = 'UTF-8';

my $tenj = Tenjin->new();

my $template = 'hopo.tmpl';
my $items = {
    title   => 'У природы есть плохая погода',

    places  => [
        # http://worldweather.wmo.int/index.htm
        # wid - http://weather.yahoo.com/vietnam/null/ho-chi-minh-city-1252431/
        {
            title   => 'Мальдивы, Мале',
            cur     => 29,
            octo    => 30.2,
            nove    => 30.1,
            dece    => 30.1,
            janu    => 30.3,
            search  => 'мальдивы',
            wid     => 2268295,
        },
        {
            title   => 'Таиланд, Пхукет',
            cur     => 27,
            octo    => 31.4,
            nove    => 31.3,
            dece    => 31.5,
            janu    => 31.5,
            search  => 'таиланд',
            wid     => 1226113,
        },
        {
            title   => 'Шри-Ланка, Коломбо',
            cur     => 29,
            octo    => 30.0,
            nove    => 30.1,
            dece    => 30.3,
            janu    => 30.9,
            search  => 'шри-ланка',
            wid     => 2189783,
        },
        {
            title   => 'Китай, Хайнань',
            cur     => 25,
            octo    => 30.2,
            nove    => 28.5,
            dece    => 26.6,
            janu    => 26.1,
            search  => 'хайнань',
            wid     => 2162784,
        },
        {
            title   => 'Индонезия, Бали',
            cur     => 26,
            octo    => 33.6,
            nove    => 32.7,
            dece    => 33.0,
            janu    => 33.0,
            search  => 'бали',
            wid     => 1047372,
        },
        {
            title   => 'Индия, Гоа',
            cur     => 25,
            octo    => 31.6,
            nove    => 32.8,
            dece    => 32.4,
            janu    => 31.6,
            search  => 'гоа',
            wid     => 12513587,
        },
        {
            title   => 'Египет, Шарм-эль-Шейх',
            cur     => 28,
            octo    => 31.5,
            nove    => 27.0,
            dece    => 23.2,
            janu    => 21.7,
            search  => 'египет',
            wid     => 1526249,
        },
        {
            title   => 'Израиль, Эйлат',
            cur     => 27,
            octo    => 33.0,
            nove    => 27.2,
            dece    => 22.3,
            janu    => 20.8,
            search  => 'израиль',
            wid     => 1968170,
        },
        {
            title   => 'Вьетнам, Хошимин',
            cur     => 27,
            octo    => 31.2,
            nove    => 31.0,
            dece    => 30.8,
            janu    => 31.6,
            search  => 'вьетнам',
            wid     => 1252431,
        },
        {
            title   => 'Канары, Тенерифе',
            cur     => 27,
            octo    => 26.0,
            nove    => 23.9,
            dece    => 21.8,
            janu    => 20.6,
            search  => 'канарские острова',
            wid     => 773692,
        },
        {
            title   => 'Бразилия, Рио-де-Жанейро',
            cur     => 27,
            octo    => 26,
            nove    => 27.4,
            dece    => 28.6,
            janu    => 29.4,
            search  => 'рио-де-жанейро',
            wid     => 455825,
        },
        {
            title   => 'Маврикий, Порт-Луи',
            cur     => 27,
            octo    => 28.8,
            nove    => 30.2,
            dece    => 31.1,
            janu    => 31.5,
            search  => 'маврикий',
            wid     => 1377436,
        },
    ],
};

sub temper {
    my $temp_num = shift;
    my $dec = shift || 0;

    my $temp_str = sprintf "%.${dec}f", $temp_num;
    $temp_str = $temp_num < 0 ? ("&ndash;" . -$temp_str) : "+$temp_str";
    $temp_str =~ tr/./,/;

    return $temp_str;
}

sub yahoo_we {
    my $wid = shift;
    my $yahoo_w = get("http://weather.yahooapis.com/forecastrss?w=$wid&u=c");
    return $yahoo_w =~ /temp="([^"]+)/ ? $1 : '0.0';
}

for my $place (@{$items->{places}}) {
    $place->{cur} = yahoo_we($place->{wid});
    for my $t (qw/cur octo nove dece janu/) {
        $place->{$t} = temper($place->{$t}, 1);
    }
}

$items->{cur_temp} = temper(yahoo_we(24553382));
$items->{timestamp} = "" . localtime;
$items->{raining} = int((time - 1349647200) / 3600);
$items->{raining_h} = numdecl($items->{raining}, 'час', 'часа', 'часов');

my $pro = get('http://export.yandex.ru/bar/reginfo.xml');
my $probki_level = $pro =~ /<level>(\d+)<\/level>/ ? $1 : 19;
$items->{probki} = $probki_level . ' ' . numdecl($probki_level, 'балл', 'балла', 'баллов');

print $tenj->render($template, $items);