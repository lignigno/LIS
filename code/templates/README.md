# **How it use**

<br>

### ***LOAD***
1. Copy the command.

``` bash
rm -rf /tmp/<user> && \
git clone <user_url> /tmp/<user> && \
/tmp/<user>/code/deploy.sh && \
source ~/.zshrc
```

2. Paste it into the terminal.

### ***SAVE***

``` bash
lis save
```

### ***LOGOUT***
``` bash
lis logout
```

### ***UPDATE***
``` bash
lis update
```

<br>

> [!CAUTION]
> Logout using the "lis logout" command in the terminal to avoid information leakage.  
>  
> Делайте логаут с помощью команды в терминале "lis logout", чтобы избежать утечки информации.

<br>

INSTALLED VERSION : 0.27-fix_alias