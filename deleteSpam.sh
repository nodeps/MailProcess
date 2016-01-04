#!/bin/sh
#How to use
#crontab -e 编辑当前文件
#Runs `deleteSpam.sh` every 10 minutes.
#*/10 * * * * /Users/bruce.wang/Desktop/enjoy/y-邮件删除/deleteSpam.sh
# Requires deleteSpam script in your bin
#
echo '开始编译deleteSpam.rb'
#exec deleteSpam.rb
ruby /Users/bruce.wang/Desktop/enjoy/y-邮件删除/deleteSpam.rb
