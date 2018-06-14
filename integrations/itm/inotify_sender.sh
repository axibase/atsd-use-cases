#!/bin/bash
workDir="/tmp/itm" #"`dirname $(readlink -f $0)`"
url="$1"
logPostfix="`date +%s`"
newcsvLog="$workDir/logs/newcsv_${logPostfix}.log"
sendcsvLog="$workDir/logs/send_${logPostfix}.log"
cleanLog="$workDir/logs/cleaner_${logPostfix}.log"
csvDir="$workDir/csv"
tmpDir="$workDir/tmp"
stopLog="$workDir/logs/stop.log"

if [ "$url" = "" ]; then
	url="http://atsd_host:8088"
fi
touch $newcsvLog

function clean_up {
    echo "clean_up calling in `date` ..."
    ps -ef | grep "inotifywait -qdm --format %f -e moved_to -o $newcsvLog $csvDir" | awk '{print $2}' | xargs kill -9
    ps -ef | grep "$0" | awk '{print $2}' | xargs kill -9

}

trap clean_up SIGINT SIGTERM

function cleaner {
    while :
    do
        find $csvDir/ -type f -mmin +1 -mmin -4 -exec basename {} \; | while read csvName
        do
    	    send $csvName cleaner &
        done

        find $csvDir/ -type f -mmin +5 -exec basename {} \; | while read csvName
        do
	    ( grep -q "$csvName" $newcsvLog && rm -f $csvDir/$csvName && echo "rm as old: $csvDir/$csvName" >> $cleanLog ) || ( echo "not found so not removed: $csvDir/$csvName" >> $cleanLog )
        done

        sleep 65
    done
}

function send {
    csvName="$1"
    byCleaner="$2"
    tmpLog=$tmpDir/$csvName
    touch $tmpLog
    ok="awaiting response... 200"
    error="awaiting response... 500"
    type="`echo $csvName | awk -F"_20" '{print $1}'`"

    if [[ -n $(find $csvDir/$csvName -mmin -1 2>/dev/null) ]] || [ "$byCleaner" != "" ]; then
        wget -t 1 -T 10 --user=[[USER]] --password=[[PASSWORD]] --auth-no-challenge --header="Content-type:text/csv" -O - --post-file="$csvDir/$csvName" "$url/csv?config=$type&rules=true&wait=false" 2>$tmpLog
        ( grep -q "$ok" $tmpLog && echo `date`: ok $csvName $byCleaner >> $sendcsvLog && rm -f $csvDir/$csvName ) || ( grep -q "$error" $tmpLog && echo `date`: error $csvName $byCleaner >> $sendcsvLog && cat $tmpLog >> $sendcsvLog ) ||
        ( echo `date`: unknown $csvName $byCleaner >> $sendcsvLog && cat $tmpLog >> $sendcsvLog )

        echo "--------------------" >> $sendcsvLog
    fi
    rm -rf $tmpLog
}

rm -f $csvDir/*

cleaner &

inotifywait -qdm --format %f -e moved_to -o $newcsvLog $csvDir
tail -f $newcsvLog | while read csvName
do
	trap clean_up SIGINT SIGTERM

	send $csvName &
done
