class SupportRequest < ApplicationRecord
  before_create :format_name
  after_initialize :set_defaults

  validates :name, presence: true, length: { maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum:250 },
                                    format: { with: VALID_EMAIL_REGEX }
  enum department: { Sales: 0, Marketing: 1, Technical: 2 }
  validates :message, presence: true, length: { maximum: 2000 }

  scope :search_requests, -> (key = ""){
      where(["name ILIKE ? OR email ILIKE ? OR message ILIKE ?", "%#{key}%", "%#{key}%", "%#{key}%}" ])
      .order("updated_at DESC")}

    private

      def format_name
        self.name = self.name.titleize
      end
      def set_defaults
        self.complete ||= false
      end
end
