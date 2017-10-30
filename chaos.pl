use strict;
use Data::Dumper;
# vm で動かす場合は　マウス統合を切らないとなんか　チャタるっていうかになる
sub x {
 my $q = shift;
# system ("xdotool mousemove " . ($q->[0]) +6 . " " . ($q->[1]) +6);
 my $params = join(" ",@$q);
 system ("xdotool mousemove " . $params);
}

my $on = {
  tap =>{
     gacha_pull => [192,656],
     pre_gp_window  => [271,661],
     gp_window  => [271,661,"click","1"],
     clan_pull  => [189,553], 
     pre_clan_window  => [213,546], 
     clan_window  => [214,553,"click","1"], 
  },

  g_field =>{
     gacgha    =>  [460,558,"click","1"],
     ok        =>  [504,522,"click","1"],
     del       =>  [902,267,"click","1"],
  },
  
  g_child_field =>{
     gacgha =>  [563,561,"click","1"],
     ok     =>  [505,520,"click","1"],
     del    =>  [715,281,"click","1"],
  },
  
  g_motion_faster => {
     ok     =>  [566,563,"click","1"],
  }  ,

  clan_field => {
    nouhin =>  [408,541,"click","1"],
    del=> [814,327,"click","1"],
  },

  nouhin_field => {
    ikkatsu => [418,404,"click","1"],
    nouhin =>  [405,655,"click","1"],
    ok => [402,653,"click","1"],
    del=> [896,265,"click","1"],
  },
};

 my $TargetGP = 10 * 1000000; #使い切りたいGP M 
 my $max = int ($TargetGP / 60000);
 my $maxGP = $max * 12 * 5000;

for my $itr (1..$max) {

 gacha($on,12);# moretahn 2;
 nouhin($on,6);
     my $lastGP = $TargetGP - $itr * 60000 ;
    # claning
    print "[+]Phase $itr / $max .... ( it will use $lastGP GP : Target is $TargetGP \n";
}


sub gacha {# gacha のGUI的に２回以上のパラメータ入れてね
 my $on = shift;
 my $cnt = shift;

 x( $on->{tap}->{gacha_pull});
sleep 1;
 x( $on->{tap}->{pre_gp_window});
sleep 1;
 x( $on->{tap}->{gp_window});
sleep 1;
 x( $on->{g_field}->{gacgha});
sleep 1;
 x( $on->{g_field}->{ok});
sleep 1;
 x( $on->{g_motion_faster}->{ok});
 x( $on->{g_motion_faster}->{ok});
 x( $on->{g_motion_faster}->{ok});
sleep 1;


     for (1..$cnt-2) {
        x( $on->{g_child_field}->{gacgha});
        sleep 2;
         x( $on->{g_child_field}->{ok});
        sleep 2;
        x( $on->{g_motion_faster}->{ok});
        x( $on->{g_motion_faster}->{ok});
        x( $on->{g_motion_faster}->{ok});
        sleep 3;
     }

sleep 1;
 x( $on->{g_child_field}->{del});
sleep 1;
 x( $on->{g_field}->{del});
sleep 1;

}

sub nouhin {

my $on = shift;
my $cnt = shift;

x( $on->{tap}->{clan_pull});
sleep 1;
x( $on->{tap}->{pre_clan_window});
sleep 1;
x( $on->{tap}->{clan_window});
sleep 4; # 3秒くらいかかってる・・・・　（　＾ω＾）・・・
x( $on->{clan_field}->{nouhin});
sleep 1;

  for (1..$cnt) {
    x( $on->{nouhin_field}->{ikkatsu});
    sleep 2;
    x( $on->{nouhin_field}->{nouhin});
    sleep 1;
    x( $on->{nouhin_field} ->{ok});
    sleep 1;
  }

  x( $on->{nouhin_field} ->{del});
  sleep 1;
x( $on->{clan_field}->{del});
sleep 1;
}