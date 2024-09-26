if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
fi
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"



PRINT_ELEMENT() {
  echo "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius".
}

GET_ELEMENT_FROM_ATOMIC_NUMBER() {
  ATOMIC_NUMBER=$1
  SELECT_RESULT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")"  
  TRY_FIND_ELEMENT $SELECT_RESULT
  
  echo "$SELECT_RESULT" | 
  while IFS='|' read -r TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE; do
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
}

GET_ELEMENT_FROM_SYMBOL() {
  ATOMIC_SYMBOL=$1
  SELECT_RESULT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$ATOMIC_SYMBOL'")"
  TRY_FIND_ELEMENT $SELECT_RESULT

  echo "$SELECT_RESULT" | 
  while IFS='|' read -r TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE; do
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
}

GET_ELEMENT_FROM_NAME() {
  ATOMIC_NAME=$1
  SELECT_RESULT="$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$ATOMIC_NAME'")" 

  TRY_FIND_ELEMENT $SELECT_RESULT
  echo "$SELECT_RESULT" | 
  while IFS='|' read -r TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE; do
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
}

TRY_FIND_ELEMENT() {
  if [[ -z $1 ]]; then
    echo I could not find that element in the database.
    exit
  fi
}


# Determine the type of argument
if [[ $1 =~ ^[0-9]+$ ]]; then
  # Argument is a number (atomic number)
  GET_ELEMENT_FROM_ATOMIC_NUMBER $1
elif [[ $1 =~ ^(([A-Za-z][A-Za-z])|[A-Za-z])$ ]]; then
  #Argmuent is a single character
  GET_ELEMENT_FROM_SYMBOL $1
elif [[ $1 =~ ^[A-Za-z]+$ ]]; then
  #Argument is multiple characters (name)
  GET_ELEMENT_FROM_NAME $1
fi