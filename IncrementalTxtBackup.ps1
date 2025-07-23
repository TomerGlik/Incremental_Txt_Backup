# Define source and destination folders
$sourceFolder = "C:\Source\Path"  # Change to your source folder path
$destinationFolder = "C:\Dest\Path"  # Change to your backup folder path
$timestampFile = "C:\Previous Timestamp\Path"  # File to store previous timestamps

# Ensure the destination folder exists
if (!(Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Load previous timestamps if they exist, and convert to hashtable
$previousTimestamps = @{}
if (Test-Path $timestampFile) {
    $jsonData = Get-Content $timestampFile | ConvertFrom-Json
    if ($jsonData -is [PSCustomObject]) {
        $previousTimestamps = @{}
        $jsonData.PSObject.Properties | ForEach-Object { 
            $previousTimestamps[$_.Name] = $_.Value 
        }
    } else {
        $previousTimestamps = $jsonData
    }
}

# Get current timestamps of .txt files in source folder
$currentTimestamps = @{}
Get-ChildItem -Path $sourceFolder -Filter "*.txt" | ForEach-Object {
    $currentTimestamps[$_.Name] = $_.LastWriteTime
}

# Check for modified or new files
$filesToCopy = @()
foreach ($file in $currentTimestamps.Keys) {
    if (-not $previousTimestamps.ContainsKey($file) -or $previousTimestamps[$file] -ne $currentTimestamps[$file]) {
        $filesToCopy += $file
    }
}

# Copy modified files to the destination folder
foreach ($file in $filesToCopy) {
    $sourcePath = Join-Path -Path $sourceFolder -ChildPath $file
    $destinationPath = Join-Path -Path $destinationFolder -ChildPath $file
    
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force
    Write-Output "File copied: $file"
}

# Save the updated timestamps as JSON
$currentTimestamps | ConvertTo-Json -Depth 1 | Set-Content -Path $timestampFile

Write-Output "Script execution completed."