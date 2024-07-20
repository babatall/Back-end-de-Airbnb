class Listing < ApplicationRecord
  has_many :reservations
  belongs_to :user
  belongs_to :city

  validates :available_beds, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 140 }
  validates :welcome_message, presence: true

  # Méthode pour vérifier si une réservation chevauche une autre
  def overlapping_reservation?(start_date, end_date)
    reservations.any? do |reservation|
      (start_date - reservation.end_date) * (reservation.start_date - end_date) >= 0
    end
  end
end
