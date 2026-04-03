<?php
/**
 * Frigate Clean View — Dynamic UserCSS Generator
 * Triton Technologies, Inc.
 *
 * Called via .htaccess when Stylus requests frigate-clean-view.user.css
 * Accepts ?nvr=http://192.168.1.100:5000 to target a specific Frigate instance.
 */

header('Content-Type: text/css; charset=UTF-8');
header('Cache-Control: no-store');

$nvr = isset($_GET['nvr']) ? trim($_GET['nvr']) : '';

// Validate it looks like a URL; fall back to match-all if invalid
if (!empty($nvr) && !filter_var($nvr, FILTER_VALIDATE_URL)) {
    $nvr = '';
}

$nvr_safe   = htmlspecialchars($nvr, ENT_QUOTES, 'UTF-8');
$update_url = 'https://www.triton.net/www/frigate-style-handler.php'
            . (!empty($nvr) ? '?nvr=' . urlencode($nvr) : '');

$document = !empty($nvr)
    ? '@-moz-document url-prefix("' . $nvr_safe . '") {'
    : '@-moz-document regexp(".*") {';

echo "/* ==UserStyle==
@name        Triton Frigate Clean View
@namespace   triton.net
@version     1.1.0
@updateURL   {$update_url}
@description Removes the Frigate timeline/filmstrip for a cleaner live view.
@author      Triton Technologies, Inc.
==/UserStyle== */

{$document}

  /* Hide Frigate Timeline/Filmstrip */
  div[class*=\"flex items-center gap-2 px-1\"] {
    display: none !important;
  }

}
";
