#qq邮箱

#How to use
#crontab -e 编辑当前文件
#Runs `deleteSpam.sh` every 10 minutes.
#*/10 * * * * /Users/bruce.wang/Desktop/enjoy/y-邮件删除/deleteSpam.sh
require 'mail' 
FROM_EMAIL = '37991842@qq.com'
PASS_WORD  = 'password'
TO_EMAIL   = 'wxz1898@126.com'
Mail.defaults do  
   
  
  #收取邮件
  retriever_method :pop3, { :address             => "pop.qq.com",  
                            :port                => 995,
                            :user_name           => FROM_EMAIL,  
                            :password            => PASS_WORD ,
                            :enable_ssl          => true
  }
  #发送邮件  
  delivery_method :smtp, { :address              => "smtp.qq.com",  
                           :port                 => 25,  
                           :user_name            => 'FROM_EMAIL',  
                           :password             => PASS_WORD,  
                           :authentication       => :login,  
                           :enable_starttls_auto => true  
  } 
end  


DB_NAME_REGEX  = /\S+_staging/
KEYWORDS_REGEX = /sorry|help|wrong/i

Mail.find(:what => :last, :count => 2, :order => :desc).each do |email|
  if email.subject[KEYWORDS_REGEX] && (db_name = email.body[DB_NAME_REGEX])
    backup_file = "/home/backups/databases/#{db_name}-" + (Date.today - 1).strftime('%Y%m%d') + '.gz'

    # Restore DB
    `gunzip -c #{backup_file} | psql #{db_name}`

    create_reply(email.subject)
  end
end

def create_reply(subject)
  Mail.deliver do  
    from     FROM_EMAIL  
    to       [TO_EMAIL]  
    subject  "RE: #{subject}" 
    body     "No problem. I’ve fixed it. \n\n Please be careful next time."
  end 
end

