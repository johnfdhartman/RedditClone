class Sub < ApplicationRecord
  validates :title, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User

  has_many :posts
end
