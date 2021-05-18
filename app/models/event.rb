class Event < ApplicationRecord
  validates :start_date, presence: true
  validate :is_past?
  validates :duration,
    presence: true,
    numericality: { greater_than: 0, message: "La durée doit être supérieure à 0"}
  validate :is_multiple_of_5?
  validates :title,
    presence: true,
    length: { in: 5..140, message: "Le titre doit faire entre 5 et 140 charactères" }
  validates :description,
    presence: true,
    length: { in: 20..1000, message: "Le titre doit faire entre 20 et 1000 charactères" }
  validates :price,
    presence: true,
    numericality: { greater_than: 0, less_than: 1001, message: "Le prix doit être compris entre 1 et 1000"}
  validates :location,
    presence: true

  def is_past?
    errors.add(:start_date, "Cette date est déjà passée") if start_date < Time.now
  end

  def is_multiple_of_5?
    errors.add(:duration, "La durée doit être multiple de 5") unless duration % 5 == 0
  end

  def end_date
    start_date + (duration*60)
  end
  
  has_many :attendances
  has_many :attendees, through: :attendances, class_name: "User"
  belongs_to :admin, class_name: "User"
end
