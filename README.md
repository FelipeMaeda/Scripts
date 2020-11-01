# Search log postfix

### Instalation:

Clone this repo and create alias command.

```sh
git clone https://github.com/FelipeMaeda/Search-log-postfix.git
alias log_postfix="$(pwd)/Search-log-postfix/./search_log_postfix.sh"
chmod a+x /Search-log-postfix/search_log_postfix.sh
```
The command alias will be temporary, but you can directly specify the file path to run or add the alias to your Bashrc.

### Usage:

Run the alias command by passing the sender and recipient as a parameter. If necessary, you can pass a third parameter specifying the mail.log that will be used. The default search directory is "/var/log/" and if you do not have a third parameter, the "mail.log" file will be searched.

```sh
log_postfix <account or domain of sender> <account or domain of recipient> <optional mail.log>
```

### Example:

```sh
log_postfix adress_sender@domain.com adress_recipient@domain.com
```

