<?php
/**
 * VoIP Quote Request Mailer — Triton Technologies, Inc.
 * Sends a professional HTML + plain-text email to tti-web-request@triton.net
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'Method not allowed.']);
    exit;
}

$raw  = file_get_contents('php://input');
$data = json_decode($raw, true);
if (!$data) $data = $_POST;

function clean($v) { return htmlspecialchars(strip_tags(trim((string)$v)), ENT_QUOTES, 'UTF-8'); }
function val($v)   { $v = trim((string)$v); return $v !== '' ? $v : 'Not provided'; }

// ── Required ───────────────────────────────────────────────────────────────────
$name  = clean($data['name']  ?? '');
$phone = clean($data['phone'] ?? '');
$email = filter_var(trim($data['email'] ?? ''), FILTER_SANITIZE_EMAIL);

if (!$name || !$phone || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'error' => 'Name, phone, and a valid email are required.']);
    exit;
}

// ── Optional ───────────────────────────────────────────────────────────────────
$company     = clean($data['company']     ?? '');
$extensions  = clean($data['extensions']  ?? '');
$mobile      = clean($data['mobile']      ?? '');
$hasSystem   = clean($data['hasSystem']   ?? '');
$current     = clean($data['current']     ?? '');
$timeframe   = clean($data['timeframe']   ?? '');
$contactTime = clean($data['contactTime'] ?? '');
$notes       = clean($data['notes']       ?? '');

$hasSystemStr = val(['yes'=>'Yes — replacing existing system','no'=>'No — new installation'][$hasSystem] ?? $hasSystem);
$timeframeStr = val(['now'=>'Ready now','1mo'=>'Within 1 month','6mo'=>'Within 6 months','undecided'=>'Still deciding'][$timeframe] ?? $timeframe);

date_default_timezone_set('America/New_York');
$submitted = date('l, F j, Y \a\t g:i A T');

// ── Plain-text fallback ────────────────────────────────────────────────────────
$sep   = str_repeat('-', 52);
$plain = "Triton Technologies, Inc. — VoIP Quote Request\r\n";
$plain .= "Source: tti-voip\r\n{$sep}\r\n\r\n";
$plain .= "CONTACT INFORMATION\r\n{$sep}\r\n";
$plain .= "Name:                   " . val($name)        . "\r\n";
$plain .= "Company:                " . val($company)     . "\r\n";
$plain .= "Phone:                  " . val($phone)       . "\r\n";
$plain .= "Email:                  " . val($email)       . "\r\n\r\n";
$plain .= "PHONE SYSTEM DETAILS\r\n{$sep}\r\n";
$plain .= "Number of extensions:   " . val($extensions)  . "\r\n";
$plain .= "Mobile app users:       " . val($mobile)      . "\r\n";
$plain .= "Has existing system:    " . $hasSystemStr     . "\r\n";
$plain .= "Current provider/system:" . val($current)     . "\r\n\r\n";
$plain .= "TIMELINE & CONTACT\r\n{$sep}\r\n";
$plain .= "Timeframe:              " . $timeframeStr     . "\r\n";
$plain .= "Best time to call:      " . val($contactTime) . "\r\n\r\n";
$plain .= "ADDITIONAL NOTES\r\n{$sep}\r\n";
$plain .= ($notes !== '' ? $notes : 'None') . "\r\n\r\n";
$plain .= "{$sep}\r\n";
$plain .= "Submitted: {$submitted}\r\n";
$plain .= "Reply to this email to reach the requester directly.\r\n";
$plain .= "Triton Technologies, Inc. | triton.net | 616 980 9800\r\n";

// ── HTML email ─────────────────────────────────────────────────────────────────
function row($label, $value) {
    return "
      <tr>
        <td style=\"padding:8px 12px;border-top:1px solid #e8e8e8;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:13px;color:#555;white-space:nowrap;width:40%;\">{$label}</td>
        <td style=\"padding:8px 12px;border-top:1px solid #e8e8e8;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:13px;color:#222;font-weight:600;\">{$value}</td>
      </tr>";
}

function section($title, $rows) {
    return "
    <tr><td colspan=\"2\" style=\"padding:0;\">
      <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"
             style=\"background:#fff;border:1px solid #e0e0e0;border-radius:4px;border-left:4px solid #003848;margin-bottom:16px;\">
        <tr>
          <td colspan=\"2\" style=\"padding:10px 12px;background:#003848;border-radius:0;\">
            <span style=\"font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:12px;font-weight:700;color:#F0B414;letter-spacing:1px;text-transform:uppercase;\">{$title}</span>
          </td>
        </tr>
        {$rows}
      </table>
    </td></tr>";
}

$html = '<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"></head>
<body style="margin:0;padding:0;background:#F4F4F4;">
<div style="margin:0;padding:24px 0;background:#F4F4F4;">
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="max-width:100%;">
    <tr><td align="center">
      <table cellpadding="0" cellspacing="0" border="0" width="620"
             style="max-width:620px;width:100%;background:#fff;border:1px solid #ddd;border-radius:6px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.08);">

        <!-- HEADER -->
        <tr>
          <td style="background:#003848;padding:24px 28px;">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td>
                  <div style="font-family:\'Helvetica Neue\',Helvetica,Arial,sans-serif;font-size:20px;font-weight:800;color:#F0B414;letter-spacing:-0.5px;">TRITON TECHNOLOGIES</div>
                  <div style="font-family:\'Helvetica Neue\',Helvetica,Arial,sans-serif;font-size:10px;font-weight:500;color:rgba(255,255,255,.6);letter-spacing:2px;text-transform:uppercase;margin-top:2px;">triton.net</div>
                </td>
                <td align="right">
                  <div style="font-family:\'Helvetica Neue\',Helvetica,Arial,sans-serif;font-size:11px;color:rgba(255,255,255,.5);text-align:right;">Web Request</div>
                  <div style="font-family:\'Helvetica Neue\',Helvetica,Arial,sans-serif;font-size:13px;font-weight:700;color:#fff;text-align:right;">VoIP Quote Request</div>
                  <div style="display:inline-block;margin-top:6px;padding:3px 10px;background:#F0B414;border-radius:12px;font-family:\'Helvetica Neue\',Helvetica,Arial,sans-serif;font-size:10px;font-weight:700;color:#003848;letter-spacing:1px;">tti-voip</div>
                </td>
              </tr>
            </table>
          </td>
        </tr>


        <!-- SECTIONS -->
        <tr><td style="padding:8px 28px 4px;">
          <table width="100%" cellpadding="0" cellspacing="0" border="0">' .
            section('Contact Information',
                row('Name',    val($name))    .
                row('Company', val($company)) .
                row('Phone',   val($phone))   .
                row('Email',   val($email))
            ) .
            section('Phone System Details',
                row('Number of extensions',    val($extensions)) .
                row('Mobile app users',        val($mobile))     .
                row('Has existing system',     $hasSystemStr)    .
                row('Current provider/system', val($current))
            ) .
            section('Timeline &amp; Contact',
                row('Timeframe',         $timeframeStr)     .
                row('Best time to call', val($contactTime))
            ) .
            section('Additional Notes',
                row('Notes', ($notes !== '' ? nl2br($notes) : 'None'))
            ) . '
        </table>
        </td></tr>

        <!-- FOOTER -->
        <tr>
          <td style="padding:16px 28px;background:#003848;border-top:3px solid #F0B414;">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-family:\'Helvetica Neue\',Helvetica,Arial,sans-serif;font-size:11px;color:rgba(255,255,255,.5);">
                  Submitted: ' . $submitted . '<br>
                  Triton Technologies, Inc. &nbsp;|&nbsp; triton.net &nbsp;|&nbsp; 616 980 9800
                </td>
                <td align="right" style="font-family:\'Helvetica Neue\',Helvetica,Arial,sans-serif;font-size:10px;color:rgba(255,255,255,.3);">
                  Source: tti-voip
                </td>
              </tr>
            </table>
          </td>
        </tr>

      </table>
    </td></tr>
  </table>
</div>
</body>
</html>';

// ── Multipart headers ──────────────────────────────────────────────────────────
$to       = 'tti-web-request@triton.net';
$subject  = "[tti-voip] VoIP Quote Request" . ($company !== '' ? " \xe2\x80\x94 {$company}" : " \xe2\x80\x94 {$name}");
$boundary = 'TTI-' . md5(uniqid());

$headers  = "From: Triton Web Form <noreply@triton.net>\r\n";
$headers .= "Reply-To: {$name} <{$email}>\r\n";
$headers .= "X-Mailer: Triton-Web/2.0\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: multipart/alternative; boundary=\"{$boundary}\"\r\n";

$message  = "--{$boundary}\r\n";
$message .= "Content-Type: text/plain; charset=UTF-8\r\n";
$message .= "Content-Transfer-Encoding: 8bit\r\n\r\n";
$message .= $plain . "\r\n";
$message .= "--{$boundary}\r\n";
$message .= "Content-Type: text/html; charset=UTF-8\r\n";
$message .= "Content-Transfer-Encoding: 8bit\r\n\r\n";
$message .= $html . "\r\n";
$message .= "--{$boundary}--";

// ── Send ───────────────────────────────────────────────────────────────────────
$sent = mail($to, $subject, $message, $headers);

if ($sent) {
    echo json_encode(['success' => true]);
} else {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Mail server error. Please call us directly.']);
}
