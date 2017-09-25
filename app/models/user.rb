class User < ApplicationRecord
  has_many :records
  validates :name, presence: true

  delegate :to_s, to: :name
end
