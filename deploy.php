<?php
/**
 * GitHub Webhook Receiver
 * Verifies the signature and drops a trigger file.
 * A cron job (deploy.sh) does the actual git pull + copy every minute.
 */

define('WEBHOOK_SECRET', 'TritonDeploy2024!');
define('TRIGGER_FILE',   '/home-550/tripop/deploy.trigger');

// Only accept POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed.');
}

// Verify GitHub signature
$payload   = file_get_contents('php://input');
$sigHeader = $_SERVER['HTTP_X_HUB_SIGNATURE_256'] ?? '';
$expected  = 'sha256=' . hash_hmac('sha256', $payload, WEBHOOK_SECRET);

if (!hash_equals($expected, $sigHeader)) {
    http_response_code(403);
    exit('Signature mismatch.');
}

// Only act on push events
$event = $_SERVER['HTTP_X_GITHUB_EVENT'] ?? '';
if ($event !== 'push') {
    http_response_code(200);
    exit('Event ignored: ' . $event);
}

// Drop a trigger file — cron picks this up within 1 minute
file_put_contents(TRIGGER_FILE, date('Y-m-d H:i:s T') . "\n");

http_response_code(200);
header('Content-Type: application/json');
echo json_encode(['success' => true, 'message' => 'Deploy queued.']);
