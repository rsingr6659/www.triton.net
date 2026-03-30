Set-Location 'C:/Users/admin/Desktop/websitefull'
git checkout master
$msgFile = 'C:/Users/admin/Desktop/websitefull/commitmsg.txt'
Set-Content $msgFile @'
Clean up quote emails: remove intro, fix timezone and phone number

- Remove intro paragraph from both HTML emails
- Set timezone to America/New_York so timestamp shows EST/EDT
- Correct phone number to 616 980 9800 in both mailers

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
'@
git add send-quote.php send-voip-quote.php
git commit -F $msgFile
Remove-Item $msgFile
git push origin master
