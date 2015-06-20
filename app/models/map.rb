class Map < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }

  has_many :cities, dependent: :destroy, inverse_of: :map

  before_validation :transform_name

  private

  def transform_name
    name.upcase! if name
  end
end