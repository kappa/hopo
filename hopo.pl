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
            febr    => 30.7,
            marc    => 31.4,
            search  => 'мальдивы',
            search_en   => 'maldives',
            wid     => 2268295,
            visa    => 'нет',
            flight  => 8,
        },
        {
            title   => 'Таиланд, Пхукет',
            cur     => 27,
            octo    => 31.4,
            nove    => 31.3,
            dece    => 31.5,
            janu    => 32.4,
            febr    => 33.3,
            marc    => 33.8,
            search  => 'таиланд',
            search_en   => 'thailand',
            wid     => 1226113,
            visa    => 'нет',
            flight  => 9,
        },
        {
            title   => 'Шри-Ланка, Коломбо',
            cur     => 29,
            octo    => 30.0,
            nove    => 30.1,
            dece    => 30.3,
            janu    => 30.9,
            febr    => 31.2,
            marc    => 31.7,
            search  => 'шри-ланка',
            search_en   => 'srilanka',
            wid     => 2189783,
            visa    => 'нет',
            flight  => 10,
        },
        {
            title   => 'Китай, Хайнань',
            cur     => 25,
            octo    => 30.2,
            nove    => 28.5,
            dece    => 26.6,
            janu    => 26.1,
            febr    => 26.8,
            marc    => 28.6,
            search  => 'хайнань',
            search_en   => 'hainan',
            wid     => 2162784,
            visa    => 'нет',
            flight  => 10,
        },
        {
            title   => 'Индонезия, Бали',
            cur     => 26,
            octo    => 33.6,
            nove    => 32.7,
            dece    => 33.0,
            janu    => 33.0,
            febr    => 33.4,
            marc    => 33.6,
            search  => 'бали',
            search_en   => 'bali',
            wid     => 1047372,
            visa    => 'нет',
            flight  => 15,
        },
        {
            title   => 'Индия, Гоа',
            cur     => 25,
            octo    => 31.6,
            nove    => 32.8,
            dece    => 32.4,
            janu    => 31.6,
            febr    => 31.5,
            marc    => 32.0,
            search  => 'гоа',
            search_en   => 'goa',
            wid     => 12513587,
            visa    => 'да',
            flight  => "7,5",
        },
        {
            title   => 'Египет, Шарм-эль-Шейх',
            cur     => 28,
            octo    => 31.5,
            nove    => 27.0,
            dece    => 23.2,
            janu    => 21.7,
            febr    => 22.4,
            marc    => 25.1,
            search  => 'египет',
            search_en   => 'egypt',
            wid     => 1526249,
            visa    => 'нет',
            flight  => "30",
        },
        {
            title   => 'Израиль, Эйлат',
            cur     => 27,
            octo    => 33.0,
            nove    => 27.2,
            dece    => 22.3,
            janu    => 20.8,
            febr    => 22.1,
            marc    => 25.5,
            search  => 'израиль',
            search_en   => 'eilat',
            wid     => 1968170,
            visa    => 'нет',
            flight  => "7,5",
        },
        {
            title   => 'Вьетнам, Хошимин',
            cur     => 27,
            octo    => 31.2,
            nove    => 31.0,
            dece    => 30.8,
            janu    => 31.6,
            febr    => 32.9,
            marc    => 33.9,
            search  => 'вьетнам',
            search_en   => 'vietnam',
            wid     => 1252431,
            visa    => 'нет',
            flight  => 10,
        },
        {
            title   => 'Канары, Тенерифе',
            cur     => 27,
            octo    => 26.0,
            nove    => 23.9,
            dece    => 21.8,
            janu    => 20.6,
            febr    => 20.9,
            marc    => 21.7,
            search  => 'канарские острова',
            search_en   => 'canaries',
            wid     => 773692,
            visa    => 'шенген',
            flight  => 10,
        },
        {
            title   => 'Бразилия, Рио-де-Жанейро',
            cur     => 27,
            octo    => 26,
            nove    => 27.4,
            dece    => 28.6,
            janu    => 29.4,
            febr    => 30.2,
            marc    => 29.4,
            search  => 'рио-де-жанейро',
            search_en   => 'brazil',
            wid     => 455825,
            visa    => 'нет',
            flight  => 17,
        },
        {
            title   => 'Маврикий, Порт-Луи',
            cur     => 27,
            octo    => 28.8,
            nove    => 30.2,
            dece    => 31.1,
            janu    => 31.5,
            febr    => 31.4,
            marc    => 31.5,
            search  => 'маврикий',
            search_en   => 'mauritius',
            wid     => 1377436,
            visa    => 'нет',
            flight  => 15,
        },
        {
            title   => 'Марокко, Касабланка',
            cur     => 27,
            octo    => 22.1,
            nove    => 19.8,
            dece    => 19.7,
            janu    => 17.1,
            febr    => 18.8,
            marc    => 21.3,
            search  => 'марокко',
            search_en   => 'morocco',
            wid     => 1532755,
            visa    => 'нет',
            flight  => 16,
        },
        {
            title   => 'Крым, Ялта',
            cur     => 99,
            octo    => 17.8,
            nove    => 12.4,
            dece    => 8.6,
            janu    => 7.1,
            febr    => 7.1,
            marc    => 9.5,
            search  => 'ялта',
            search_en   => 'yalta',
            wid     => 938848,
            visa    => 'нет',
            flight  => 2,
        },
    ],
};

sub temper {
    my $temp_num = shift;
    my $dec = shift || 0;

    my $temp_str = sprintf "%.${dec}f", $temp_num;
    $temp_str = $temp_num < 0 ? ("–" . -$temp_str) : "+$temp_str";
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
    for my $t (qw/cur janu febr marc octo nove dece/) {
        $place->{$t} = temper($place->{$t});
    }
}

$items->{cur_temp} = temper(yahoo_we(24553382));
$items->{cur_temp_mrmnsk} = temper(yahoo_we(2122296));
$items->{cur_temp_krsndr} = temper(yahoo_we(2028717));
$items->{timestamp} = "" . localtime;
$items->{raining} = int((time - 1349647200) / 3600);
$items->{raining_h} = numdecl($items->{raining}, 'час', 'часа', 'часов');

my $pro = get('http://export.yandex.ru/bar/reginfo.xml');
my $probki_level = $pro =~ /<level>(\d+)<\/level>/ ? $1 : 19;
$items->{probki} = $probki_level . ' ' . numdecl($probki_level, 'балл', 'балла', 'баллов');

print $tenj->render($template, $items);
