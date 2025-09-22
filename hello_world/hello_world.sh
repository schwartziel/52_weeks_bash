#!/bin/bash
echo "This is the hello world bash script."
echo "I already have some decent bash knowledge already; this is a quick program."

printf "%b" "\nConditionals:\n"
read -r -p "Pickles are a tasty snack? [Y/n] " RESPONSE
RESP_LC="${RESPONSE,,}"  # lowercased

if [[ "$RESP_LC" == "y" || -z "$RESP_LC" ]]; then
  echo "You entered '$RESPONSE' -> treating as 'Y'"
  TRUE_VAR=true
else
  echo "You entered something other than 'Y'"
  TRUE_VAR=false
fi

if [[ "$TRUE_VAR" == true ]]; then
  echo "Correct answer."
else
  echo "Pickles are indeed a tasty snack. User is crazy."
fi

echo
echo "Doing some math and then calling it a day."
read -r -p "Enter an integer and we'll do some calculations... => " NUMBER

# Basic integer validation
if ! [[ "$NUMBER" =~ ^-?[0-9]+$ ]]; then
  echo "Not an integer. Exiting." >&2
  exit 1
fi

VAR=5
sum=$(( NUMBER + VAR ))
diff=$(( NUMBER - VAR ))
prod=$(( NUMBER * VAR ))
quot=$(( NUMBER / VAR ))
rem=$(( NUMBER % VAR ))

cat <<EOF
Using VAR=$VAR:
  $NUMBER + $VAR = $sum
  $NUMBER - $VAR = $diff
  $NUMBER * $VAR = $prod
  $NUMBER / $VAR = $quot
  $NUMBER % $VAR = $rem
EOF

