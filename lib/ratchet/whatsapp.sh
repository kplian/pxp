#!/bin/bash
curl 'https://api.twilio.com/2010-04-01/Accounts/AC919bb101570692a9dc5939d125f02c16/Messages.json' -X POST \
--data-urlencode 'To=whatsapp:+59167500602' \
--data-urlencode 'From=whatsapp:+14155238886' \
--data-urlencode 'Body=Vouz websocket or apache is downn' \
-u AC919bb101570692a9dc5939d125f02c16:c513e495a5e2fdbb21657e26bde56768
curl 'https://api.twilio.com/2010-04-01/Accounts/AC919bb101570692a9dc5939d125f02c16/Messages.json' -X POST \
--data-urlencode 'To=whatsapp:+59172515278' \
--data-urlencode 'From=whatsapp:+14155238886' \
--data-urlencode 'Body=Vouz websocket or apache  is down' \
-u AC919bb101570692a9dc5939d125f02c16:c513e495a5e2fdbb21657e26bde56768
curl 'https://api.twilio.com/2010-04-01/Accounts/AC919bb101570692a9dc5939d125f02c16/Messages.json' -X POST \
--data-urlencode 'To=whatsapp:+59170779285' \
--data-urlencode 'From=whatsapp:+14155238886' \
--data-urlencode 'Body=Vouz websocket or apache is down' \
-u AC919bb101570692a9dc5939d125f02c16:c513e495a5e2fdbb21657e26bde56768
