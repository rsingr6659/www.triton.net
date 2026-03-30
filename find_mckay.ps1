$c = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw

# Find all McKay blocks with more context
$matches = [regex]::Matches($c, '(?i).{0,300}mckay.{0,300}')
$i = 1
foreach ($m in $matches) {
    Write-Host "=== MATCH $i ==="
    Write-Host $m.Value
    Write-Host ""
    $i++
}
