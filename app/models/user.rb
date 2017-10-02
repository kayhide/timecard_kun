class User < ApplicationRecord
  has_many :records
  validates :name, presence: true

  scope :without_hidden, -> { where(hidden: false) }

  delegate :to_s, to: :name
end
