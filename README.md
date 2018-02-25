# Perl_E-mail
To send E-mail from perl program

<img src="https://github.com/shutokawabata0723/Perl_E-mail/blob/master/email.png" width="500px">

# How to use
Edit SMTP server and E-mail address.
```perl
my $SMTP_CONF =
    {host=> 'smtp.mail.yahoo.co.jp', #yahooのsmtpサーバを送信用に指定
     port=> '587',   # ドメインによって違います
     from=> 'Username@yahoo.co.jp', #送信用ヤフーメールアドレスを入力
     return_path=> 'Username@yahoo.co.jp', #上に同じ
     auth_uid=> 'Username@yahoo.co.jp', #上に同じ
     auth_pw=> 'password' #Yahooアカウントのパスワード
    };
```
Edit subject
```perl
my $subject_org = '在庫を確認しました';
```


Edit E-mail contents
```perl
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
```


# Licence
CopyRight (c) 2018 Shuto Kawabata

Released under the MIT licence

https://opensource.org/licenses/MIT

# Author
Shuto Kawabata
