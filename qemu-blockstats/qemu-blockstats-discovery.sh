{% raw -%}
#!/bin/bash

TMP_DIR="/tmp/zabbix/qemu-blockstats/"
if [ ! -d "$TMP_DIR" ]; then
        install -o zabbix -d $TMP_DIR
fi

## get active VMs from virsh
sudo virsh list --uuid 2> /dev/null > $TMP_DIR/qemu-bs_virsh-out
virsh=`cat $TMP_DIR/qemu-bs_virsh-out`
num_vms=`echo "$virsh" | wc -l`
count_vms=0
echo -n "" > $TMP_DIR/qemu-bs_virsh-domblklist

printf "{\n\t\"data\":[\n"

for vm in $virsh
do
	count_vms=$(($count_vms+1))
	vols=`sudo virsh domblklist $vm 2> /dev/null | grep -vi Target | grep -E "[a-z]+\s+" | awk '{print $2}'`
	num_vols=`echo "$vols" | wc -l`

	count_vols=0
	for vol in $vols
	do
		vol=`echo $vol | awk -F'/' '{print $2}'`

		## printing volumes data for zabbix
		printf "\t\t{\n\t\t\t\"{#VOLUME}\":\"$vol\", \"{#VM}\":\"$vm\", \"{#COUNT}\":\"$count_vols\"}"

		if [ "$count_vols" != "$num_vols" ]; then
			if [ "$count_vms" != "$num_vms" ]; then
		                printf ",\n"
			fi
		fi

		echo "${vol};${vm};${count_vols}" >> $TMP_DIR/qemu-bs_virsh-domblklist
		count_vols=$(($count_vols+1))
	done
done

printf "]}\n"
{%- endraw %}
