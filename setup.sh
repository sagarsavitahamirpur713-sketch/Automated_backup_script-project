#!/bin/bash
# ============================================
# SETUP SCRIPT — Run this first!
# Author: Sagar Savita
# About : Creates all required folders and
#         test files for the backup project
# Usage : ./setup.sh
# ============================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "=================================="
echo "   BACKUP PROJECT SETUP"
echo "=================================="
echo -e "${NC}"

# Step 1 — Create required folders
echo "Step 1: Folders bana rahe hain..."
mkdir -p ~/backup-project
mkdir -p ~/backups
mkdir -p ~/documents
mkdir -p ~/projects
mkdir -p ~/my-scripts
mkdir -p ~/restored
echo -e "  ${GREEN}✓ Folders created${NC}"

# Step 2 — Create test files in documents
echo ""
echo "Step 2: Test files bana rahe hain..."
echo "Mera important document — college assignment" > ~/documents/file1.txt
echo "Project notes — DevOps learning"             > ~/documents/file2.txt
echo "College work — LPU semester 2"               > ~/documents/file3.txt
echo "Sagar Savita — Linux automation notes"       > ~/documents/notes.txt
echo -e "  ${GREEN}✓ Test files created in ~/documents/${NC}"

# Step 3 — Give execute permissions
echo ""
echo "Step 3: Script permissions de rahe hain..."
chmod +x ~/backup-project/*.sh 2>/dev/null
echo -e "  ${GREEN}✓ Permissions set${NC}"

# Step 4 — Show structure
echo ""
echo "Step 4: Project structure:"
echo ""
echo "  ~/backup-project/"
echo "  ├── setup.sh          ← Yeh script"
echo "  ├── basic_backup.sh   ← Simple backup"
echo "  ├── pro_backup.sh     ← Professional backup"
echo "  ├── restore.sh        ← Restore backup"
echo "  ├── .gitignore        ← Git ignore rules"
echo "  ├── README.md         ← Project info"
echo "  └── logs/             ← Log files"
echo ""
echo "  ~/documents/          ← Jo backup hoga"
echo "  ~/backups/            ← Backup files yahan aayengi"
echo "  ~/restored/           ← Restore yahan hoga"
echo ""
echo -e "${GREEN}=================================="
echo "   SETUP COMPLETE!"
echo "   Ab chalao: ./basic_backup.sh"
echo -e "==================================${NC}"
