[ "${ACTION}" = "add" -o "${ACTION}" = "remove" ] || exit 0
[ "${SUBSYSTEM}" = "tty" ] || exit 0
[ -n "${DEVNAME}" -a -n "${DEVPATH}" ] || exit 1

if [ "${ACTION}" = "add" ]; then
	subsystem="$(basename $(readlink /sys${DEVPATH}/../../../subsystem))"

	[ "$subsystem" = "usb" ] || exit 0

	manufacturer="$(cat /sys${DEVPATH}/../../../../manufacturer)" || manufacturer="$(cat /sys${DEVPATH}/../../../../idVendor)"
	product="$(cat /sys${DEVPATH}/../../../../product)" || product="$(cat /sys${DEVPATH}/../../../../idProduct)"
	serial="$(cat /sys${DEVPATH}/../../../../serial)"
	interface="$(cat /sys${DEVPATH}/../../../bInterfaceNumber)"
	port="$(cat /sys${DEVPATH}/device/port_number)"

	id_link=$(echo "${subsystem}"-"${manufacturer}"_"${product}${serial:+_}${serial}"-if"${interface}${port:+-port}${port}" | sed s/[^\.\:0-9A-Za-z-]/_/g)
	path_link=$(echo "${DEVPATH}${port:+-port}${port}" | sed s%/devices/%% | sed s%/${DEVNAME}/tty/${DEVNAME}%%g | sed s/[^\.\:0-9A-Za-z-]/_/g)

	mkdir -p /dev/serial/by-id /dev/serial/by-path
	ln -sf "/dev/${DEVNAME}" "/dev/serial/by-id/${id_link}"
	ln -sf "/dev/${DEVNAME}" "/dev/serial/by-path/${path_link}"
elif [ "${ACTION}" = "remove" ]; then
	for link in $(find /dev/serial -type l); do
		[ -L ${link} -a "$(readlink ${link})" = "/dev/$DEVNAME" ] && rm ${link}
	done
fi
