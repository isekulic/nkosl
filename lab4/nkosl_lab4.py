import sys, os
import pam
from getpass import getpass
from time import strftime, localtime

username = raw_input("Username: ")
password = getpass()

fout = open("povijest.txt", "a")

if (pam.authenticate(username, password)):
    print "Tvoja mama: +385 97 753 3024"
    print >> fout, strftime("%Y-%m-%d %H:%M:%S", localtime()), "\n", username

else:
    print "Greska pri autentifikaciji."
    print >> fout, strftime("%Y-%m-%d %H:%M:%S", localtime()), "\n", username, "\n", password
fout.close()