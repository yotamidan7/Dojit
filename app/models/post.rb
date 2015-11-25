class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  default_scope { order('created_at DESC')}

  scope :ordered_by_title, -> { order('title ASC')}

  scope :ordered_by_reverse_created_at, -> {order('created_at DESC')}
end
