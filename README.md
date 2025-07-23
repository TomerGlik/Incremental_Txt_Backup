# IncrementalTxtBackup.ps1 📝

A PowerShell script to back up `.txt` files from a source folder to a destination folder — but only if they are new or modified since the last run.  
Efficient, simple, and logs file timestamps to avoid unnecessary copies.

---

## 📋 Features
✅ Copies only `.txt` files that are new or modified  
✅ Saves last known timestamps to a JSON file  
✅ Creates destination folder if it doesn’t exist  
✅ Outputs a clear list of copied files  
✅ Lightweight & idempotent — run as often as you like

---

## 🚀 How It Works
- On the first run, all `.txt` files from the source folder are copied to the destination.
- Timestamps of each file are saved in a JSON file (`Last_timestamps.json`).
- On subsequent runs, only files that have changed since the last run are copied.

---

## 🧰 Usage

### 1️⃣ Configure paths
Edit the variables at the top of the script:
```powershell
$sourceFolder = "C:\Source\Path"
$destinationFolder = "C:\Dest\Path"
$timestampFile = "C:\Previous Timestamp\Path"
```

### 2️⃣ Run the script

Open PowerShell and execute
.\IncrementalTxtBackup.ps1

### 📁 Output
Copies .txt files into the destination folder.

Creates/updates a file Last_timestamps.json to track file modification times.

Prints a list of copied files to the console.

### 📄 Example Output

File copied: report1.txt
File copied: notes.txt
Script execution completed.

### 🔧 Possible Enhancements
Add support for more file types.

Allow passing source & destination as command-line arguments.

Save timestamps in ISO8601 for readability.

Add optional log file output.

### 📜 Notes
Only .txt files in the source folder are checked.

Deleted files in the source are not removed from the destination — it only backs up.

Timestamps are saved in PowerShell DateTime format in the JSON file.
