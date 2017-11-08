## qemu-blockstats

Qemu/virsh block device utilization metrics (read/write op/s and bytes/s)

* UserParameters
  * qemu-blockstats.discovery: discover domains and block devices
  * qemu-blockstats.collect: collect blockstats for specific domain, args: [domain,block_device_count,seconds]
  * qemu-blockstats.metric: parse metrics, args: [domain,block_device_count,metric]

<br>

* scripts
  * qemu-blockstats-collect.sh: collect blockstats for specific domain
  * qemu-blockstats-discovery.sh: discover domains and block devices
  * qemu-blockstats-parse.sh: parse collected data

<br>

* templates
  * template_qemu-blockstats.xml

## Dependencies

* virsh
* password-less sudo for virsh
