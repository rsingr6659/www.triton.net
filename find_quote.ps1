$content = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw

# Find quote/email references
$quoteMatches = [regex]::Matches($content, '.{0,60}(quote|mailto|email|contact).{0,80}', 'IgnoreCase')
Write-Host "=== QUOTE/EMAIL REFERENCES ==="
foreach ($m in $quoteMatches) { Write-Host $m.Value; Write-Host "---" }
