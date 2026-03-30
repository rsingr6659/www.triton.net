$path = 'C:/Users/admin/Desktop/websitefull/tti-nvr.html'
$c = Get-Content $path -Raw

$newSubmit = @'
function submitQuote() {
  const name  = document.getElementById('f-name').value.trim();
  const phone = document.getElementById('f-phone').value.trim();
  const email = document.getElementById('f-email').value.trim();

  if (!name || !phone || !email) {
    alert('Please fill in your name, phone, and email to continue.');
    return;
  }

  // Helper to get selected radio value by group name
  function radioVal(name) {
    const sel = document.querySelector('input[name="' + name + '"]:checked');
    return sel ? sel.value : '';
  }
  function fieldVal(id) {
    const el = document.getElementById(id);
    return el ? el.value.trim() : '';
  }

  const btn = document.querySelector('.submit-btn');
  btn.disabled = true;
  btn.textContent = 'Sending\u2026';

  const payload = {
    name:        name,
    company:     fieldVal('f-company'),
    phone:       phone,
    email:       email,
    hasSystem:   radioVal('has-system'),
    cameras:     fieldVal('f-cameras'),
    retention:   fieldVal('f-retention'),
    recMode:     radioVal('rec-mode'),
    currentNvr:  fieldVal('f-current-nvr'),
    timeframe:   radioVal('timeframe'),
    contactTime: fieldVal('f-contact-time'),
    notes:       fieldVal('f-notes')
  };

  fetch('send-quote.php', {
    method:  'POST',
    headers: { 'Content-Type': 'application/json' },
    body:    JSON.stringify(payload)
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) {
      document.getElementById('quoteFormInner').style.display = 'none';
      document.getElementById('quoteSuccess').style.display  = 'block';
    } else {
      alert('There was a problem sending your request: ' + (data.error || 'Unknown error.'));
      btn.disabled    = false;
      btn.textContent = 'Send Quote Request';
    }
  })
  .catch(function() {
    alert('Network error. Please try again or call us directly.');
    btn.disabled    = false;
    btn.textContent = 'Send Quote Request';
  });
}
'@

$c = [regex]::Replace($c, '(?s)function submitQuote\(\)\s*\{.*?\n\}', $newSubmit.Trim())
Set-Content $path -Value $c -NoNewline
Write-Host "submitQuote() updated with all fields."
