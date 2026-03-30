$path = 'C:/Users/admin/Desktop/websitefull/tti-nvr.html'
$c = Get-Content $path -Raw

# ── 1. Center the toast: fix position and base/show transforms ────────────────
$c = $c -replace 'position:fixed;bottom:32px;right:32px;', 'position:fixed;top:50%;left:50%;'
$c = $c -replace 'opacity:0;transform:translateY\(16px\);', 'opacity:0;transform:translate(-50%,calc(-50% + 20px));'
$c = $c -replace 'opacity:1;transform:translateY\(0\);', 'opacity:1;transform:translate(-50%,-50%);'
$c = $c -replace 'padding:14px 20px;border-radius:12px;', 'padding:18px 32px;border-radius:14px;'
$c = $c -replace 'box-shadow:0 8px 32px rgba\(0,0,0,\.22\);', 'box-shadow:0 20px 60px rgba(0,0,0,.40);'
$c = $c -replace 'font-size:14px;font-weight:600;', 'font-size:15px;font-weight:600;'
Write-Host "1. Toast CSS centered."

# ── 2. After success: wait 2 s then scroll to top ────────────────────────────
$c = [regex]::Replace($c,
    "(?s)showToast\('sent',\s*'Request sent!'\);.*?2000\)\;",
    "showToast('sent', 'Request sent!');
      setTimeout(function() {
        hideToast(350);
        setTimeout(function() {
          window.scrollTo({ top: 0, behavior: 'smooth' });
        }, 400);
      }, 2000);")
Write-Host "2. Scroll-to-top after 2s added."

Set-Content $path -Value $c -NoNewline

# ── Verify ─────────────────────────────────────────────────────────────────────
$v = Get-Content $path -Raw

Write-Host "`n=== TOAST POSITION CHECK ==="
$m = [regex]::Match($v, 'position:fixed;top:50%[^}]+\}')
Write-Host $m.Value

Write-Host "`n=== SUCCESS HANDLER ==="
$idx = $v.IndexOf("showToast('sent'")
Write-Host $v.Substring($idx, 250)
