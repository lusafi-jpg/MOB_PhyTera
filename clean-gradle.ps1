# Script pour nettoyer complètement les caches Gradle et Kotlin
Write-Host "Nettoyage des caches Gradle et Kotlin..." -ForegroundColor Yellow

# Arrêter tous les processus Java/Gradle
Write-Host "Arrêt des processus Java/Gradle..." -ForegroundColor Yellow
Get-Process | Where-Object {$_.ProcessName -like "*java*" -or $_.ProcessName -like "*gradle*"} | Stop-Process -Force -ErrorAction SilentlyContinue

# Nettoyer le cache Gradle
Write-Host "Suppression du cache Gradle..." -ForegroundColor Yellow
Remove-Item -Path "$env:USERPROFILE\.gradle\caches" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:USERPROFILE\.gradle\daemon" -Recurse -Force -ErrorAction SilentlyContinue

# Nettoyer le cache Kotlin
Write-Host "Suppression du cache Kotlin..." -ForegroundColor Yellow
Remove-Item -Path "$env:USERPROFILE\.kotlin" -Recurse -Force -ErrorAction SilentlyContinue

# Nettoyer les builds locaux
Write-Host "Nettoyage des builds locaux..." -ForegroundColor Yellow
Remove-Item -Path "android\.gradle" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "android\app\build" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Nettoyage terminé! Vous pouvez maintenant relancer l'application." -ForegroundColor Green


