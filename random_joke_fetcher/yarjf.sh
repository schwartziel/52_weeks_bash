# as of right now, this program is not complete.
#!/bin/bash
set +x

# official joke api
OFF_RAND_JOKES_TYPES="$(curl --silent https://official-joke-api.appspot.com/types)"
IFS=',' read -r -a categories <<< "$(echo "$OFF_RAND_JOKES_TYPES" | tr -d '[]"')"
OFF_RAND_JOKE_GENERAL="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories[0]}"/random)"
OFF_RAND_JOKE_KNOCK_KNOCK="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories}[1]"/random)"
OFF_RAND_JOKE_PROGRAMMING="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories}[2]"/random)"
OFF_RAND_JOKE_DAD_JOKE="$(curl --silent https://official-joke-api.appspot.com/jokes/"${categories}[3]"/random)"

# dad joke api
DAD_JOKE="$(curl --silent -H "Accept: text/plain" https://icanhazdadjoke.com/)"

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
            echo $OFF_RAND_JOKE_PROGRAMMING
            ;;
        *)
            echo "escaping"
               esac
fi
