#!/bin/bash

pd=$(ls -d */)

if [[ $1 == 'c' ]]; then
   #statements
   rm */*.class > /dev/null 2>&1
   javac */*.java

fi
