# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: {in: STATUSES, message: "not valid"}
  validate :no_overlaps
  validate :start_before_end

  after_initialize :set_status

  belongs_to :cat

  has_one(
    :cat_owner,
    through: :cat,
    source: :owner
  )

  belongs_to(
    :requestor,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )


  def approve!
    transaction do
      self.status = "APPROVED"
      save!
      overlapping_requests.each { |request| request.deny! }
    end

    self
  end

  def deny!
    self.status = "DENIED"
    save!
    return self
  end

  def pending?
    status == "PENDING"
  end

  private

  def set_status
    self.status ||= "PENDING"
  end

  def no_overlaps
    if !overlapping_requests.where(status: "APPROVED").empty? &&
        status == "APPROVED"
      errors[:schedule] << "overlaps with cat's previously approved request"
    end
  end

  def start_before_end
    if start_date.nil? || end_date.nil?
      errors[:schedule] << "dates can't be nil"
    elsif start_date > end_date
      errors[:schedule] << "temporal paradox"
    end
  end

  def overlapping_requests
    CatRentalRequest.where(cat_id: cat_id)
        .where(
          '(start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?)',
          start_date, end_date, start_date, end_date
        )
        .where('id != ?', id)
  end

end
#
#
# SELECT
#   *
# FROM
#   cat_rental_requests
# WHERE
#   cat_id = :cat_id
#   AND id != :id
#   AND status = "APPROVED"
#   AND (:end_date <= start_date OR :start_date >= end_date)
