class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  default_scope { order('rank DESC')}

  scope :ordered_by_title, -> { order('title ASC')}

  scope :ordered_by_reverse_created_at, -> {order('created_at DESC')}

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  # validates :topic, presence: true
  # validates :user, presence: true

  mount_uploader :image, ImageUploader

  # Creating an upvote for each created post from the creating user
  after_create :create_vote

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) 
    new_rank = points + age_in_days

    update_attributes({rank: new_rank})
  end

  def markdown_title 
    render_as_markdown title
  end

  def markdown_body 
    render_as_markdown body
  end

  private

  def render_as_markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

  def create_vote
    user = self.user
    vote = user.votes.create(value: 1, post: self)
  end
end
