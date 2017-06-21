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

  def overlapping_requests
    CatRentalRequest
    .where.not(id: self.id)
    .where(cat_id: cat_id)
    .where(<<-SQL, start_date: start_date, end_date: end_date)
      NOT ((start_date > :end_date) OR
      (end_date < :start_date))
    SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = APPROVED")
  end

  def does_not_overlap_approved_request
    overlapping_approved_requests.exists?("PENDING")
  end


end
