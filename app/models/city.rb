class City < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }

  has_many :destinations, foreign_key: :from_id, class_name: :Route do
    def to_format!
      self.map do |route|
        [route.from.name, route.to.name, route.distance]
      end
    end
  end

  def self.destinations
    destinations = []

    City.all.each do |city|
      city.destinations.to_format!.each do |destination|
        destinations << destination
      end
    end

    destinations
  end
end