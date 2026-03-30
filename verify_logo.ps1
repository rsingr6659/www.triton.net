$content = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw
# Find the actual HTML nav element
$idx = $content.IndexOf('<nav>')
Write-Host $content.Substring($idx, 500)
