class Task < ApplicationRecord
  belongs_to :user, optional: true

  enum status: {wip: 0, done: 1}

  scope :search_by_title, ->(title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :search_by_description, ->(description) { where('description LIKE ?', "%#{description}%") if description.present? }
  scope :sort_by_completed_at, -> (completed_at) {
    return order(:completed_at) if completed_at === "completed_at_asc"
    return order(completed_at: :desc) if completed_at === "completed_at_desc"
  }

  validates :title, presence: true
  validates :completed_at, presence: true
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if completed_at.present? && completed_at <= Time.current.end_of_day
      errors.add(:completed_at, "can't be in the past or current day")
    end
  end
end
