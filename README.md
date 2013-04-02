testnetconn
===========

A simple bash script for checking and restarting local network connections

Introduction
============

testnetconn uses ping to contact any number of specified hosts and executes the specified command if no pings are returned.

testnetconn can be executed manually but is best run using cron on a regular basis.

Example Installation
====================

  Install testnetconn.sh to /usr/bin/testnetconn
  Copy testnetconn.conf to /etc
  Edit testnetconn.conf as follows:
    Add the IPs or Hostnames to HOSTS that you want to ping - IPs are safer in case of DNS issues. It's best to use HOSTS that are known to have 100% uptime.
    Change NET_CMD to your distributions network restart command. Alternatively you can specify any other command, you might choose to run another bash script or send an email, for example.
    Set PING_ATTEMPTS to a number you find acceptable. Bear in mind that you should not aggressively ping your chosen HOSTS!
    Set PING to the installation path of ping.
  Finally, you should create a cron job to run testnetconn:
    */30 * * * * /usr/bin/testnetconn
  This will run testnetconn every 30 minutes.
