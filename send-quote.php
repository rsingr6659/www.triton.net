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
    // Fall back to form-encoded POST
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
$cameras     = clean($data['cameras']      ?? '');
$location    = clean($data['location']     ?? '');
$timeline    = clean($data['timeline']     ?? '');
$contactTime = clean($data['contactTime']  ?? '');
$notes       = clean($data['notes']        ?? '');

// ── Build email ────────────────────────────────────────────────────────────────
$to      = 'nvr@triton.net';
$subject = "NVR Quote Request from {$name}";

$body  = "A new NVR quote request was submitted via the Triton website.\r\n";
$body .= str_repeat('-', 52) . "\r\n";
$body .= "Name:              {$name}\r\n";
$body .= "Phone:             {$phone}\r\n";
$body .= "Email:             {$email}\r\n";
if ($cameras)     $body .= "Cameras:           {$cameras}\r\n";
if ($location)    $body .= "Location:          {$location}\r\n";
if ($timeline)    $body .= "Timeline:          {$timeline}\r\n";
if ($contactTime) $body .= "Best time to call: {$contactTime}\r\n";
if ($notes) {
    $body .= str_repeat('-', 52) . "\r\n";
    $body .= "Notes:\r\n{$notes}\r\n";
}
$body .= str_repeat('-', 52) . "\r\n";
$body .= "Submitted: " . date('Y-m-d H:i:s T') . "\r\n";

$headers  = "From: noreply@triton.net\r\n";
$headers .= "Reply-To: {$email}\r\n";
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
