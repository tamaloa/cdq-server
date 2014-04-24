class Notification < ActiveRecord::Base
  belongs_to :app

  after_save :send_email


  def send_email
    EmailNotification.simple
  end

end
