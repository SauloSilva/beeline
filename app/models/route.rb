class Route < ActiveRecord::Base
  validates :from_id, :to_id, :distance, presence: true

  belongs_to :from, foreign_key: :from_id, class_name: :City
  belongs_to :to, foreign_key: :to_id, class_name: :City
end