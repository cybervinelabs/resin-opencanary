# resin-opencanary

Resin.io compatible containerised OpenCanary

# [Please support Thinkst and get a real Canary (or 2 or more)!!!](https://canary.tools/)

[Thinkst OpenCanary](https://github.com/thinkst/opencanary)

[Diverging Deception Designs: Honeypots and tokens in modern networks](https://www.youtube.com/watch?v=BRsrK3hNAXo)

After having the pleasure of watching this video from LinuxConfZA (that was held on the week of the 8th October 2018) and seeing some additional releases to the OpenCanary code base after the event, I decided it was time to update my older MHN based honeypots to something a little more powerful and flexible in terms of log routing etc.

Additionally, I had a requirement to still maintain a similar principle to MHN in that I wanted centralized management of the raspberry Pi devices - however, this was not as difficult as I thought to resolve as I stumbled upon a company named [Resin.io](https://resin.io/) that has an IOT management platform I wanted to test out for another project I have been working on, and this opportunity gave me a chance to see how that would work for this use case while giving me a chance to prove my other use cases. ;)

Below are some options for log handlers, there are many available so I did not want to include them all - more information can be found on the [OpenCanary GitHub page](https://github.com/thinkst/opencanary)

```
"handlers": {
            "console": {
                "class": "logging.StreamHandler",
                "stream": "ext://sys.stdout"
            },
            "file": {
                "class": "logging.FileHandler",
                "filename": "/var/tmp/opencanary.log"
            },
            "syslog-unix": {
                "class": "logging.handlers.SysLogHandler",
                "address": [
                    "localhost",
                    514
                ],
                "socktype": "ext://socket.SOCK_DGRAM"
            },
            "json-tcp": {
                "class": "opencanary.logger.SocketJSONHandler",
                "host": "127.0.0.1",
                "port": 1514
            }
```


TBD:

* Implement Samba support into the container, and configure for OpenCanary to use
* Implement [OpenCanary Correlator](https://github.com/thinkst/opencanary-correlator)
* Long term goal: fork OpenCanary to use ENV vars from resin.io interface to uniquely customize each Pi to a selection of differentiated services, currently "all Pi are equal" in terms of a single resin.io App (multiple Apps could be created depending on your requirements - but then it's separate OS images etc).
* Long term goal: create an API that generates the OpenCanary configuration and a corresponding service on the container which fetches this configuration, dumps it to file and then restarts opencanary
* Long term goal: Data aggregation and analytics

# [Please support Thinkst and get a real Canary (or 2 or more)!!!](https://canary.tools/)




