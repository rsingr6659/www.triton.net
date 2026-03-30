$c = Get-Content 'C:/Users/admin/Desktop/websitefull/tti-nvr.html' -Raw

# Get full favicon src
$fav = [regex]::Match($c, '<link rel="icon"[^>]*href="([^"]+)"')
$favSrc = $fav.Groups[1].Value

# Get full footer logo src
$footLogo = [regex]::Match($c, '<div class="foot-logo"><img src="([^"]+)"')
$footLogoSrc = $footLogo.Groups[1].Value

# Get full nav logo src (from <a class="nav-logo"...)
$navLogo = [regex]::Match($c, '(?s)<a class="nav-logo"[^>]*>.*?<img src="([^"]+)"')
$navLogoSrc = $navLogo.Groups[1].Value
if ($navLogoSrc.Length -eq 0) { $navLogoSrc = $footLogoSrc }

# Write to temp files so the page builder can read them
Set-Content 'C:/Users/admin/Desktop/websitefull/tmp_favicon.txt'  $favSrc
Set-Content 'C:/Users/admin/Desktop/websitefull/tmp_navlogo.txt'  $navLogoSrc
Set-Content 'C:/Users/admin/Desktop/websitefull/tmp_footlogo.txt' $footLogoSrc

Write-Host "favicon length:   $($favSrc.Length)"
Write-Host "navlogo length:   $($navLogoSrc.Length)"
Write-Host "footlogo length:  $($footLogoSrc.Length)"
