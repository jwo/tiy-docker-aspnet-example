#!/bin/bash

func(){
  # check if we are running on port 5000. Will return 0 if not running.
  running=$(lsof -i :5000 | wc -l | sed "s/ //g")
}

check_running ()
{
  func

  if [ $running -ge 0 ]
  then
    dotnet run  > stdout.txt
  fi

}

fetch_todos ()
{
  # We need to wait for dotnet to boot up.
  sleep 3
  # func
  # while [ $running -le 1 ]
  # do
  #   sleep 0.1
  #   func
  #   echo size=${#running}
  #   echo $running
  # done
  # echo "Found, let's fetch"
  curl -Ss http://localhost:5000/api/todo | jq .
}

check_running & fetch_todos && pkill -x dotnet
