#!/usr/bin/python

import sys, string

def updateKillFile(input, kill) :

  keep = ['em', 'kl', 'ai', 'ml', 'bp', 'ir']

  print('Processing ' + input)
  
  inputFile = open(input, 'r')
  killFile = open(kill, 'a')

  for line in inputFile : # for each line...

    line = line.lower()
    newLine = ''

    for char in line : 
      if isAlphaChar(char) :
        newLine = newLine + char
      else :
        newLine = newLine + ' '

    words = newLine.split()

    for word in words :
      if len(word) < 3 :
        if word not in keep :
          killFile.write(word + '\n')
      if len(word) > 20 :
        if word not in keep :
          killFile.write(word + '\n')

  inputFile.close()
  killFile.close()

def isAlphaChar(char) :

    if char in 'abcdefghijklmnopqrstuvwxyz' :
        return 1
    else :
        return 0

if (len(sys.argv) < 2) :
  print 'usage sys.argv[0] inputFile killFile'
  sys.exit()

inputFile = sys.argv[1]
killFile = sys.argv[2]

updateKillFile(inputFile, killFile)
