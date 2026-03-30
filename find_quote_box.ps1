$c = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw
$m = [regex]::Match($c, '(?s)\.fld input[^}]+\}')
Write-Host "=== INPUT RULE ==="
Write-Host $m.Value
