# as of right now, this program is not complete.
#!/bin/bash
set +x
function helpmsg {
    printf "%s\n" "##### random joke fetcher hits the icanhazdadjoke site api and returns a text answer in the form of a random joke. #####"
    printf "%s\n\n" "##### Calling random joke fetcher -h or random_joke_fetcher without any arguments will print this message. #####"
    printf "%s\n" " ### OPTIONS ### "
    printf "%s\n" "-----------------"
    printf "%s\n" "rjf -j -----> fetch a random joke, prints to the terminal."
    printf "%s\n" "rj -h -----> prints this messsage."
}
if [ "$1" == "-h" ] || [ "$1" == "" ]; then
    helpmsg
else
JOKE_STR="$(curl --no-progress-meter -H "Accept: text/plain" https://icanhazdadjoke.com/)"
echo $JOKE_STR
fi
