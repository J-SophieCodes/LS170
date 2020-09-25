#! /bin/bash

greeting () {   # defining a function called greeting
  echo Hello $1    # variable 1 references the first argument passed
}

greeting 'Peter' # outputs 'Hello Peter'


greeting () {
  echo "Hello $1"    # we can interpolate variables in double-quoted strings.
  echo "Hello $2"
}

greeting 'Peter' 'Paul' # outputs 'Hello Peter' 'Hello Paul' on separate lines