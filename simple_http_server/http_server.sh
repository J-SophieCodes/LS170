#!/bin/bash

function server () {  # defined a function called server
  while True
  do
    read method path version
    if [[ $method = 'GET' ]]
    then
      if [[ -f ./www$path ]]
      then
        echo -e "HTTP/1.1 200 OK\r\n"
        cat ./www$path
      else
        echo -e "HTTP/1.1 404 Not Found\r\n"
      fi
    else
      echo -e "HTTP/1.1 400 Bad Request\r\n"
    fi
  done
}

coproc SERVER_PROCESS { server; }
# coprocess - allows us to run our server function asynchronously
# alongside our nc command
# the coproc is named SERVER_PROCESS & executes the server function

nc -lvp 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
# executes netcat in listen and verbose mode
# input from nc redirected to SERVER_PROCESS, then passed to 
# server function as STDIN (via read). STDOUT (via echo) from 
# server function is the passed back to SERVER_PROCESS, then 
# redirected to nc. 