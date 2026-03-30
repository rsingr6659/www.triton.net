$c = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw

Write-Host "=== SUBMIT QUOTE FUNCTION ==="
$idx = $c.IndexOf('function submitQuote')
Write-Host $c.Substring($idx, 600)

Write-Host "`n=== MCKAY - any remaining href links? ==="
[regex]::Matches($c, 'href="[^"]*mckay[^"]*"', 'IgnoreCase') | ForEach-Object { Write-Host $_.Value }
