$content = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw
$idx = $content.IndexOf('function submitQuote')
Write-Host $content.Substring($idx, 800)
