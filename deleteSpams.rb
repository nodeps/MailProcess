#!/usr/bin/env ruby
#How to use
#crontab -e 编辑当前文件
#Runs `deleteSpam.sh` every 10 minutes.
#*/10 * * * * /Users/bruce.wang/Desktop/enjoy/y-邮件删除/deleteSpam.sh

require 'viewpoint'
include Viewpoint::EWS

endpoint = 'https://mail.corp.yourdomain.com/EWS/Exchange.asmx'
user = 'yourname'
pass = 'pass'
SEND_TO = 'yourmail@qq.com'

$cli = Viewpoint::EWSClient.new endpoint, user, pass


# 垃圾邮件正则
KEYWORDS_REGEX = /发布申请|活动通知|档期上新|监控中心|运维工程部周报|代码质量报告|自助分析平台/i
$inbox = $cli.get_folder_by_name "收件箱"

# 发送邮件函数
def sendMail(subject,body,body_type,to_recipients)
    $cli.send_message do |m|
      m.subject       =  subject
      m.body          =  body
      m.body_type     =  body_type
      m.to_recipients << to_recipients #收件人数组，可写多项
    end
end


# 删除垃圾邮件
def deleteSpam
    $inbox.items.each do |email|
        if email.subject[KEYWORDS_REGEX]
            #sendMail(email.subject,email.body,email.body_type,SEND_TO) #删除邮件前备份
            email.delete!
        end
    end
end
deleteSpam






