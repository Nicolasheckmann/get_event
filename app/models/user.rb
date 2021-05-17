class User < ApplicationRecord
  after_create :welcome_send

  has_many :attendances, foreign_key: 'attendee_id', class_name: 'Attendance'
  has_many :events, through: :attendances
  has_many :admin_events, foreign_key: 'admin_id', class_name: "Event"

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
