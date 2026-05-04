#!/bin/bash
# Настройки лимитов
CPU_LIMIT=80
MEMORY_LIMIT=80
DISK_LIMIT=90
# Дата и время
DATE=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="monitor.log"
# CPU загрузка
CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%' | cut -d. -f1)
# Память
MEMORY=$(vm_stat | awk '
/Pages active/ {active=$3}
/Pages wired/ {wired=$4}
/Pages free/ {free=$3}
END {
  used=(active+wired)*4096/1024/1024
  total=(active+wired+free)*4096/1024/1024
  printf "%.0f", used/total*100
}')
# Диск
DISK=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
# Вывод в терминал
echo "================================"
echo "  SERVER MONITOR - $DATE"
echo "================================"
echo "CPU:    $CPU%"
echo "Memory: $MEMORY%"
echo "Disk:   $DISK%"
echo "================================"
# Проверка лимитов
if [ "$CPU" -gt "$CPU_LIMIT" ]; then
    echo "⚠️  ВНИМАНИЕ: CPU превышает лимит! ($CPU%)"
fi

if [ "$MEMORY" -gt "$MEMORY_LIMIT" ]; then
    echo "⚠️  ВНИМАНИЕ: Память превышает лимит! ($MEMORY%)"
fi

if [ "$DISK" -gt "$DISK_LIMIT" ]; then
    echo "⚠️  ВНИМАНИЕ: Диск превышает лимит! ($DISK%)"
fi
# Запись в лог файл
echo "$DATE | CPU: $CPU% | Memory: $MEMORY% | Disk: $DISK%" >> $LOG_FILE

