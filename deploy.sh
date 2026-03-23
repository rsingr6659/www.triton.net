#!/bin/bash
# Auto-deploy script — run by cron every minute
# Checks for a trigger file dropped by deploy.php (GitHub webhook)

TRIGGER_FILE="/home-550/tripop/deploy.trigger"
REPO_PATH="/home-550/tripop/repositories/triton-web"
DEPLOY_PATH="/home-550/tripop/public_html/gitsite"
LOG_FILE="/home-550/tripop/deploy.log"
HOME="/home-550/tripop"

# Only run if triggered
if [ ! -f "$TRIGGER_FILE" ]; then
    exit 0
fi

# Remove trigger immediately to prevent double-runs
rm -f "$TRIGGER_FILE"

echo "========================================" >> "$LOG_FILE"
echo "Deploy started: $(date)" >> "$LOG_FILE"

# Pull latest from GitHub
cd "$REPO_PATH"
GIT_OUTPUT=$(HOME="$HOME" git pull 2>&1)
echo "Git pull: $GIT_OUTPUT" >> "$LOG_FILE"

# Copy all site files to public_html
FILES="index.html about.html paybill.html policy.html tti-ga.html tti-nvr.html tti-voip.html send-quote.php send-voip-quote.php deploy.php"

for FILE in $FILES; do
    if [ -f "$REPO_PATH/$FILE" ]; then
        cp "$REPO_PATH/$FILE" "$DEPLOY_PATH/$FILE"
        echo "Copied: $FILE" >> "$LOG_FILE"
    else
        echo "Missing: $FILE" >> "$LOG_FILE"
    fi
done

echo "Deploy finished: $(date)" >> "$LOG_FILE"
