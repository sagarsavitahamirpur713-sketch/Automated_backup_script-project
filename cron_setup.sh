#!/bin/bash
# ============================================
# CRON_SETUP.SH — Cron Job Setup Script
# Author : Sagar Savita
# About  : Automatically add cron jobs for
#          scheduled backups
# Usage  : ./cron_setup.sh
# ============================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_PATH="$HOME/backup-project/pro_backup.sh"
LOG_PATH="$HOME/backup-project/logs/cron.log"

echo -e "${BLUE}"
echo "=================================="
echo "   CRON JOB SETUP"
echo "=================================="
echo -e "${NC}"

echo "  Kaunsa schedule chahiye?"
echo ""
echo "  1. Rozana raat 11 baje"
echo "  2. Har 6 ghante mein"
echo "  3. Sirf weekdays (Mon-Fri) raat 11 baje"
echo "  4. Dono — Daily + Every 6 hours"
echo "  5. Existing cron jobs dekhna"
echo "  6. Sab backup cron jobs hatana"
echo ""
echo -n "  Choice (1-6): "
read choice

# Script exist check
if [ ! -f "$SCRIPT_PATH" ]; then
    echo -e "${YELLOW}  ⚠ pro_backup.sh nahi mila: $SCRIPT_PATH${NC}"
    echo "  Path update karo cron_setup.sh mein"
fi

case $choice in
    1)
        CRON="0 23 * * * $SCRIPT_PATH >> $LOG_PATH 2>&1"
        (crontab -l 2>/dev/null; echo "$CRON") | crontab -
        echo -e "${GREEN}  ✓ Daily backup set — Rozana 11 PM pe${NC}"
        ;;
    2)
        CRON="0 */6 * * * $SCRIPT_PATH >> $LOG_PATH 2>&1"
        (crontab -l 2>/dev/null; echo "$CRON") | crontab -
        echo -e "${GREEN}  ✓ Set — Har 6 ghante mein backup hoga${NC}"
        ;;
    3)
        CRON="0 23 * * 1-5 $SCRIPT_PATH >> $LOG_PATH 2>&1"
        (crontab -l 2>/dev/null; echo "$CRON") | crontab -
        echo -e "${GREEN}  ✓ Set — Mon-Fri raat 11 baje backup${NC}"
        ;;
    4)
        CRON1="0 23 * * * $SCRIPT_PATH >> $LOG_PATH 2>&1"
        CRON2="0 */6 * * * $SCRIPT_PATH >> $LOG_PATH 2>&1"
        (crontab -l 2>/dev/null; echo "$CRON1"; echo "$CRON2") | crontab -
        echo -e "${GREEN}  ✓ Dono set ho gaye!${NC}"
        ;;
    5)
        echo ""
        echo "  Current cron jobs:"
        echo "  ──────────────────────────────"
        crontab -l 2>/dev/null || echo "  Koi cron job nahi hai"
        ;;
    6)
        crontab -l 2>/dev/null | grep -v "pro_backup.sh" | crontab -
        echo -e "${GREEN}  ✓ Backup cron jobs remove ho gaye${NC}"
        ;;
    *)
        echo "  Galat choice!"
        exit 1
        ;;
esac

echo ""
echo "  Current cron jobs:"
echo "  ──────────────────────────────"
crontab -l 2>/dev/null | grep "backup" || echo "  Koi backup cron nahi"
echo ""

# Cron format explanation
echo -e "${YELLOW}  Cron Format yaad rakho:${NC}"
echo "  ┌──────── minute  (0-59)"
echo "  │ ┌────── hour    (0-23)"
echo "  │ │ ┌──── day     (1-31)"
echo "  │ │ │ ┌── month   (1-12)"
echo "  │ │ │ │ ┌ weekday (0-7)"
echo "  │ │ │ │ │"
echo "  * * * * * command"
echo ""
echo "  Examples:"
echo "  0 23 * * *   = Rozana raat 11 baje"
echo "  0 */6 * * *  = Har 6 ghante mein"
echo "  0 9 * * 1    = Har Monday subah 9 baje"
