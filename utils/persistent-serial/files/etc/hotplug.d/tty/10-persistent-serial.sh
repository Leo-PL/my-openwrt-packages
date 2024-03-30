set -o pipefail
[ "${ACTION}" = "bind" -o "${ACTION}" = "unbind" ] || exit 0
[ "${SUBSYSTEM}" = "usb-serial" ] || exit 0
[ -n "${DEVICENAME}" -a -n "${DEVPATH}" ] || exit 1

if [ "${ACTION}" = "bind" ]; then
	subsystem="$(basename $(readlink /sys${DEVPATH}/../subsystem))"

	[ "$subsystem" = "usb" ] || exit 0

	replace_whitespace="s/^[ \t]*|[ \t]*$//g; s/[ \t]+/_/g"
	manufacturer="$(cat /sys${DEVPATH}/../../manufacturer | sed -E "${replace_whitespace}")" || manufacturer="$(cat /sys${DEVPATH}/../../idVendor)"
	product="$(cat /sys${DEVPATH}/../../product | sed -E "${replace_whitespace}")" || product="$(cat /sys${DEVPATH}/../../idProduct)"
	serial="$(cat /sys${DEVPATH}/../../serial | sed -E "${replace_whitespace}")"
	interface="$(cat /sys${DEVPATH}/../bInterfaceNumber)"
	port="$(cat /sys${DEVPATH}/port_number)"

	replace_chars="s/[^0-9A-Za-z#+.:=@-]/_/g"
	id_link=$(echo "${subsystem}"-"${manufacturer}"_"${product}${serial:+_}${serial}"-if"${interface}${port:+-port}${port}" | sed "${replace_chars}")
	path_link=$(echo "${DEVPATH}${port:+-port}${port}" | sed "s%/devices/%%; s%/${DEVICENAME}%%g; ${replace_chars}")

	mkdir -p /dev/serial/by-id /dev/serial/by-path
	ln -sf "/dev/${DEVICENAME}" "/dev/serial/by-id/${id_link}"
	ln -sf "/dev/${DEVICENAME}" "/dev/serial/by-path/${path_link}"
elif [ "${ACTION}" = "unbind" ]; then
	for link in $(find /dev/serial -type l); do
		[ -L ${link} -a "$(readlink ${link})" = "/dev/$DEVICENAME" ] && rm ${link}
	done
fi
