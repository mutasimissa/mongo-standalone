#!/usr/bin/env bash

# simple script for starting a standalone instance of a mongo database, or create a new one
# Mutasim Issa | mutasim@sourcya.com

# change the constant db_dir to your mongo data path, change mongod_port constant if you wish
# if the port is busy the script will try with the port +1 till it reaches a free port

#use the script with "auth" argument to start an instance with authentication enabled
#Note: to use authentication enabled, make sure your instance has an admin user in the admin database

#TODO
#check if mongod is installed
#check if other instance is using the database (un-handled error)
#script arguments to specify path and port in a nice way (maybe prompt), port argument should accept only intigers
#script arguments to run an instance eval check


 readonly default_db_dir=$1
 mongod_standalone_port=8802
 options_arg=$2 #TODO ugly

start0() {
  clear
  if [[ ! -O ./ ]]; then
    echo "permission check: failed | Check permissions of current directory, then restart the script"
    exit 1
  else
    echo "permission check: passed"
    check_port
  fi
}

check_port() {
  if ( lsof -Pi :${mongod_standalone_port} -sTCP:LISTEN -t >/dev/null ); then
    local current_pid=$(lsof -Pi :${mongod_standalone_port} -sTCP:LISTEN -t )
    echo "port check: port ${mongod_standalone_port} is in use!, running on pid ${current_pid}"
    let "mongod_standalone_port ++"
    echo "changing port to ${mongod_standalone_port}"
    check_port
  else
    echo "port check: port is available!, creating a new mongod instance on port ${mongod_port}"
    if [[ $options_arg == "auth" ]]; then
      create_mongod_instance_auth
    else
      create_mongod_instance
    fi
  fi
}

create_mongod_instance() {
  mkdir -p log && mkdir -p $default_db_dir
  mongod --fork --logpath log/mongod.log --port ${mongod_standalone_port} --dbpath ${default_db_dir} >/dev/null &
  echo "Starting mongod daemon on port ${mongod_standalone_port} ..." && sleep 10
  check_mongod
}

create_mongod_instance_auth() {
  mkdir -p log && mkdir -p $default_db_dir
  mongod --auth --fork --logpath log/mongod.log --port ${mongod_standalone_port} --dbpath ${default_db_dir} >/dev/null &
  echo "Starting mongod daemon with auth on port ${mongod_standalone_port} ..." && sleep 10
  check_mongod
}

check_mongod () {
  mongo --port ${mongod_standalone_port} --eval "db.stats()" >/dev/null
  check_result=$?
  if [ $check_result -ne 0 ]; then
    echo "Database connection check: failed | problem occured"
    exit 1
  else
    echo "Database connection check: passed"
    exit 0
  fi
}

start0
