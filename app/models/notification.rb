class Notification < ActiveRecord::Base
  belongs_to :app

  after_save :send_email


  def send_email
    SimpleEmail.simple_email(Figaro.env.send_email_to, title, content).deliver
  end

end
