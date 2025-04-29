# Read the pubspec.yaml file
$content = Get-Content -Path "pubspec.yaml" -Raw

# Replace the version number
$updatedContent = $content -replace 'version: 1.0.2\+2', 'version: 1.0.3+3'

# Write the updated content back to the file
$updatedContent | Set-Content -Path "pubspec.yaml" -NoNewline

