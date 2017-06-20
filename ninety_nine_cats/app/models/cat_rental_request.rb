# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, uniqueness: true, presence: true
  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: {in: %w(APPROVED DENIED PENDING)}

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

    # def overlapping_requests
    #   conflicts = self.where("cat_id = cat_id")
    #
    #
    #
    #
    #
    #   # conflicts.each do |conflict|
    #   #   if self[cat_id].start_date < self[cat_id].end_date
    #   #     self.status = "DENIED"
    #   #   else
    #   #     "APPROVED"
    #     end
    #   end
    # end
end
