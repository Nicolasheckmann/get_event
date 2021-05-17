class User < ApplicationRecord
  has_many :attendances, foreign_key: 'attendee_id', class_name: 'Attendance'
  has_many :events, through: :attendances
  has_many :admin_events, foreign_key: 'admin_id', class_name: "Event"
end
