#!/bin/bash

function server () {
  while true
  do
    message_arr=()  # declared local var message_arr, assigned to empty array ()
    check=true  # initialized var check
    while $check
    do
      read line
      message_arr+=($line)  # add line to message_arr
      if [[ "${#line}" -eq 1 ]] # check if the line length is 1 (signifies last line)
      then
        check=false
      fi
    done
    method=${message_arr[0]}  # array index 0
    path=${message_arr[1]}  # array index 1
    if [[ $method = 'GET' ]]
    then
      if [[ -f "./www/$path" ]]
      then
        echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: $(wc -c <'./www/'$path)\r\n\r\n"; cat "./www/$path"
      else
        echo -ne 'HTTP/1.1 404 Not Found\r\n\r\n'
      fi
    else
      echo -ne 'HTTP/1.1 400 Bad Request\r\n\r\n'
    fi
  done
}

coproc SERVER_PROCESS { server; }

nc -lvp 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
