# MailProcess
Mail processing 垃圾邮件自动删除，自动回复邮件

deleteSpams.rb
删除垃圾邮件
crontab -e 编辑当前文件
每十分钟扫描一次，有垃圾邮件删除
*/10 * * * * /Users/bruce.wang/Desktop/enjoy/y-邮件删除/deleteSpam.sh

mail.rb
邮件自动回复
设置收件箱如果有关键词，自动回复并做相关操作，也是是十分钟扫描收件箱一次
