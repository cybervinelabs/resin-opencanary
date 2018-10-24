"""
Forwards logs from OpenCanary that come in on port 1514 to an email address.

This is a very simple script, it does no validation on the logs, it just
forwards everything that comes in.
"""
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

from twisted.internet import protocol, reactor

# Settings
FROM_ADDRESS = 'opencanary@example.com'
TO_ADDRESS = 'security@example.com'
SMTP_SERVER = 'mail.example.com'
# Saving passwords in a file is not a great idea. If you do need to log in to
# your SMTP server, at the very least make sure this file is not world readable
# e.g. `chmod 700 canary_log_forwarder.py`
SMTP_USERNAME = None
SMTP_PASSWORD = None


class SendEmail(protocol.Protocol):
    def dataReceived(self, data):
        message = MIMEMultipart('alternative')
        message_body = MIMEText(data, "plain", "utf-8")
        message['Subject'] = 'Alert from OpenCanary'
        message['From'] = FROM_ADDRESS
        message['To'] = TO_ADDRESS
        message.attach(message_body)

        server = smtplib.SMTP(SMTP_SERVER)
        server.ehlo()
        server.starttls()
        server.ehlo()
        # Login if applicable
        if SMTP_PASSWORD and SMTP_PASSWORD:
            server.login(SMTP_USERNAME, SMTP_PASSWORD)
        server.sendmail(FROM_ADDRESS, [TO_ADDRESS], message.as_string())
        server.quit()


class EmailFactory(protocol.Factory):
    def buildProtocol(self, addr):
        return SendEmail()


reactor.listenTCP(1514, EmailFactory(), interface='localhost')
reactor.run()
