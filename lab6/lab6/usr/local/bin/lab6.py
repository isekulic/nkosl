#!/usr/bin/python
import sys, os, re
import xml.etree.ElementTree as etr
#
# parsing xml file as tree
#
tree = etr.parse('/etc/chklog.conf')
root = tree.getroot()
lista_regexa = []
warning = 0
critical = 0

for file in root.findall('file'):
    count = 0
    num_lines = 0
    name = file.get('name')
    imefajla = open(name, 'r')
    for regex in file.findall('regex'):
        lista_regexa.append(regex)

    for line in imefajla:
        num_lines = num_lines +1
        for reg in lista_regexa:
            if re.match(reg.text, line):
                count = count  + 1
                break
    
    if count < int(file.find('warning').text):
        print "OK: ", name, " (", count, "). |", name, "=", count, ";", file.find('warning').text, ";", file.find('critical').text, ";0;" , num_lines
    elif count >= int(file.find('warning').text) and count < int(file.find('critical').text):
        print "Warning: ", name, " (", count, "). |", name, "=", count, ";", file.find('warning').text, ";", file.find('critical').text, ";0;", num_lines
        warning = 1
    elif count >= int(file.find('critical').text):
        print "Critical:", name, " (", count, "). |", name, "=", count, ";", file.find('warning').text, ";", file.find('critical').text, ";0;", num_lines
        critical = 1
    else:
        sys.exit(3)

if warning == 1:
    sys.exit(1)
elif critical == 2:
    sys.exit(2)
sys.exit (0)
