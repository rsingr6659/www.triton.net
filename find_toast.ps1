$c = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw

Write-Host "=== FULL TOAST CSS ==="
$m = [regex]::Match($c, '(?s)#quote-toast\{.{0,800}?\}')
Write-Host $m.Value

Write-Host "`n=== showToast / hideToast FUNCTIONS ==="
$m2 = [regex]::Match($c, '(?s)function showToast.{0,600}')
Write-Host $m2.Value
