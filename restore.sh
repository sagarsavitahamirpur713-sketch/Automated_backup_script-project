#!/bin/bash
# ============================================
# RESTORE.SH — Backup Restore Script
# Author : Sagar Savita
# GitHub : github.com/sagarsavitahamirpur713-sketch
# About  : Available backups list dikhata hai
#          User choose karta hai, restore karta hai
# Usage  : ./restore.sh
# ============================================

BACKUP_DIR="$HOME/backups"
RESTORE_DIR="$HOME/restored"
LOG_FILE="$HOME/backup-project/logs/restore.log"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

mkdir -p "$RESTORE_DIR"
mkdir -p "$(dirname $LOG_FILE)"

echo -e "${BLUE}"
echo "=================================="
echo "   BACKUP RESTORE TOOL"
echo "   $(date '+%Y-%m-%d %H:%M:%S')"
echo "=================================="
echo -e "${NC}"

# Check backup folder
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${RED}  ✗ Backup folder nahi mila: $BACKUP_DIR${NC}"
    echo "  Pehle pro_backup.sh chalao!"
    exit 1
fi

# Available backups list
BACKUPS=($(ls -t "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null))

if [ ${#BACKUPS[@]} -eq 0 ]; then
    echo -e "${YELLOW}  ⚠ Koi backup nahi mila $BACKUP_DIR mein${NC}"
    echo "  Pehle basic_backup.sh ya pro_backup.sh chalao!"
    exit 1
fi

# List dikhao
echo "  Available Backups:"
echo "  ──────────────────────────────────────────"
for i in "${!BACKUPS[@]}"; do
    FILE="${BACKUPS[$i]}"
    NAME=$(basename "$FILE")
    SIZE=$(du -sh "$FILE" | cut -f1)
    # Date nicely format karo
    BDATE=$(echo "$NAME" | sed 's/backup_//;s/.tar.gz//' | tr '_' ' ')
    echo "  $((i+1)). $BDATE  [$SIZE]"
done
echo "  ──────────────────────────────────────────"
echo ""

# User se choose karwao
echo -n "  Kaun sa restore karna hai? (number likho): "
read choice

# Validate
if ! [[ "$choice" =~ ^[0-9]+$ ]] || \
   [ "$choice" -lt 1 ] || \
   [ "$choice" -gt "${#BACKUPS[@]}" ]; then
    echo -e "${RED}  ✗ Galat number! Dobara chalao.${NC}"
    exit 1
fi

SELECTED="${BACKUPS[$((choice-1))]}"
SELECTED_NAME=$(basename "$SELECTED")

echo ""
echo "  Selected  : $SELECTED_NAME"
echo "  Restore to: $RESTORE_DIR"
echo ""
echo -n "  Confirm restore? (y/n): "
read confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "  Restore cancel ho gaya."
    exit 0
fi

# Restore karo
echo ""
echo "  Restoring..."
tar -xzf "$SELECTED" -C "$RESTORE_DIR" 2>/dev/null

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}  ✓ Restore successful!${NC}"
    echo    "    Location: $RESTORE_DIR"
    echo ""
    echo    "  Restored files:"
    find "$RESTORE_DIR" -type f | head -20 | awk '{print "    → " $0}'
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] RESTORED: $SELECTED_NAME → $RESTORE_DIR" >> "$LOG_FILE"
else
    echo -e "${RED}  ✗ Restore fail hua!${NC}"
    exit 1
fi
