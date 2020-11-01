# Search log postfix

### Instalation:

Clone this repo and create alias command.

```sh
git clone https://github.com/FelipeMaeda/Search-log-postfix.git
alias log='$(pwd)/./search_log_postfix.sh'
```

### Usage:

Run the alias command by passing the sender and recipient as a parameter. If necessary, you can pass a third parameter specifying the mail.log that will be used. The default search directory is "/var/log/" and if you do not have a third parameter, the "mail.log" file will be searched.

```sh
log <account or domain of sender> <account or domain of recipient> <optional mail.log>
```

### Example:

```sh
log adress_sender@domain.com adress_recipient@domain.com
```

