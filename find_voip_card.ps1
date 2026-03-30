$c = Get-Content 'C:/Users/admin/Desktop/websitefull/index.html' -Raw
$len = $c.Length

# Work from end of file to find the VoIP card close
$aIdx = $c.IndexOf('<a href="tti-voip.html" class="service-card"')
$remaining = $c.Substring($aIdx, $len - $aIdx)
$clean = $remaining -replace 'data:[^"]{100,}"', '[BASE64]"'

# Find the closing </a>
$closeIdx = $clean.IndexOf('</a>')
Write-Host "Close tag at offset $closeIdx from card start"
Write-Host "=== AROUND CLOSE TAG ==="
$start = [Math]::Max(0, $closeIdx - 150)
$end = [Math]::Min($clean.Length, $closeIdx + 350)
Write-Host $clean.Substring($start, $end - $start)
