class Cat < ApplicationRecord
  validates :name, :birth_date, :description, presence: true
  validates :sex, :color, presence: true, inclusion: true

  def age
    @age = Time.now - birth_date
  end
end
