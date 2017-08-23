class UserEventMailer < ActionMailer::Base

	default from: "Soul_Society@bleach.com.ph"

  def created_user_mailer(object, ip)

  	 @created_user = object
  	 @user_ip = ip
  	# attachments.inline['image.jpg'] = File.read('localhost:3000'+object.userpic.public_filename(:thumbnail))
  	  attachments.inline['r.jpg'] = File.read Rails.root.join('public'+object.userpic.public_filename(:thumbnail))
  	 mail(to: "mike@tech.onehundred.ph", subject: 'User Created!')

  end

end