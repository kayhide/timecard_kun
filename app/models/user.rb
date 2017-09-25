class User < ApplicationRecord
  validates :name, presence: true

  delegate :to_s, to: :name
end
