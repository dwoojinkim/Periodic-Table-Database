#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
ELEMENT_FOUND=false

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
  else
    ATOMIC_NUMBER=""
  fi
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")

  if [[ -n $ATOMIC_NUMBER ]]
  then
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number =  $ATOMIC_NUMBER")\
    
    ELEMENT_SYMBOL=$(echo $ELEMENT_SYMBOL | xargs)
    ELEMENT_NAME=$(echo $ELEMENT_NAME | xargs)

    ELEMENT_FOUND=true
  elif [[ -n $ELEMENT_SYMBOL ]]
  then
    ELEMENT_SYMBOL=$(echo $ELEMENT_SYMBOL | xargs)

    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$ELEMENT_SYMBOL'")
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$ELEMENT_SYMBOL'")
    
    ELEMENT_NAME=$(echo $ELEMENT_NAME | xargs)

    ELEMENT_FOUND=true
  elif [[ -n $ELEMENT_NAME ]]
  then
    ELEMENT_NAME=$(echo $ELEMENT_NAME | xargs)

    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$ELEMENT_NAME'")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$ELEMENT_NAME'")

    ELEMENT_SYMBOL=$(echo $ELEMENT_SYMBOL | xargs)

    ELEMENT_FOUND=true
  else
    echo "I could not find that element in the database."
  fi

  if [[ "$ELEMENT_FOUND" == true ]]
  then
    ATOMIC_NUMBER=$(echo $ATOMIC_NUMBER | xargs)
    ELEMENT_TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

    ELEMENT_TYPE=$(echo $ELEMENT_TYPE | xargs)
    ELEMENT_MASS=$(echo $ELEMENT_MASS | xargs)
    MELTING_POINT=$(echo $MELTING_POINT | xargs)
    BOILING_POINT=$(echo $BOILING_POINT | xargs)

    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi