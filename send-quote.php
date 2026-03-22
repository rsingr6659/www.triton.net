<?php
/**
 * NVR Quote Request Mailer
 * Receives a JSON POST from tti-nvr.html and sends to nvr@triton.net
 * via the server mail stack on cp-1.triton.net
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle CORS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'Method not allowed.']);
    exit;
}

// Parse JSON body
$raw  = file_get_contents('php://input');
$data = json_decode($raw, true);
if (!$data) {
    $data = $_POST;
}

// ── Sanitise helper ────────────────────────────────────────────────────────────
function clean($val) {
    return htmlspecialchars(strip_tags(trim((string)$val)), ENT_QUOTES, 'UTF-8');
}

// ── Required fields ────────────────────────────────────────────────────────────
$name  = clean($data['name']  ?? '');
$phone = clean($data['phone'] ?? '');
$email = filter_var(trim($data['email'] ?? ''), FILTER_SANITIZE_EMAIL);

if (!$name || !$phone || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(422);
    echo json_encode(['success' => false, 'error' => 'Name, phone, and a valid email are required.']);
    exit;
}

// ── Optional fields ────────────────────────────────────────────────────────────
$company    = clean($data['company']    ?? '');
$hasSystem  = clean($data['hasSystem']  ?? '');
$cameras    = clean($data['cameras']    ?? '');
$retention  = clean($data['retention']  ?? '');
$recMode    = clean($data['recMode']    ?? '');
$currentNvr = clean($data['currentNvr'] ?? '');
$timeframe  = clean($data['timeframe']  ?? '');
$contactTime= clean($data['contactTime']?? '');
$notes      = clean($data['notes']      ?? '');

// ── Human-readable labels for radio values ─────────────────────────────────────
$hasSystemLabel = ['yes' => 'Yes, has existing system', 'no' => 'No, starting fresh'];
$recModeLabel   = ['continuous' => 'Continuous 24/7', 'motion' => 'Motion / AI detection', 'both' => 'Both'];
$timeframeLabel = ['now' => 'Ready now', '1mo' => 'Within 1 month', '6mo' => 'Within 6 months', 'undecided' => 'Still deciding'];

$hasSystemStr = $hasSystemLabel[$hasSystem] ?? $hasSystem;
$recModeStr   = $recModeLabel[$recMode]     ?? $recMode;
$timeframeStr = $timeframeLabel[$timeframe] ?? $timeframe;

// ── Build email body ───────────────────────────────────────────────────────────
$sep   = str_repeat('-', 52);
$body  = "A new NVR quote request was submitted via the Triton website.\r\n";
$body .= "{$sep}\r\n";
$body .= "CONTACT INFORMATION\r\n";
$body .= "{$sep}\r\n";
$body .= "Name:              {$name}\r\n";
if ($company)     $body .= "Company:           {$company}\r\n";
$body .= "Phone:             {$phone}\r\n";
$body .= "Email:             {$email}\r\n";
$body .= "\r\n";
$body .= "CURRENT SETUP\r\n";
$body .= "{$sep}\r\n";
$body .= "Has existing system:    {$hasSystemStr}\r\n";
if ($cameras)     $body .= "Number of cameras:      {$cameras}\r\n";
if ($retention)   $body .= "Retention needed:       {$retention}\r\n";
if ($recMode)     $body .= "Recording mode:         {$recModeStr}\r\n";
if ($currentNvr)  $body .= "Current NVR make/model: {$currentNvr}\r\n";
$body .= "\r\n";
$body .= "TIMELINE & CONTACT\r\n";
$body .= "{$sep}\r\n";
if ($timeframe)   $body .= "Timeframe:         {$timeframeStr}\r\n";
if ($contactTime) $body .= "Best time to call: {$contactTime}\r\n";
if ($notes) {
    $body .= "\r\nADDITIONAL NOTES\r\n";
    $body .= "{$sep}\r\n";
    $body .= "{$notes}\r\n";
}
$body .= "\r\n{$sep}\r\n";
$body .= "Submitted: " . date('Y-m-d H:i:s T') . "\r\n";
$body .= "Reply directly to this email to reach the requester.\r\n";

// ── Headers — Reply-To is the submitter's email ────────────────────────────────
$to      = 'nvr@triton.net';
$subject = "NVR Quote Request" . ($company ? " — {$company}" : " — {$name}");

$headers  = "From: Triton Web Form <noreply@triton.net>\r\n";
$headers .= "Reply-To: {$name} <{$email}>\r\n";
$headers .= "X-Mailer: Triton-Web/1.0\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/plain; charset=UTF-8\r\n";

// ── Send ───────────────────────────────────────────────────────────────────────
$sent = mail($to, $subject, $body, $headers);

if ($sent) {
    echo json_encode(['success' => true, 'message' => 'Quote request sent successfully.']);
} else {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Mail server error. Please call us directly.']);
}
