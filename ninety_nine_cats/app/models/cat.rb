# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  validates :name, :birth_date, :description, presence: true
  validates :color, presence: true,inclusion: {in: %w(orange black grey blue)}
  validates :sex, presence: true, inclusion: {in: %w(M F)}

  def age
    @age = Time.now - birth_date
  end

  has_many :cat_rental_requests,
    :dependent => :destroy
end
