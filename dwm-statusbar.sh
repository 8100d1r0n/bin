#!/usr/bin/env bash
 
cpu () {
    cpuline="cpu: "
 
    # print out one bar per CPU/core
    while read line ; do
        idle=$(awk '{ print $6 }' <<< "$line" | sed 's/\..//;s/%//')
        cpuline="${cpuline}$(bar 10 0 $((100 - idle)))"
    done < <(systat -s1 -B cpu | grep "^[0-9]")
 
    echo -n "$cpuline"
}
 
mem () {
    read tot free < <(top | grep "^Memory" | sed 's,.*[0-9]*M/\([0-9]*\)M.*Free: 
\([0-9]*\)M.*,\1 \2,')
    echo -n "mem: $(bar 10 0 $tot $((tot + free)))"
}
 
bat () {
    # some weirdness goes on with the reported battery life, at 100% it can either report as 
99 or 100
    blife=$(/usr/sbin/apm -l)
    [ $blife -ge 99 ] && bbar=$(bar 10 0 100) || bbar=$(bar 10 0 $blife 99)
    echo -n "bat: $bbar"
}
 
date="$(date +"%Y.%m.%d %H:%M")"
xsetroot -name "$(cpu) $(mem) $(bat) $date"
