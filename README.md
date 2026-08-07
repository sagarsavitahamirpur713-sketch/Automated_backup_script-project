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

# Step 1 — Extract karo
unzip backup-project.zip
cd backup-project

# Step 2 — Permissions do
chmod +x *.sh

# Step 3 — Setup karo pehle
./setup.sh

# Step 4 — Basic try karo
./basic_backup.sh

# Step 5 — Professional chalao
./pro_backup.sh

# Step 6 — Restore try karo
./restore.sh

# Step 7 — Auto schedule karo
./cron_setup.sh

# Step 8 — GitHub pe daalo
git init
git add .
git commit -m "Add automated backup system"
git push origin main
