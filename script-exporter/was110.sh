#!/usr/bin/env sh
token=d1286d8b0d5fe50c35e0d5a2a1841341
was_ip=10.110.0.110

curl -k --silent  --cookie "sysauth=$token" "https://$was_ip/cgi-bin/luci/admin/8311/pontop/optical" | \
grep -E '^Optical|^Recei|^Transm|^Transce' | \
sed \
  -e 's/^Optical\stransceiver\stemperature\s*:\s\([0-9\.-]*\).*/# TYPE optical_transceiver_temperature gauge\noptical_transceiver_temperature{sfp=\"was110\",unit=\"celsius\"} \1/' \
  -e 's/^Receiver\sstatus\s*:\s\([A-Za-z]*\).*/# TYPE optical_receiver_status gauge\noptical_receiver_status{sfp=\"was110\",status="\1"} 1/' \
  -e 's/^Transmitter\sstatus\s*:\s\([A-Za-z]*\).*/# TYPE optical_transmitter_status gauge\noptical_transmitter_status{sfp=\"was110\",status="\1"} 1/' \
  -e 's/^Transmit\spower\s*:\s\([0-9\.-]*\)\s*\([A-Za-z]*\)/# TYPE optical_transmit_power gauge\noptical_transmit_power{sfp=\"was110\",unit=\"\2\"} \1/' \
  -e 's/^Receive\spower\s*:\s\([0-9\.-]*\)\s*\([A-Za-z]*\)/# TYPE optical_receive_power gauge\noptical_receive_power{sfp=\"was110\",unit=\"\2\"} \1/' \
  -e 's/^Transceiver\ssupply\svoltage\s*:\s\([0-9\.-]*\)\s*\([A-Za-z]*\)/# TYPE optical_transceiver_supply_voltage gauge\noptical_transceiver_supply_voltage{sfp=\"was110\",unit=\"\2\"} \1/' \
  -e 's/^Transmit\sbias\scurrent\s*:\s\([0-9\.-]*\)\s*\([A-Za-z]*\)/# TYPE optical_transmit_bias_current gauge\noptical_transmit_bias_current{sfp=\"was110\",unit=\"\2\"} \1/'
