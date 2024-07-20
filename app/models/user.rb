class User < ApplicationRecord
    has_many :listings
    has_many :reservations
  
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, presence: true, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:[\s.-]?\d{2}){4}\z/, message: "please enter a valid French number" }
    validates :description, presence: true
end
