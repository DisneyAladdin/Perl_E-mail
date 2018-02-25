#!/usr/bin/env perl
# Created by Shuto Kawabata
# All copyrights have been saved in 2017.
use utf8;
use Encode;
use strict;
use warnings;
# for E-mail
use Authen::SASL;
use MIME::Base64;
use Net::SMTP;





sub Notify{
	my $name  = shift;
	my $price = shift;
	my $url   = shift;
	my $store = shift;

#send E-mail
my $SMTP_CONF =
    {host=> 'smtp.mail.yahoo.co.jp', #yahooのsmtpサーバを送信用に指定
     port=> '587',   # ドメインによって違います
     from=> 'Username@yahoo.co.jp', #送信用ヤフーメールアドレスを入力
     return_path=> 'Username@yahoo.co.jp', #上に同じ
     auth_uid=> 'Username@yahoo.co.jp', #上に同じ
     auth_pw=> 'password' #Yahooアカウントのパスワード

    };

main($name,$price,$url,$store);

sub main {
	my $name  = shift;
	my $price = shift;
	my $url   = shift;
	my $store = shift;
	#以下のrecievingを替えて受信先のアドレスとして指定してください.
	publish_test_mail(['recieving@gmail.com'],$name,$price,$url,$store);
}



sub publish_test_mail {
	my ($mailto ) = shift; #default
	my $name     = shift;
	my $price    = shift;
	my $url      = shift;
	my $store    = shift;
	my $subject_org = '在庫を確認しました';
	my $subject = Encode::encode('MIME-Header-ISO_2022_JP', $subject_org);

	my $display_deduction = abs($deduction);


    #mailtoがない場合、送信は行いません. for debug                                                                                        
    	if( ref($mailto) ne "ARRAY" or @$mailto < 1 ){
        	return undef;
    	}
    	my $mailto_str = join(',', @$mailto );
    	my $message =<<EOF;
# Please edit here!!
Hello! This E-mail is automatically sent from Perl program.
Please check the item
# As you can see, variables can be adapted.

【NAME】: $name
【STORE】: $store
【PRICE】 :￥$price
【URL】 : $url

EOF

    #メールのヘッダーを構築                                                                                                               
    my $header = << "MAILHEADER_1";
From: $SMTP_CONF->{from}
Return-path: $SMTP_CONF->{return_path}
Reply-To: $SMTP_CONF->{return_path}
To: $mailto_str
MAILHEADER_1

    $header .=<<"MAILHEADER_2";
Subject: $subject
Mime-Version: 1.0
Content-Type: text/plain; charset = "ISO-2022-JP"
Content-Transfer-Encoding: 7bit
MAILHEADER_2
    $message = encode('iso-2022-jp',$message);
    my $smtp = Net::SMTP->new($SMTP_CONF->{host},
                              Hello=>$SMTP_CONF->{host},
                              Port=> $SMTP_CONF->{port},
                              Timeout=>20,
                             );
    unless($smtp){
        my $msg = "can't connect smtp server: $!";
        die $msg;
    }



    $smtp->auth($SMTP_CONF->{auth_uid}, $SMTP_CONF->{auth_pw}) or
        die "can't login smtp server";

    $smtp->mail($SMTP_CONF->{from});
    $smtp->to(@$mailto);
    $smtp->data();
    $smtp->datasend("$header\n");
    $smtp->datasend("$message\n");
    $smtp->dataend();
    $smtp->quit;
}

}





# Send variables to "Notify" function
my $name  = "PlayStation4"
my $price = "30000"
my $url   = "yodobashi.com"
my $store = "YodobashiCamera"
&Notify($name,$price,$url,$store);
