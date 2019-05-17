TERM=ansi
echoerr() { printf "%s\n" "$*" >&2; }
red=`tput setaf 1`
green=`tput setaf 2`
white=`tput setaf 7`
cyan=`tput setaf 6`
reset=`tput sgr0`

die () {
    echo >&2 "$@"
    exit 3
}
