# Remove the stale placeholder comment
$nvrContent = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw
$nvrContent = $nvrContent -replace '\s*<!-- Triton wordmark.*?-->\s*', "`n      "
Set-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Value $nvrContent -NoNewline
Write-Host "Cleaned up placeholder comment."
