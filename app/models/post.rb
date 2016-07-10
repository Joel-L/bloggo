class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true
  validate :picture_size

private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "how big do you really need? less than 5MB, that's how big")
    end
  end
end
