#!/bin/bash
# ============================================
# PRO_BACKUP.SH — Professional Backup System
# Author : Sagar Savita
# GitHub : github.com/sagarsavitahamirpur713-sketch
# About  : Multiple folders backup, logging,
#          space check, auto cleanup old backups
# Usage  : ./pro_backup.sh
# Cron   : 0 23 * * * /home/$USER/backup-project/pro_backup.sh
# ============================================

# ---- CONFIGURATION ----
SOURCE_DIRS=(
    "$HOME/documents"
    "$HOME/my-scripts"
    "$HOME/projects"
)
BACKUP_DIR="$HOME/backups"
LOG_FILE="$HOME/backup-project/logs/backup.log"
KEEP_DAYS=7          # kitne din purana backup rakho
MAX_SIZE_MB=500      # minimum free space chahiye MB mein

# ---- COLORS ----
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ---- FUNCTIONS ----

# Log file mein likhna + screen pe dikhana
write_log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
    echo "  $message"
}

# Disk space check karna
check_space() {
    local available=$(df -m "$BACKUP_DIR" | tail -1 | awk '{print $4}')
    if [ "$available" -lt "$MAX_SIZE_MB" ]; then
        write_log "ERROR: Disk space bahut kam hai! Only ${available}MB free"
        write_log "Minimum ${MAX_SIZE_MB}MB chahiye"
        exit 1
    fi
    write_log "Disk space OK — ${available}MB available"
}

# Purane backups delete karna
cleanup_old() {
    write_log "Purane backups clean kar rahe hain (${KEEP_DAYS} din se purane)..."
    local deleted=$(find "$BACKUP_DIR" \
        -name "backup_*.tar.gz" \
        -mtime +$KEEP_DAYS \
        -delete -print | wc -l)
    write_log "$deleted purane backup(s) delete hue"
}

# ---- MAIN SCRIPT ----

# Folders banao
mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname $LOG_FILE)"

# Header
echo -e "${GREEN}"
echo "=================================="
echo "   AUTOMATED BACKUP SYSTEM"
echo "   $(date '+%Y-%m-%d %H:%M:%S')"
echo "=================================="
echo -e "${NC}"

write_log "=== Backup session shuru ==="

# Space check
check_space

# Sirf existing folders backup karo
VALID_DIRS=()
echo ""
echo "  Source folders:"
for dir in "${SOURCE_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        VALID_DIRS+=("$dir")
        echo -e "  ${GREEN}✓${NC} $dir"
    else
        echo -e "  ${YELLOW}⚠${NC} Skip (nahi mila): $dir"
        write_log "WARNING: Folder nahi mila, skip kiya: $dir"
    fi
done

if [ ${#VALID_DIRS[@]} -eq 0 ]; then
    write_log "ERROR: Koi bhi valid source folder nahi mila!"
    exit 1
fi

# Filename banao
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Backup karo
echo ""
write_log "Backup ban raha hai: backup_$DATE.tar.gz"
tar -czf "$BACKUP_FILE" "${VALID_DIRS[@]}" 2>/dev/null

# Result check
if [ $? -eq 0 ]; then
    SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
    write_log "Backup SUCCESSFUL! Size: $SIZE"
    echo ""
    echo -e "${GREEN}  ✓ Backup complete!${NC}"
    echo    "    File : $(basename $BACKUP_FILE)"
    echo    "    Size : $SIZE"
else
    write_log "Backup FAILED!"
    echo -e "${RED}  ✗ Backup fail hua!${NC}"
    rm -f "$BACKUP_FILE"
    exit 1
fi

# Cleanup purane backups
echo ""
cleanup_old

# Final summary
TOTAL=$(ls "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
echo ""
echo -e "${YELLOW}=================================="
echo "   BACKUP SUMMARY"
echo "=================================="
echo -e "${NC}"
echo "  Backup file  : $BACKUP_FILE"
echo "  File size    : $SIZE"
echo "  Total stored : $TOTAL backup(s)"
echo "  Log file     : $LOG_FILE"
write_log "=== Session khatam. Total backups: $TOTAL ==="
echo ""
