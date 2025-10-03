#!/bin/bash

set +x
# notice, python3 is a dependency of this script.

# official joke api
OFF_RAND_JOKES_TYPES="$(curl --silent https://official-joke-api.appspot.com/types)"
IFS=',' read -r -a categories <<< "$(echo "$OFF_RAND_JOKES_TYPES" | tr -d '[]"')"
OFF_RAND_JOKE_GENERAL="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories[0]}"/random)"
OFF_RAND_JOKE_KNOCK_KNOCK="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories[1]}"/random)"
OFF_RAND_JOKE_PROGRAMMING="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories[2]}"/random)"
OFF_RAND_JOKE_DAD_JOKE="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories[3]}"/random)"

# dad joke api
DAD_JOKE="$(curl --silent -H "Accept: text/plain" https://icanhazdadjoke.com/)"

parsejson() {
    if [ "$1" == "general" ]; then # parse a general joke
        PARSED_GENERAL="$(echo "$OFF_RAND_JOKE_GENERAL" | python3 -c "import sys, json; print(json.load(sys.stdin)['name'])")"
        parsed_joke="$PARSED_GENERAL"
    elif [ "$1" == "random" ]; then # parse a random type joke
        PARSED_KNOCK_KNOCK="$(echo "$OFF_RAND_JOKE_KNOCK_KNOCK" | python3 -c "import sys, json; print(json.load(sys.stdin)['name'])")"
        parsed_joke="$PARSED_KNOCK_KNOCK"
    elif [ "$1" == "-knock" ]; then # parse a knock knock type joke
        PARSED_KNOCK_KNOCK="$(echo "$OFF_RAND_JOKE_PROGRAMMING" | python3 -c "import sys, json; print(json.load(sys.stdin)['name'])")"
        parsed_joke="$PARSED_KNOCK_KNOCK"
    else # parse a programming type joke
        PARSED_DAD_JOKE="$(echo "$OFF_RAND_JOKE_DAD_JOKE" | python3 -c "import sys, json; print(json.load(sys.stdin)['name'])")"
        parsed_joke="$PARSED_DAD_JOKE"
    fi
    return $parsed_joke
}

helpmsg() {
    cat <<EOF
    YARJF - Yet Another Random Joke Fetcher
    ---------------------------------------
    Fetch random jokes from official-joke-api and icanhazdadjoke.

    Usage:
    yarjf -h           Show this help message
    yarjf -j           Random dad joke (default)
    yarjf -j -d        Dad joke (icanhazdadjoke)
    yarjf -j -D        Dad joke (official joke API)
    yarjf -j -p        Programming joke
    yarjf -j -g        General joke
    yarjf -j -k        Knock-knock joke
EOF
}

if [ "$1" == "-h" ]; then
    helpmsg
fi
if [ "$1" == "-j" ]; then
    case $2 in
        "-p")
            echo "$OFF_RAND_JOKE_PROGRAMMING"
            ;;
        "-d")
            echo "$DAD_JOKE"
            ;;
        "-D")
            echo "$OFF_RAND_JOKE_DAD_JOKE"
            ;;
        "-k")
            echo "$OFF_RAND_JOKE_KNOCK_KNOCK"
            echo "testing the parsing..."
            response=$(parsejson -knock)
            echo "$response"
            ;;
        "-g")
            echo "$OFF_RAND_JOKE_GENERAL"
            ;;
        *)
            echo "$OFF_RAND_JOKE_GENERAL"
            ;;
    esac
fi
