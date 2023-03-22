# Nagios2Slack

Nagios notifications for Slack, with formatted messages :

![OK](http://env.baarnes.com/nagios2slack/ok.png?git)
![Critical](http://env.baarnes.com/nagios2slack/critical.png?git)

* Set up an incoming webhook integration in your Slack workspace.</br>
( [https://my.slack.com/services/new/incoming-webhook/](https://my.slack.com/services/new/incoming-webhook/) )

* Run install.sh

* * Note, this expects nagios to be located at `/usr/local/nagios/`

* Set up a contact that uses the following config:

```
    service_notification_commands       slack-service
    host_notification_commands          slack-host
    address1				INSERT_SLACK_CHANNEL_WEBHOOK_HERE
```

* Set up your contacts' `address1` to your preferred slack webhook.  The benefit of this fork over the original code comes in the fact that you can define multiple slack webhooks via different contacts if different teams need to be contacted.
