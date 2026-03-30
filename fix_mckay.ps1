$path = 'C:/Users/admin/Desktop/websitefull/tti-nvr.html'
$c = Get-Content $path -Raw

# 1. Status bar dot + mckay-nvr.triton.net span — remove entirely
$c = $c -replace '<div class="nvr-bar-status"><div class="nvr-bar-dot"></div><span>mckay-nvr\.triton\.net</span></div>', ''

# 2. "Live Site" info card — replace full block with clean customer name only
$c = [regex]::Replace($c,
    '(?s)<div class="df"><h4>[^<]*Live Site[^<]*</h4><p>.*?mckay-nvr\.triton\.net.*?</p></div>',
    '<div class="df"><h4>Reference Customer</h4><p>McKay On Monroe, LLC</p></div>')

# 3. Reference deployment card div — strip URL, update label
$c = $c -replace '(?s)<div style="flex:1;"><div style="font-size:13px;font-weight:600;color:var\(--navy-dk\);">McKay NVR[^<]*</div><div style="font-size:11px;color:var\(--muted\);">mckay-nvr\.triton\.net</div></div>',
    '<div style="flex:1;"><div style="font-size:13px;font-weight:600;color:var(--navy-dk);">McKay On Monroe, LLC</div><div style="font-size:11px;color:var(--muted);">Reference Customer</div></div>'

# 4. Footer nav plain text "McKay NVR" — remove entirely
$c = $c -replace '\s*McKay NVR\s*\n', "`n"

Set-Content $path -Value $c -NoNewline
Write-Host "Done. Verifying remaining McKay references..."

$c2 = Get-Content $path -Raw
$remaining = [regex]::Matches($c2, '(?i).{0,80}mckay.{0,80}')
if ($remaining.Count -eq 0) {
    Write-Host "No mckay references remaining."
} else {
    foreach ($m in $remaining) { Write-Host $m.Value; Write-Host "---" }
}
