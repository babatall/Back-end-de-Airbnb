class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :dates_do_not_overlap

  private

  def dates_do_not_overlap
    if listing.overlapping_reservation?(start_date, end_date)
      errors.add(:base, 'The reservation dates overlap with another reservation.')
    end
  end
end
