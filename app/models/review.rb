class Review < ApplicationRecord

  belongs_to :user
  belongs_to :restaurant

  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6}
  validates :content, :rating, :title, :price, presence: true

  validates :restaurant, uniqueness: { scope: :user, message: "has already been reviewed by you"  }
  validates :restaurant_id, presence: true
  validates_associated :restaurant, presence: true

  #accepts nested attributes for :restaurant
  def restaurant_attributes=(attributes)
    restaurant = Restaurant.find_or_create_by(attributes)
    self.restaurant = restaurant if restaurant.valid? || !self.restaurant
  end

  scope :order_by_rating, -> {order(:rating)}
  scope :average_rating, -> {average(:rating).round(2)}#called upon in the restaurants index and show page



end
