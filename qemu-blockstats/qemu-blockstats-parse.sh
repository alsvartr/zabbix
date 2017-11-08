{% raw -%}
#!/bin/bash

VM="$1"
COUNT=$2
METRIC="$3"
TMP_DIR="/tmp/zabbix/qemu-blockstats/"
STAT_FILE="$TMP_DIR/qemu-bs-$VM-$COUNT"

[[ $# -lt 3 ]] && { echo "FATAL: some parameters not specified"; exit 1; }
[[ -f "$STAT_FILE" ]] || { echo "FATAL: datafile not found"; exit 1; }

case "$METRIC" in
"wrop/s")
        POS=1
;;
"rdop/s")
        POS=2
;;
"wrbytes/s")
        POS=3
;;
"rdbytes/s")
        POS=4
;;
*) echo ZBX_NOTSUPPORTED; exit 1 ;;
esac

cat $STAT_FILE | awk -F';' -v N=$POS 'BEGIN {sum=0.0;count=0;} {sum=sum+$N;count=count+1;} END {printf("%.2f\n", sum/count);}'
{%- endraw %}
