#!/bin/sh
# tv_grab_file for remote XMLTV file
dflag=
vflag=
cflag=
if [ $# = 0 ]
then
    wget -q -O - https://a1.epg.wb1.xyz/epg.xml.gz | gunzip -
    exit 0
fi

for arg
do
    delim=""
    case "$arg" in
    #translate --gnu-long-options to -g (short options)
       --description) args="${args}-d ";;
       --version) args="${args}-v ";;
       --capabilities) args="${args}-c ";;
       #pass through anything else
       *) [[ "${arg:0:1}" == "-" ]] || delim="\""
           args="${args}${delim}${arg}${delim} ";;
    esac
done

eval set -- $args

while getopts "dvc" option
do
    case $option in
        d)  dflag=1;;
        v)  vflag=1;;
        c)  cflag=1;;
        \?) printf "unknown option: -%s\n" $OPTARG
            printf "Usage: %s: [--description] [--version] [--capabilities] \n" $(basename $0)
            exit 2
            ;;
    esac >&2
done

if [ "$dflag" ]
then
   printf "A1 TV"
fi
if [ "$vflag" ]
then
   printf "1.0\n"
fi
if [ "$cflag" ]
then
   printf "baseline\n"
fi

exit 0
