$p = Get-Content 'C:/Users/admin/Desktop/websitefull/send-quote.php' -Raw
Write-Host "=== PHP OPTIONAL FIELDS PARSING ==="
$idx = $p.IndexOf('Optional fields')
Write-Host $p.Substring($idx, 600)
