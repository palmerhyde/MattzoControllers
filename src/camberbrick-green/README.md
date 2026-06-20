# Camberbrick Green v2

## Project Overview

Camberbrick Green is a LEGO train layout controlled by:

* Rocrail
* Mattzo Bricks MTC4BT controllers
* ESP32 controllers
* LEGO Powered Up hubs
* MQTT messaging

This project is being migrated from an older Windows and custom WiFi access point architecture to a new Mac-based architecture.

---

# Current Status

## Development Machine

* MacBook Pro M1
* macOS Tahoe
* VS Code
* PlatformIO installed
* Homebrew installed

---

## Network Architecture

Previous architecture:

* Custom ESP8266 access point
* Separate MQTT server
* Static IP dependencies
* Boot order dependencies
* Windows development machine

New architecture:

* Comcast XB8 WiFi
* MacBook Pro as server
* mDNS hostname resolution
* Mosquitto MQTT
* No custom access point
* No static IP requirements

---

# Hostnames

Mac hostname:

```
camberbrickgreen.local
```

MQTT broker:

```
camberbrickgreen.local
```

---

# WiFi

SSID:

```
BilliBoo
```

Controllers connect directly to the home WiFi.

The old "Camberbrick Green" access point is retired.

---

# MQTT

Mosquitto is installed through Homebrew.

Service:

```
brew services start mosquitto
```

Current configuration:

```conf
listener 1883 0.0.0.0
allow_anonymous true

persistence true
persistence_location /opt/homebrew/var/lib/mosquitto/

log_dest stdout
log_type error
log_type warning
log_type notice
log_type information
connection_messages true
```

MQTT tests:

```
mosquitto_sub -h camberbrickgreen.local -t test

mosquitto_pub -h camberbrickgreen.local -t test -m "hello"
```

Status:

* Working
* Anonymous access enabled
* Hostname resolution working

---

# PlatformIO

PlatformIO builds successfully.

Current environment:

```
esp32
```

PlatformIO configuration:

```
my_platformio.ini
```

Important setting:

```ini
data_dir = $PROJECT_DIR/data
```

This means:

```
data/network.json
data/controller.json
```

are uploaded to the ESP32 filesystem.

---

# Build Process

Firmware build:

```
PlatformIO Build
```

Firmware upload:

```
PlatformIO Upload
```

Filesystem upload:

```
pio run --target uploadfs
```

Configuration changes require uploadfs.

## macOS flashing notes (MTC4BT)

Gotchas hit when first flashing on the M1 Mac (all resolved):

* **PlatformIO CLI** isn't on PATH — use the bundled binary:
  `~/.platformio/penv/bin/pio run -e esp32` (build), `-t upload` (firmware),
  `-t uploadfs` (configs). Or just use the VS Code PlatformIO buttons.
* **`intelhex` missing:** build fails with `ModuleNotFoundError: No module named
  'intelhex'`. Fix once: `~/.platformio/penv/bin/pip install intelhex`.
* **`data_dir` needs a leading slash on macOS:** in `my_platformio.ini` set
  `data_dir = /$PROJECT_DIR/data`, otherwise `uploadfs` fails with
  "can't read source directory".
* **Serial port** is `/dev/cu.usbserial-0001` (CP2102 bridge, no driver needed).
  Set `upload_com_port` to this in `my_platformio.ini` (was a stale Windows `COM3`).
* Use a **data** micro-USB cable — charge-only cables power the board (red LED on)
  but never enumerate. Check with `ioreg -p IOUSB -l`.

`my_platformio.ini` and `data/` are gitignored (machine-specific), so these
settings live locally only.

---

# Controller Configuration

network.json contains:

* WiFi settings
* MQTT settings
* hostname
* OTA settings
* logging

Example:

```json
{
  "network": {
    "hostname": "mtc4bt-1",
    "otaPassword": "",
    "type": "wireless"
  },
  "wifi": {
    "SSID": "BilliBoo",
    "password": "REDACTED"
  },
  "mqtt": {
    "broker": "camberbrickgreen.local",
    "port": 1883
  }
}
```

---

# Naming Convention

Controller hostnames:

* mtc4bt-1
* mtc4bt-2
* mtc4bt-yard
* mtc4bt-station

Syslog app names should match the controller.

---

# Current Hardware

* ESP32 MTC4BT controller (flashed and working on macOS)
* LEGO Powered Up hubs
* Mattzo controllers
* Rocrail layout (restored — version-controlled in `Rocrail/`, auto-opens in Rocrail)
* MQTT broker on Mac (Mosquitto)

---

# Retired Infrastructure

The following should be considered obsolete:

* Windows development machine
* Custom ESP8266 access point
* Old MQTT broker
* Static IP dependencies
* Boot-order dependencies

Do not reference these systems unless migrating data.

---

# Immediate Goal — ACHIEVED

Successfully flash one MTC4BT controller. ✅ (achieved 2026-06-20)

Success criteria (all met):

1. ✅ Controller joins BilliBoo WiFi.
2. ✅ Controller resolves camberbrickgreen.local.
3. ✅ Controller connects to MQTT.
4. ✅ Controller communicates with Powered Up hubs.

First locomotive verified end-to-end: **60197** (Rocrail address 1), driven
forward/reverse with working lights (F1) via RocView → Rocrail → MQTT → MTC4BT
→ Bluetooth. The board serial port on this Mac is `/dev/cu.usbserial-0001`.

---

# Completed

* ✅ Install Rocrail on Mac.
* ✅ Restore Rocrail layout from backup (now in `Rocrail/`, auto-opens on launch).
* ✅ Flash MTC4BT controller and test the first locomotive.

# Future Goals

* Test remaining locomotives (60052, 10233, 10194, and others).
* Enable OTA updates.
* Add additional controllers.
* Enable syslog if needed.
* Remove remaining Windows dependencies.

---

# Rules For AI Agents

* Prefer hostnames over IP addresses.
* Never modify configuration files without making backups.
* Preserve existing controller.json definitions.
* Avoid introducing static IP requirements.
* Keep the architecture simple.
* One change at a time.
* Validate changes before moving to the next step.

The goal is reliability and maintainability rather than experimentation.



### liams notes
/opt/homebrew/opt/mosquitto/sbin/mosquitto -c /opt/homebrew/etc/mosquitto/mosquitto.conf

Initialize Camberbrick Green development environment

- Add repository root to workspace
- Add Camberbrick Green documentation folder
- Ignore macOS .DS_Store files
- Migrate development environment to macOS
- Rename default branch to main