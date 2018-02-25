# Perl_E-mail
To send E-mail from perl program

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
