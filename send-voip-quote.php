<?php
/**
 * VoIP Quote Request Mailer
 * Receives JSON POST from tti-voip.html and sends to voip@triton.net
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }
if ($_SERVER['REQUEST_METHOD'] !== 'POST') { http_response_code(405); echo json_encode(['success'=>false,'error'=>'Method not allowed.']); exit; }

$raw  = file_get_contents('php://input');
$data = json_decode($raw, true);
if (!$data) $data = $_POST;

function clean($v){ return htmlspecialchars(strip_tags(trim((string)$v)), ENT_QUOTES, 'UTF-8'); }
function val($v){ $v=trim((string)$v); return $v!==''?$v:'Not provided'; }

$name  = clean($data['name']  ?? '');
$phone = clean($data['phone'] ?? '');
$email = filter_var(trim($data['email'] ?? ''), FILTER_SANITIZE_EMAIL);

if (!$name || !$phone || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(422);
    echo json_encode(['success'=>false,'error'=>'Name, phone, and a valid email are required.']);
    exit;
}

$company     = clean($data['company']     ?? '');
$extensions  = clean($data['extensions']  ?? '');
$mobile      = clean($data['mobile']      ?? '');
$hasSystem   = clean($data['hasSystem']   ?? '');
$current     = clean($data['current']     ?? '');
$timeframe   = clean($data['timeframe']   ?? '');
$contactTime = clean($data['contactTime'] ?? '');
$notes       = clean($data['notes']       ?? '');

$hasSystemLabel = ['yes'=>'Yes — replacing existing system','no'=>'No — new installation'];
$timeframeLabel = ['now'=>'Ready now','1mo'=>'Within 1 month','6mo'=>'Within 6 months','undecided'=>'Still deciding'];

$hasSystemStr = val($hasSystemLabel[$hasSystem] ?? $hasSystem);
$timeframeStr = val($timeframeLabel[$timeframe] ?? $timeframe);

$sep   = str_repeat('-', 52);
$body  = "A new VoIP quote request was submitted via the Triton website.\r\n";
$body .= "{$sep}\r\n";
$body .= "CONTACT INFORMATION\r\n{$sep}\r\n";
$body .= "Name:              " . val($name)    . "\r\n";
$body .= "Company:           " . val($company) . "\r\n";
$body .= "Phone:             " . val($phone)   . "\r\n";
$body .= "Email:             " . val($email)   . "\r\n\r\n";
$body .= "PHONE SYSTEM DETAILS\r\n{$sep}\r\n";
$body .= "Number of extensions:   " . val($extensions)  . "\r\n";
$body .= "Mobile app users:       " . val($mobile)      . "\r\n";
$body .= "Has existing system:    " . $hasSystemStr     . "\r\n";
$body .= "Current provider/system:" . val($current)     . "\r\n\r\n";
$body .= "TIMELINE & CONTACT\r\n{$sep}\r\n";
$body .= "Timeframe:         " . $timeframeStr       . "\r\n";
$body .= "Best time to call: " . val($contactTime)   . "\r\n\r\n";
$body .= "ADDITIONAL NOTES\r\n{$sep}\r\n";
$body .= ($notes !== '' ? $notes : 'None') . "\r\n\r\n";
$body .= "{$sep}\r\n";
$body .= "Submitted: " . date('Y-m-d H:i:s T') . "\r\n";
$body .= "Reply directly to this email to reach the requester.\r\n";

$to      = 'tti-web-request@triton.net';
$subject = "[tti-voip] VoIP Quote Request" . ($company !== '' ? " — {$company}" : " — {$name}");
$headers  = "From: Triton Web Form <noreply@triton.net>\r\n";
$headers .= "Reply-To: {$name} <{$email}>\r\n";
$headers .= "X-Mailer: Triton-Web/1.0\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/plain; charset=UTF-8\r\n";

$sent = mail($to, $subject, $body, $headers);
if ($sent) {
    echo json_encode(['success'=>true]);
} else {
    http_response_code(500);
    echo json_encode(['success'=>false,'error'=>'Mail server error. Please call us directly.']);
}
