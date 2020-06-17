class Ticket < ApplicationRecord
  validates :subject, presence: true, length: { in: 5..20 }
  validates :description, presence: true
  validates :requester, presence: true
end
