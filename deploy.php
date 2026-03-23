<?php
/**
 * GitHub Webhook Auto-Deploy
 * Place this file at: /home-550/tripop/public_html/gitsite/deploy.php
 * GitHub will POST to: https://www.triton.net/gitsite/deploy.php
 */

// ── Secret token — must match what you set in GitHub webhook settings ──────────
define('WEBHOOK_SECRET', 'TritonDeploy2024!');

// ── Paths ──────────────────────────────────────────────────────────────────────
define('REPO_PATH',   '/home-550/tripop/repositories/triton-web');
define('DEPLOY_PATH', '/home-550/tripop/public_html/gitsite');

// ── Files to deploy ────────────────────────────────────────────────────────────
define('DEPLOY_FILES', [
    'index.html',
    'about.html',
    'paybill.html',
    'policy.html',
    'tti-ga.html',
    'tti-nvr.html',
    'send-quote.php',
]);

// ── Only accept POST ───────────────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed.');
}

// ── Verify GitHub signature ────────────────────────────────────────────────────
$payload   = file_get_contents('php://input');
$sigHeader = $_SERVER['HTTP_X_HUB_SIGNATURE_256'] ?? '';
$expected  = 'sha256=' . hash_hmac('sha256', $payload, WEBHOOK_SECRET);

if (!hash_equals($expected, $sigHeader)) {
    http_response_code(403);
    exit('Signature mismatch.');
}

// ── Only act on push events ────────────────────────────────────────────────────
$event = $_SERVER['HTTP_X_GITHUB_EVENT'] ?? '';
if ($event !== 'push') {
    http_response_code(200);
    exit('Event ignored: ' . $event);
}

// ── Run git pull ───────────────────────────────────────────────────────────────
$home = '/home-550/tripop';
$cmd  = "HOME={$home} git -C " . escapeshellarg(REPO_PATH) . " pull 2>&1";
$output = shell_exec($cmd);

// ── Copy files to public_html ──────────────────────────────────────────────────
$copied = [];
$failed = [];

foreach (DEPLOY_FILES as $file) {
    $src = REPO_PATH  . '/' . $file;
    $dst = DEPLOY_PATH . '/' . $file;
    if (file_exists($src)) {
        if (copy($src, $dst)) {
            $copied[] = $file;
        } else {
            $failed[] = $file . ' (copy failed)';
        }
    } else {
        $failed[] = $file . ' (not found in repo)';
    }
}

// ── Log result ─────────────────────────────────────────────────────────────────
$log  = date('Y-m-d H:i:s T') . "\n";
$log .= "Git pull output:\n" . $output . "\n";
$log .= "Copied:  " . implode(', ', $copied) . "\n";
if ($failed) {
    $log .= "Failed:  " . implode(', ', $failed) . "\n";
}
$log .= str_repeat('-', 60) . "\n";
file_put_contents($home . '/deploy.log', $log, FILE_APPEND);

// ── Respond to GitHub ──────────────────────────────────────────────────────────
http_response_code(200);
header('Content-Type: application/json');
echo json_encode([
    'success' => empty($failed),
    'pulled'  => trim($output),
    'copied'  => $copied,
    'failed'  => $failed,
]);
