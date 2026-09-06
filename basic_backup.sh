#!/bin/bash
# ============================================
# BASIC_BACKUP.SH — Simple Backup Script
# Author : Sagar Savita
# GitHub : github.com/sagarsavitahamirpur713-sketch
# About  : Documents folder ka simple backup
# Usage  : ./basic_backup.sh
# ============================================
#backup like checking storage and ram uses by the system
#system backup script is available

# Variables define karo
SOURCE="$HOME/documents"          # kya backup karna hai
DEST="$HOME/backups"              # kahan save karna hai
DATE=$(date +%Y-%m-%d_%H-%M)      # aaj ki date aur time
FILENAME="backup_$DATE.tar.gz"    # file ka naam

echo "=================================="
echo "   BASIC BACKUP SCRIPT"
echo "   $(date '+%Y-%m-%d %H:%M:%S')"
echo "=================================="
echo ""

# Check karo source exist karta hai
if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Source folder nahi mila: $SOURCE"
    echo "Pehle setup.sh chalao!"
    exit 1
fi

# Destination folder banao
mkdir -p "$DEST"

# Backup shuru karo
echo "Source : $SOURCE"
echo "Dest   : $DEST/$FILENAME"
echo ""
echo "Backup shuru ho raha hai..."
tar -czf "$DEST/$FILENAME" "$SOURCE"

# Success check
if [ $? -eq 0 ]; then
    SIZE=$(du -sh "$DEST/$FILENAME" | cut -f1)
    echo ""
    echo "✓ Backup successful!"
    echo "  File : $FILENAME"
    echo "  Size : $SIZE"
    echo "  Path : $DEST/$FILENAME"
else
    echo ""
    echo "✗ ERROR: Backup fail hua!"
    exit 1
fi

echo ""
echo "Total backups: $(ls $DEST/*.tar.gz 2>/dev/null | wc -l)"
echo "=================================="
