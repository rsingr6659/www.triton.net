$path = 'C:/Users/admin/Desktop/websitefull/tti-nvr.html'
$c = Get-Content $path -Raw

# Add width:100% and box-sizing to the existing combined input/select/textarea rule
$c = $c -replace '(\.fld input,\.fld select,\.fld textarea\{)',
                 '$1width:100%;box-sizing:border-box;'

Set-Content $path -Value $c -NoNewline

# Verify
$v = Get-Content $path -Raw
$m = [regex]::Match($v, '\.fld input,[^}]+\}')
Write-Host "=== UPDATED INPUT RULE ==="
Write-Host $m.Value
