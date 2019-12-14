class Result < ApplicationRecord
  has_many :songs, dependent: :destroy
end
