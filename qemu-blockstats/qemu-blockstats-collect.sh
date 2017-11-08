{% raw -%}
#!/bin/bash

VM="$1"
COUNT=$2
SECONDS=$3
TMP_DIR="/tmp/zabbix/qemu-blockstats/"

if [ ! -d "$TMP_DIR" ]; then
	install -o zabbix -d $TMP_DIR
fi

wr_operations_prev=0
rd_operations_prev=0
wr_bytes_prev=0
rd_bytes_prev=0

echo -n "" > $TMP_DIR/qemu-bs-$VM-$COUNT
for i in `seq 1 $(($SECONDS+1))`
do
	stats=`sudo virsh qemu-monitor-command $VM '{"execute":"query-blockstats"}'`
	wr_operations=`echo $stats | jq ".return[$COUNT].stats.wr_operations"`
	rd_operations=`echo $stats | jq ".return[$COUNT].stats.rd_operations"`
	wr_bytes=`echo $stats | jq ".return[$COUNT].stats.wr_bytes"`
	rd_bytes=`echo $stats | jq ".return[$COUNT].stats.rd_bytes"`

	wr_operations_diff=$(($wr_operations-$wr_operations_prev))
	rd_operations_diff=$(($rd_operations-$rd_operations_prev))
	wr_bytes_diff=$(($wr_bytes-$wr_bytes_prev))
	rd_bytes_diff=$(($rd_bytes-$rd_bytes_prev))

	if [ $i -gt 1 ]; then
		echo "$wr_operations_diff;$rd_operations_diff;$wr_bytes_diff;$rd_bytes_diff" >> $TMP_DIR/qemu-bs-$VM-$COUNT
	fi
	wr_operations_prev=$wr_operations
	rd_operations_prev=$rd_operations
	wr_bytes_prev=$wr_bytes
	rd_bytes_prev=$rd_bytes

	sleep 0.96
done
echo 0
{%- endraw %}
