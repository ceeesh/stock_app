class MailboxController < ApplicationController
  def platform
  end
  
  def padala
    manggagamit = {
      user: 'yeho',
      email: 'micromaggot@gmail.com'
    }

    UserMailer.with(user: manggagamit).welcome_email.deliver_now
  end
end
