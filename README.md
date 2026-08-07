#this is automated backup script project 
backup-project/
│
├── setup.sh          ← Sabse pehle chalao
├── basic_backup.sh   ← Simple backup script
├── pro_backup.sh     ← Professional backup
├── restore.sh        ← Backup restore karna
├── cron_setup.sh     ← Auto schedule setup
├── .gitignore        ← Git rules
├── README.md         ← Documentation
└── logs/             ← Log files folder

# ðŸ’¾ Linux Automated Backup System

> Production-ready automated backup system for Linux
> Built by Sagar Savita â€” DevOps Engineer (LPU)

![Bash](https://img.shields.io/badge/Shell-Bash-green)
![Linux](https://img.shields.io/badge/OS-Linux-blue)
![Status](https://img.shields.io/badge/Status-Active-brightgreen)

---

## ðŸ“ Project Structure

```
backup-project/
â”‚
â”œâ”€â”€ setup.sh          â† Step 1: Run this first!
â”œâ”€â”€ basic_backup.sh   â† Step 2: Simple backup
â”œâ”€â”€ pro_backup.sh     â† Step 3: Professional backup
â”œâ”€â”€ restore.sh        â† Restore any backup
â”œâ”€â”€ cron_setup.sh     â† Schedule automatic backups
â”‚
â”œâ”€â”€ .gitignore        â† Git rules
â”œâ”€â”€ README.md         â† This file
â””â”€â”€ logs/             â† Auto-generated log files
    â””â”€â”€ backup.log
```

---

## âš¡ Quick Start

```bash
# 1. Clone karo
git clone https://github.com/sagarsavitahamirpur713-sketch/backup-project

# 2. Folder mein jaao
cd backup-project

# 3. Permissions do
chmod +x *.sh

# 4. Setup karo (folders + test files)
./setup.sh

# 5. Basic backup try karo
./basic_backup.sh

# 6. Professional backup chalao
./pro_backup.sh

# 7. Automatic schedule karo
./cron_setup.sh
```

---

## ðŸ“œ Script Details

### setup.sh
- Sab required folders banata hai
- Test files create karta hai ~/documents/ mein
- Script permissions set karta hai

### basic_backup.sh
- ~/documents/ ka simple backup leta hai
- ~/backups/ mein .tar.gz file save karta hai
- Success/fail clearly dikhata hai

### pro_backup.sh
- Multiple folders backup karta hai
- Disk space check karta hai pehle
- Detailed log file maintain karta hai
- 7 din purane backups auto-delete karta hai

### restore.sh
- Available backups ki numbered list dikhata hai
- User kaun sa restore karna hai choose karta hai
- ~/restored/ folder mein files wapas laata hai

### cron_setup.sh
- Automatic scheduling setup karta hai
- Multiple options â€” daily, every 6 hours, weekdays

---

## ðŸ”§ Cron Format

```
* * * * * command
â”‚ â”‚ â”‚ â”‚ â”‚
â”‚ â”‚ â”‚ â”‚ â””â”€â”€ Weekday (0-7, 0=Sunday)
â”‚ â”‚ â”‚ â””â”€â”€â”€â”€ Month   (1-12)
â”‚ â”‚ â””â”€â”€â”€â”€â”€â”€ Day      (1-31)
â”‚ â””â”€â”€â”€â”€â”€â”€â”€â”€ Hour     (0-23)
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ Minute   (0-59)

Examples:
0 23 * * *   = Rozana raat 11 baje
0 */6 * * *  = Har 6 ghante mein
0 23 * * 1-5 = Sirf Mon-Fri 11 baje
```

---

## ðŸ“Š Log Files

```bash
# Backup log dekhna
cat ~/backup-project/logs/backup.log

# Live log watch karna
tail -f ~/backup-project/logs/backup.log

# Sirf errors dekhna
grep "ERROR\|FAIL" ~/backup-project/logs/backup.log
```

---

## ðŸ‘¨â€ðŸ’» Author

**Sagar Savita** â€” 1st Year B.Tech CSE (DevOps)
Lovely Professional University, Punjab

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com/in/sagar-savita-595a79335)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/sagarsavitahamirpur713-sketch)

