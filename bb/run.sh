#!/bin/bash

# Note: Mininet must be run as root.  So invoke this shell script
# using sudo.

time=100
bwnet=1.5

delay=5

iperf_port=80

for qsize in 10; do
    dir=bb-q$qsize

	python bufferbloat.py -b $bwnet --delay $delay --dir $dir --maxq $qsize --time $time

    python plot_tcpprobe.py -f $dir/cwnd.txt -o $dir/cwnd-iperf.png -p $iperf_port
    python plot_queue.py -f $dir/q.txt -o $dir/q.png
    python plot_ping.py -f $dir/ping.txt -o $dir/rtt.png
    cp $dir/cwnd-iperf.png ./cwind-q$qsize.png
    cp $dir/q.png ./buffer-q$qsize.png
    cp $dir/rtt.png ./rtt-q$qsize.png
done