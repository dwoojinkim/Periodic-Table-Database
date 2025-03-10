#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
ELEMENT_FOUND=false

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")

  if [[ -n $ATOMIC_NUMBER ]]
  then
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_FOUND=true
  elif [[ -n $ELEMENT_SYMBOL ]]
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$SYMBOL'")
    ELEMENT_FOUND=true
  elif [[ -n $ELEMENT_NAME ]]
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$ELEMENT_NAME'")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$ELEMENT_NAME'")
    ELEMENT_FOUND=true
  else
    echo "I could not find that element in the database."
  fi

  if [[ $ELEMENT_FOUND ]]
  then
    ELEMENT_TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties"
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of 
  fi
fi