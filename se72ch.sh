#!/bin/bash


echo -e "\e[1;36m"
figlet -f pagga.tlf "se72ch"
echo "V 2.0 | By Ali Drabkih"
banner() {
    cat << "EOF" 

░░░░░░███████ ]▄▄▄▄▄▄▄▄
 ▂▄▅█████████▅▄▃▂        
[███████████████████]. 
◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤.. 
EOF
}

banner
echo -e "\n[+] [-h/--help] [--live] [--fuzz] [-p/--parameters]"

echo -e "\e[0m"


####################################################################################################################################################################
usage() {

   #echo -e "\e[1;32m"
   echo -e "\n\n[+] se72ch noob version 2.0 is a tool for automating reconnaissance tasks. It gathers information about a target domain, including subdomains and URLs, using OSINT tools like theHarvester, dirsearch, and httprobe. It verifies URL status codes and performs fuzzing to uncover hidden pages, enhancing security assessments and penetration testing engagements.\n"
   echo -e "[+] Usage: $0 [--live] [--fuzz] [-p/--parameters] \n\n"
   echo -e "--live            : to check the status codes of discovered URLs.\n"
   echo -e "--fuzz            : to perform fuzzing on discovered URLs.\n"
   echo -e "--parameters / -p : to discovered website parameters.\n"
   #echo -e "\e[0m"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    usage
    exit 0
fi

for arg in "$@"; do
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
        usage
        exit 0
    fi
done
#################################################################################################################################

if [ "$(id -u)" = "0" ]; then
    echo -e "\e[31m[x] Error: se72ch noob must not be run as root, Please change your user to anything else\e[0m" 
    exit 1
fi
####################################################################################################################################################################

if [[ "$@" == *"--fuzz"* ]]; then

    if [[ "$@" != *"--live"* ]]; then
        echo -e "\e[31m[x] Error: --fuzz cannot be used without --live.\e[0m"
        exit 1
    fi
fi

###################################################################################################################################################################
read -p "TARGET DOMAIN: " TARGET 

####################################################################################################################################

if [[ "$TARGET" == *"/"* ]]; then
    echo -e "\e[31m[x] Error: Please enter the domain name only, without pages or protocols\e[0m"
    exit 1
fi


if (( ${#TARGET} < 1 || ${#TARGET} > 63 )); then
    echo -e "\e[31m [x] Error: invalid domain\e[0m"
    exit 1
fi


if [[ "$TARGET" == *" "* ]]; then
    echo -e "\e[31m[x] Error:invalid domain\e[0m"
    exit 1
fi

if [[ "$TARGET" != *"."* ]]; then
    echo -e "\e[31m[x] Error:invalid domain\e[0m"
    exit 1
fi
####################################################################################################################################################################

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if ! command_exists theHarvester; then
    echo -e "\e[1;31m[x] Error theHarvester: Please install requirements before running se72ch.\e[0m"
    exit 1
fi


if ! command_exists figlet; then
    echo -e "\e[1;31m[x] Error: Please run requirements.sh before running se72ch.\e[0m"
    exit 1
fi

if ! command_exists dirsearch; then
    echo -e "\e[1;31m[x] Error figlet: Please run requirements.sh before running se72ch.\e[0m"
    exit 1
fi

if ! command_exists curl; then
    echo -e "\e[1;31m[x] Error curl: Please run requirements.sh before running se72ch.\e[0m"
    exit 1
fi
if ! command_exists jq; then
    echo -e "\e[1;31m[x] Error jq: Please run requirements.sh before running se72ch.\e[0m"
    exit 1
fi
if ! command_exists pyhton3; then
    echo -e "\e[1;31m[x] Error pyhton3: Please run requirements.sh before running se72ch.\e[0m"
    exit 1
fi
####################################################################################################################################################################
cd $HOME

cd Desktop/

rm -r -f ${TARGET}

mkdir ${TARGET}

echo -e "\033[0;35mwe work at: $HOME/Desktop/${TARGET}/ \033[0m"
####################################################################################################################################################################
if [[ "$@" =~ "--parameters" || "$@" =~ "-p" ]]; then
    
    if [[ "$@" =~ "--live" || "$@" =~ "--fuzz" ]]; then
        python3 /var/ParamSpider/paramspider.py --domain "${TARGET}" --output "$HOME/Desktop/${TARGET}/parameters.txt" | grep "${TARGET}"
        echo -e "\e[1;31"
        figlet -f pagga.tlf "SUBDOMAINS?"
        echo -e "\e[0m"
    else

        python3 /var/ParamSpider/paramspider.py --domain "${TARGET}" --output "$HOME/Desktop/${TARGET}/parameters.txt" | grep "${TARGET}"
        exit 1
    fi
fi
####################################################################################################################################################################
cd ${TARGET}

echo -e "baidu\nbufferoverun\ncrtsh\nhackertarget\notx\nprojectdiscovery\nrapiddns\nsublist3r\nthreatcrowd\ntrello\nurlscan\nvhost\nvirustotal\nzoomeye" > sources.txt

cat $HOME/Desktop/${TARGET}/sources.txt | while read source; do theHarvester -d "${TARGET}" -b $source -f "${source}_${TARGET}" | grep ${TARGET} | grep -v "Target:" | grep -v "@" | grep -oE 'https?://[^:]*|^[^:]*' | sort -u ;done 

cat *.json | jq -r '.hosts[]' 2>/dev/null | cut -d':' -f 1 | sort -u > "subdomin.txt"

echo -e "\033[0;35m\n\nwe save the subdomins at: $HOME/Desktop/${TARGET}/subdomin.txt\033[0m"

cat subdomin.txt | httprobe > https.txt

rm -r *.xml

rm -r *.json

rm -r sources.txt

echo -e "\033[0;35mwe save the URLs at: $HOME/Desktop/${TARGET}/https.txt\033[0m"
####################################################################################################################################################################

if [[ "$@" == *"--live"* ]]; then

    cd $HOME/Desktop/${TARGET}
    echo "-----------------------------------------"
    echo -e "\e[1;31m"
    figlet -f pagga.tlf "STATUS CODE?" 
    echo -e "\e[0m"
    echo "-----------------------------------------"

    DOMAINS_FILE="https.txt"
    if [ ! -f "$DOMAINS_FILE" ]; then
        echo -e "\033[0;31mFile not found: $DOMAINS_FILE\033[0m"
        exit 1
    fi

    while IFS= read -r DOMAIN || [ -n "$DOMAIN" ]; do
        if [ -z "$DOMAIN" ]; then
            continue
        fi
        

        STATUS_CODE=$(curl -sIL -o /dev/null -w "%{http_code}" --max-time 10 "$DOMAIN")

        case $STATUS_CODE in
            2*) STATUS_COLOR="\033[0;32m" ;; # Green color for 2xx status codes
            3*) STATUS_COLOR="\033[0;34m" ;; # Blue color for 3xx status codes
            4*) STATUS_COLOR="\033[0;31m" ;; # Red color for 4xx status codes
            *)  STATUS_COLOR="\033[0m" ;;    # White color for other status codes
        esac

        if [ $STATUS_CODE -lt 400 ] && [ $STATUS_CODE != "000" ]; then
            echo "$DOMAIN" >> live.txt
        fi
        printf "$DOMAIN \033[0m$STATUS_COLOR$STATUS_CODE\033[0m\n"
    done < "$DOMAINS_FILE"
    echo -e "\033[0;35m\n\nwe save the live subdomin at: $HOME/Desktop/${TARGET}/live.txt\033[0m"

    if [[ "$@" == *"--fuzz"* ]]; then

        echo "-----------------------------------------"
        echo -e "\e[1;31m"
        figlet -f pagga.tlf "FUZZING!"
        echo -e "\e[0m"
        echo "-----------------------------------------"
        urls_file="$HOME/Desktop/${TARGET}/live.txt"

        if [ ! -f "$urls_file" ]; then
             echo -e "\033[0;31mFile not found: $urls_file\033[0m"
             exit 1
        fi

        while IFS= read -r url; do
            echo "Scanning $url"

            dirsearch -q -u "$url" 2>/dev/null | grep -v "404"
        done < "$urls_file"
        echo -e "\033[0;35m\n\nwe save the fuzzing report at: $HOME/Desktop/${TARGET}/report\033[0m"
    fi

fi
