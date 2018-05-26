#!/usr/bin/env bash

if [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` ATSD_HOSTNAME TCP_PORT [ENTITY]"
  exit 0
fi

metric="kafka.consumer_offset"
entity=""
if [ -z "$3" ]
then
        domain_name=$(hostname -f)
        if [[ $domain_name = 'localhost' ]] || [[ $domain_name = 'localhost.localdomain' ]]
        then
                domain_name=$(hostname)
        fi
        entity=$domain_name
else
        entity=$3
fi

# for Kafka versions before 0.10.2.0 use --zookeeper option instead bootstrap-server

while true; do
if ! $(timeout 2 bash -c "</dev/tcp/$1/$2"); then
        sleep 3
        echo "[$(date +'%Y-%m-%d %T')] Unable to connect ATSD $1 $2" >&2
        continue
fi
KAFKA_JMX_OPTS="" JMX_PORT="" $(dirname $0)/kafka-console-consumer.sh --consumer-property "exclude.internal.topics=false" --formatter "kafka.coordinator.group.GroupMetadataManager\$OffsetsMessageFormatter" \
 --bootstrap-server localhost:9092 --topic __consumer_offsets | grep --line-buffered -v "\[.*\,.*_.*\,.*\]::.*\|\[.*\]::NULL" | stdbuf -o0 awk -v entity="$entity" \
'match($0, /\[.*\]::/) { split(substr( $0, RSTART+1, RLENGTH-4 ), meta, ",") } \
 match($0, /OffsetMetadata\[([^,]+)/) { offset=substr( $0, RSTART+15, RLENGTH-15 ) } \
 match($0, /CommitTime\ ([^,]+)/) { time=substr( $0, RSTART+11, RLENGTH-11 )} \
 {print "series e:" entity " m:kafka.consumer_offset=" offset " t:groupid=\"" meta[1] "\" t:topic=\"" meta[2] "\" t:partition=" meta[3] " ms:" time}' |\
 tee >(cat > /dev/tcp/"$1"/"$2")
echo "[$(date +'%Y-%m-%d %T')] ATSD connection closed on $1 $2" >&2
done

