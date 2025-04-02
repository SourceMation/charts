#!/bin/sh

password='P@ssword1'

htpasswd -bnBC 10 "" ${password} | tr -d ':\n'| sed 's/$2y/$2a/'; echo
