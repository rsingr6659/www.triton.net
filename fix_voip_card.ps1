$path = 'C:/Users/admin/Desktop/websitefull/index.html'
$c = Get-Content $path -Raw

# 1. Replace the broken <a href="tti-voip.html" class="service-card"...> back to a proper div
#    and add onclick + cursor to make it clickable without nesting issues
$c = $c -replace '<a href="tti-voip\.html" class="service-card" style="text-decoration:none;color:inherit;display:flex;flex-direction:column;">',
                 '<div class="service-card" onclick="window.location=''tti-voip.html''" style="cursor:pointer;">'

# 2. Find the misplaced </a> that closed too late and replace it with </div>
# The </a> that's near the end of the services section (not from tti-nvr/tti-ga cards)
# We need to find it carefully - it should be followed by </div> then </section>
$c = $c -replace '(?s)(</div>\s*</div>\s*)</a>(\s*</div>\s*</section>)',
                 '$1</div>$2'

Set-Content $path -Value $c -NoNewline
Write-Host "Fixed."

# Verify
$v = Get-Content $path -Raw
$idx = $v.IndexOf('onclick="window.location=''tti-voip.html''')
Write-Host "`n=== VoIP card open ==="
Write-Host $v.Substring($idx, 80)

# Check no stray </a> before </section>
if ($v -match '</a>\s*</div>\s*</section>') {
    Write-Host "`nWARNING: stray </a> still present"
} else {
    Write-Host "`nOK: no stray closing anchor found"
}
