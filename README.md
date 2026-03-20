# Interview Assistant

A transparent, always-on-top interview assistant that listens to your interview and generates instant answers using Groq AI.

## 🚀 Live App

## Setup (2 minutes)

### 1. Get a free Groq API key
Go to [console.groq.com](https://console.groq.com) → Sign up → API Keys → Create Key

### 2. Enable audio capture on Linux (for interviewer's voice)

**Option A — PulseAudio Monitor (easiest, no install):**
```bash
# Load the loopback module — routes speakers → virtual mic
pactl load-module module-loopback latency_msec=1
```
Then in Chrome: Settings → Privacy → Microphone → select **"Monitor of …"** device

**Option B — PipeWire (modern Linux):**
```bash
pactl load-module module-loopback latency_msec=1
# or
pw-loopback
```

**Option C — Virtual cable with PulseAudio:**
```bash
# Create a null sink
pactl load-module module-null-sink sink_name=virtual_speaker sink_properties=device.description=VirtualSpeaker
pactl load-module module-loopback source=virtual_speaker.monitor sink=@DEFAULT_SINK@
# Set virtual_speaker as output in your Meet/Teams audio settings
```

### 3. Open the app in Chrome
- Go to your GitHub Pages URL
- Chrome remembers microphone permission permanently for this domain ✅
- No more permission popups ever

## How to use

1. Paste your Groq API key → Save
2. Add your role/context (optional but recommended)
3. Select audio source: **Monitor** (best), **Tab Audio**, or **Mic**
4. Click **▶ Start Listening**
5. Interviewer speaks → transcript builds live → answer appears automatically
6. Adjust **silence delay** slider if it answers too fast/slow

## Tips
- Set **opacity** low so the window is invisible to screen share
- Use the **transcript box** to edit/correct what was heard before submitting
- Use **manual input** to type/paste questions directly
- The app runs for **hours** without stopping or prompting

## Deploy your own
```bash
git clone https://github.com/YOUR_USERNAME/interview-assistant
# Just push index.html to main branch, enable GitHub Pages in repo settings
```
