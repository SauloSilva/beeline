class Map < ActiveRecord::Base
  has_many :cities, dependent: :destroy

  before_save :transform_name

  private

  def transform_name
    self.name.upcase!
  end
end