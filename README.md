# <div align="center"><strong>[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=DotGothic16&size=41&width=800&height=60&lines=💀+IP+Flooder+💥&center=true&vCenter=true&color=FF0000)](https://git.io/typing-svg)</strong></div>

<br>

<div align="center">
  <p>This script is a powerful tool to perform SYN flood attacks on specified target hosts within your local network. Leveraging <code>hping3</code> for the flood attack and <code>ipcalc</code> to ensure target IPs are valid, it gives you a glimpse into the world of network testing.</p>
</div>

---

## 🛠️ Prerequisites

Before running this script, ensure you have the following installed on your system:

- `hping3` 📡
- `ipcalc` 🔍

Install these tools using your package manager. For example, on Ubuntu:

```sh
sudo apt-get install hping3 ipcalc
```

## 🚀 Usage

1. **Clone the repository**:

```sh
git clone https://github.com/B3TA-BLOCKER/IP-Flooder.git
```

2. **Navigate to the project directory**:

```sh
cd IP-Flooder
```

3. **Make the script executable**:

```sh
chmod +x main.sh
```

4. **Run the script**:

```sh
sudo ./main.sh
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

---

## ⚠️ Important Notes

- **Caution**: SYN flood attacks can cause network disruptions and are considered malicious activity. Use this script responsibly and only in environments where you have explicit permission to perform such actions.
- **Permissions**: The script uses `sudo` to run `hping3`. Ensure you have the necessary permissions to execute commands with `sudo`.
- **Logging**: Each attack's output is logged to a file named after the target IP address, e.g., `192.168.1.1_attack.log`.

---

## 📝 Disclaimer

**This script is provided for educational purposes only. The author is not responsible for any misuse or damage caused by using this script.**

---

## 🛡️ License

This project is licensed under the [MIT License](LICENSE).

---

## 📞 Contact

For support or questions, feel free to reach out:

- **GitHub Profile**: [B3TA-BLOCKER](https://github.com/B3TA-BLOCKER)
- **Email**: hassaanalibukhari@gmail.com

---
