class SimpleEmail < ActionMailer::Base
  default from: Figaro.env.send_email_from

  def simple_email( email, subject, body )
    mail(
      :to => email,
      :subject => subject
    ) do |format|
      format.text { render :text => body }
    end
  end

end
