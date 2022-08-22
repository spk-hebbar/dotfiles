#!/bin/sh
# SPDX-License-Identifier: MIT
# Copyright (c) 2022 Robin Jarry

print_numa() {
	path="$1"
	numa_id="${path#/sys/bus/node/devices/node}"

	echo "NUMA $numa_id"
	echo "======"
	echo
	memory=$(sed -nre 's/^Node [0-9]+ MemTotal:[[:space:]]+([0-9]+) kB/\1/p' "$path/meminfo")
	echo "Memory: $((memory / 1024 / 1024))GB"
	hugepages="$path/hugepages/hugepages-2048kB/nr_hugepages"
	if [ -r "$hugepages" ]; then
		echo "2MB hugepages: $(cat $hugepages)"
	fi
	hugepages="$path/hugepages/hugepages-1048576kB/nr_hugepages"
	if [ -r "$hugepages" ]; then
		echo "1GB hugepages: $(cat $hugepages)"
	fi
	echo
	echo CPUs
	echo ----
	echo
	lscpu | grep -e '^Model name:' -e '^CPU .*MHz'
	echo Cores IDs:
	cat $path/cpu*/topology/core_cpus_list | sort -un | column | cat
	echo
	echo NICs
	echo ----
	echo
	unset numa
	lspci -vmmkDd ::0200 |
	while read -r field value; do
		case "$field" in
		Slot:)
			slot="$value"
			;;
		Device:)
			device="$value"
			;;
		NUMANode:)
			numa="$value"
			;;
		Driver:)
			driver="$value"
			;;
		"")
			if [ -z "$numa" ]; then
				numa=0
			fi
			if [ "$numa" != "$numa_id" ]; then
				unset slot device driver
				continue
			fi
			for iface in "/sys/bus/pci/devices/$slot/net"/*; do
				if [ -d "$iface" ]; then
					ifname=$(basename $iface)
					mac=$(cat $iface/address)
					carrier=$(cat $iface/carrier)
					state=$(cat $iface/operstate)
					speed=$(cat $iface/speed)
					if [ "$speed" = "-1" ]; then
						speed="-"
					else
						speed="$((speed / 1000))Gb/s"

					fi
				else
					ifname="-"
					mac="-"
					carrier="-"
					state="-"
					speed="-"
				fi
				printf '%s;%s;%s;%s;%s;%s;%s\n' \
					"$slot" "${driver:--}" "$ifname" \
					"$mac" "$carrier/$state" "${speed}" \
					"$device"
			done
			unset slot device driver
			;;
		esac
	done |
	column --table -s ";" -N SLOT,DRIVER,IFNAME,MAC,LINK/STATE,SPEED,DEVICE
	echo
}

for numa in /sys/bus/node/devices/node*; do
	if [ -d "$numa" ]; then
		print_numa "$numa"
	fi
done
