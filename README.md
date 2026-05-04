# 🖥️ Server Monitor

Bash script for monitoring server resources: CPU, memory, and disk usage.

## Features
- Monitors CPU, memory, and disk usage
- Alerts when usage exceeds set limits
- Logs results to a file with timestamps
- Can be automated with cron

## Usage

Make the script executable:
chmod +x monitoring.sh

Run the script:
./monitoring.sh

## Automate with cron (every 5 minutes)
crontab -e

Add this line:
*/5 * * * * /path/to/monitoring.sh

## Tech stack
- Bash
- cron
