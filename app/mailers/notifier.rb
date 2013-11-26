class Notifier < ActionMailer::Base
  default :from => 'per@jannok.se'
  
  def registration_confirmation(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    puts "notifier"
    @user = user
    puts "email"
    puts @user.email
    mail( :to => @user.email, :subject => 'Thanks for signing up for our amazing app' )
  end
end
