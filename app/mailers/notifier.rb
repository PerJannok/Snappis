class Notifier < ActionMailer::Base
  default :from => 'fromReviewSite@host.com'
  
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => "#{user.name} <#{user.email}>", :subject => 'Thanks for signing up for our amazing app' )
  end
end
