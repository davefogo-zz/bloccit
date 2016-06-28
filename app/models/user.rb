class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save {self.email = email.downcase if email.present?}
  before_save {self.role ||= :member}

  validates :name, length: {minimum:1, maximum:100}, presence: true
  validates :password, length: {minimum:6}, presence: true, unless: :password_digest
  validates :password, length: {minimum:6}, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: {case_senisitive: false},
            length: {minimum: 3, maximum: 254}

  has_secure_password

  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def comments_or_posts?
    if self.comments.count == 0
      "#{self.name} does not have any comments"
    elsif self.posts.count == 0
      " #{self.name} does not have any posts"
    elsif self.posts.count == 0 && self.comments.count == 0
      " #{self.name} does not have comments or posts"
    end
  end
end
