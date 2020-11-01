#!/bin/bash

# Variables
sender=$1
recipient=$2
log="mail.log"


# Checks if the sender or recipient is an account or domain
check_account_or_domain() {
	if [ "$(echo $1 | grep "@" | wc -l)" -eq 0 ];
		then
			echo "domain";
		else
			echo "account";
	fi;
}


# Check if be necessary to using cat or zcat
set_tool_log() {
	if [ "$(echo $1 | grep 'gz' | wc -l)" -eq 1 ];
		then
			echo "zcat";
		else
			echo "cat";
	fi
}


# Alter archive of search
if [ $(echo "$3" | grep [a-zA-Z] | wc -l) -eq 1 ];
        then
                log="$3";
                echo "Search log set for $log";
        else
                echo "Search log pattern will be $log";
fi;


# Call functions
sender_search=$(check_account_or_domain $sender)
recipient_search=$(check_account_or_domain $recipient)
log_tool=$(set_tool_log $log)


# Defining search variables
if [ "$sender_search" == "domain" ];
	then
		var_sender_search="from=<.*@$sender>";
	else
		var_sender_search="from=<$sender>";
fi;

if [ "$recipient_search" == "domain" ];
        then
                var_recipient_search="to=<.*@$recipient>";
        else
                var_recipient_search="to=<$recipient>";
fi;

if [ "$log_tool" == "cat" ];
	then
		echo "Searching log's using cat";
		for i in $(cat /var/log/$log | grep "$var_sender_search" | grep "$var_recipient_search" | awk '{ print $6 }' | egrep -v "proxy|NOQUEU|\[" | sort | uniq);
			do
                        	echo "====================================================" ;
                        	cat /var/log/$log | grep $i | sed "s/$i/$(tput setaf 6)&$(tput sgr0)/";
                done | sed "s,$var_sender_search,$(tput setaf 1)&$(tput sgr0)," | sed "s,$var_recipient_search,$(tput setaf 1)&$(tput sgr0)," | sed "s,status=sent,$(tput setaf 4)&$(tput sgr0)," | sed "s,status=deferred,$(tput setaf 3)&$(tput sgr0),";
	else
		echo "Searching log's using zcat";
		for i in $(zcat /var/log/$log | grep "$var_sender_search" | grep "$var_recipient_search" | awk '{ print $6 }' | egrep -v "proxy|NOQUEU|\[" | sort | uniq);
                        do
                                echo "====================================================" ;
                                zcat /var/log/$log | grep $i | sed "s/$i/$(tput setaf 6)&$(tput sgr0)/";
                done | sed "s,$var_sender_search,$(tput setaf 1)&$(tput sgr0)," | sed "s,$var_recipient_search,$(tput setaf 1)&$(tput sgr0)," | sed "s,status=sent,$(tput setaf 4)&$(tput sgr0)," | sed "s,status=deferred,$(tput setaf 3)&$(tput sgr0),";
fi;

echo "$sender_token   $recipient_token"
echo "$log_tool $log"
echo "$var_sender_search   $var_recipient_search"
