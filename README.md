# HP ILO Fan Control

Only tested on DL380p Gen8 server, uses a very random multiplication to get a fan speed change relative to the temperature whilst attempting to keep noise to a minimum where possible.

It is recommended to use a 40mm fan, such as one from Noctua, on the raid card as it a known issue that this runs hot. To use this script you may have to tell your iLO to ignore certain sensors which read incorrect values (some automatically read 90C) or ones which can be ignored such as the raid card. This will stop the server from locking the fan speed above the minimum you set whilst still ramping up when areas of more importance are having thermal issues.

Based on https://github.com/That-Guy-Jack/HP-ILO-Fan-Control.
