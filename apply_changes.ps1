$path = 'C:/Users/admin/Desktop/websitefull/tti-nvr.html'
$c = Get-Content $path -Raw

# ─── 1. QUOTE FORM: wire submitQuote() to mailto:nvr@triton.net ───────────────
$oldSubmit = @'
function submitQuote() {
  const name = document.getElementById('f-name').value.trim();
  const phone = document.getElementById('f-phone').value.trim();
  const email = document.getElementById('f-email').value.trim();
  if (!name || !phone || !email) {
    alert('Please fill in your name, phone, and email to continue.');
    return;
  }
  document.getElementById('quoteFormInner').style.display = 'none';
  document.getElementById('quoteSuccess').style.display = 'block';
}
'@

$newSubmit = @'
function submitQuote() {
  const name = document.getElementById('f-name').value.trim();
  const phone = document.getElementById('f-phone').value.trim();
  const email = document.getElementById('f-email').value.trim();
  if (!name || !phone || !email) {
    alert('Please fill in your name, phone, and email to continue.');
    return;
  }
  // Gather remaining optional fields
  const cameras  = document.getElementById('f-cameras')  ? document.getElementById('f-cameras').value  : '';
  const location = document.getElementById('f-location') ? document.getElementById('f-location').value : '';
  const timeline = document.getElementById('f-timeline') ? document.getElementById('f-timeline').value : '';
  const contactTime = document.getElementById('f-contact-time') ? document.getElementById('f-contact-time').value : '';
  const notes    = document.getElementById('f-notes')    ? document.getElementById('f-notes').value    : '';

  const subject = encodeURIComponent('NVR Quote Request from ' + name);
  const body = encodeURIComponent(
    'Name: ' + name + '\n' +
    'Phone: ' + phone + '\n' +
    'Email: ' + email + '\n' +
    (cameras   ? 'Cameras: '      + cameras      + '\n' : '') +
    (location  ? 'Location: '     + location     + '\n' : '') +
    (timeline  ? 'Timeline: '     + timeline     + '\n' : '') +
    (contactTime ? 'Best time to contact: ' + contactTime + '\n' : '') +
    (notes     ? 'Notes: '        + notes        + '\n' : '')
  );
  window.location.href = 'mailto:nvr@triton.net?subject=' + subject + '&body=' + body;

  document.getElementById('quoteFormInner').style.display = 'none';
  document.getElementById('quoteSuccess').style.display = 'block';
}
'@

$c = $c.Replace($oldSubmit, $newSubmit)
Write-Host "1. submitQuote() updated to mailto:nvr@triton.net"

# ─── 2. DEMO: replace all demo-nvr.triton.net URLs / text ────────────────────
# href links
$c = $c -replace 'http://demo-nvr\.triton\.net', 'https://demo.frigate.video'
# Display text in URL bar
$c = $c -replace '(?<=>)\s*demo-nvr\.triton\.net\s*(?=<)', 'demo.frigate.video'
# Text inside strong tags and spans
$c = $c -replace 'demo-nvr\.triton\.net', 'demo.frigate.video'
Write-Host "2. Demo URLs updated to https://demo.frigate.video"

# ─── 3. McKAY: remove login links, keep as reference text only ───────────────
# Remove the footer nav link for McKay NVR
$c = $c -replace '<a href="http://mckay-nvr\.triton\.net" target="_blank">McKay NVR</a>', 'McKay NVR'

# Remove the clickable card/link for McKay NVR in the sidebar — replace <a ...> with <div>
# The link wraps a card — find it and strip the anchor
$mckayLinkPattern = '(?s)<a href="http://mckay-nvr\.triton\.net"[^>]*>(.*?)</a>'
$mckayMatch = [regex]::Match($c, $mckayLinkPattern)
if ($mckayMatch.Success) {
    # Replace <a ...>inner</a> with <div class="df">inner</div> (non-clickable)
    $inner = $mckayMatch.Groups[1].Value
    # Strip the "Live Site" label to indicate it's reference only
    $inner = $inner -replace 'McKay NVR \xE2\x80\x94 Live Site', 'McKay NVR — Reference Deployment'
    $inner = $inner -replace 'McKay NVR.*?Live Site', 'McKay NVR — Reference Deployment'
    $c = $c.Replace($mckayMatch.Value, "<div style=""display:flex;align-items:center;gap:12px;padding:10px 14px;border-radius:8px;background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);"">$inner</div>")
    Write-Host "3. McKay NVR link removed — kept as reference text."
} else {
    Write-Host "3. McKay NVR anchor not found via regex — trying simple replace."
    $c = $c -replace 'href="http://mckay-nvr\.triton\.net"[^>]*>', 'style="pointer-events:none;cursor:default;">'
    Write-Host "   Applied pointer-events:none to McKay link instead."
}

# Also update the status bar text referencing mckay-nvr (it's OK as display text — no link there)

Set-Content $path -Value $c -NoNewline
Write-Host "`nAll changes written to tti-nvr.html"
