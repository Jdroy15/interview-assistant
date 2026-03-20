#!/bin/bash
# setup_audio.sh — Route laptop speakers to virtual mic on Linux
# Run this before your interview. Works on PulseAudio and PipeWire.

echo "=== Interview Assistant — Linux Audio Setup ==="
echo ""

# Detect audio system
if command -v pw-cli &>/dev/null; then
    AUDIO_SYSTEM="pipewire"
elif command -v pactl &>/dev/null; then
    AUDIO_SYSTEM="pulseaudio"
else
    echo "❌ Neither PipeWire nor PulseAudio found."
    exit 1
fi

echo "✓ Detected: $AUDIO_SYSTEM"
echo ""

# Load loopback — this routes speakers output to a monitor source
# that Chrome can access as a microphone
echo "Loading loopback module..."
MODULE_ID=$(pactl load-module module-loopback latency_msec=1 2>/dev/null)

if [ $? -eq 0 ]; then
    echo "✓ Monitor source active (module ID: $MODULE_ID)"
    echo ""
    echo "=== NEXT STEPS ==="
    echo "1. Open Chrome → go to your interview assistant page"
    echo "2. Click Start Listening"
    echo "3. When Chrome asks for microphone → click the camera icon in address bar"
    echo "4. Select 'Monitor of Built-in Audio' (or similar) as the microphone"
    echo "5. Done! The app will now hear everything from Google Meet/Teams"
    echo ""
    echo "To undo (after interview):"
    echo "  pactl unload-module $MODULE_ID"
    echo ""
    # Store module ID for cleanup
    echo $MODULE_ID > /tmp/ia_loopback_id
else
    echo "⚠ Could not load loopback. Trying alternative..."
    # Try creating a null sink as virtual speaker
    pactl load-module module-null-sink sink_name=ia_speaker sink_properties=device.description="Interview_Virtual_Speaker"
    pactl load-module module-loopback source=ia_speaker.monitor
    echo "✓ Virtual speaker created. In Google Meet/Teams → Audio settings → select 'Interview_Virtual_Speaker' as output"
    echo "  Then in this app → select 'Monitor of Interview_Virtual_Speaker' as mic"
fi

echo ""
echo "=== Current audio sources (microphone options in Chrome) ==="
pactl list short sources | grep -v ".monitor" | awk '{print NR". "$2}'
echo ""
echo "Monitor sources (capture speaker output):"
pactl list short sources | grep ".monitor" | awk '{print NR". "$2}'
