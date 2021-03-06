#! /bin/sh
### BEGIN INIT INFO
# Provides: softside
# Required-Start: $syslog
# Required-Stop: $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: SoftSideOfTech
# Description: This file starts and stops the Soft Side of Tech site/service.
### END INIT INFO

# source the environment variables
[ -f /root/.bash_profile ] && . /root/.bash_profile
cd /root/go

case "$1" in
 start)
   go run src/softside/hello.go >> /root/go/softside.log 2>&1 & echo $! > /root/go/softside.pid
   ;;
 stop)
   /usr/bin/killall -s 9 hello
   ;;
 restart)
  /usr/bin/killall -s 9 hello
  go run src/softside/hello.go >> /root/go/softside.log 2>&1 & echo $! > /root/go/softside.pid
   ;;
 *)
   echo "Usage: softside {start|stop|restart}" >&2
   exit 3
   ;;
esac