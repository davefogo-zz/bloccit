class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  scope :visible_to, -> (user) {user ? all : self.publicly_viewable}

  scope :publicly_viewable, -> {self.where(public: true)}

  scope :privately_viewable, -> {self.where(public: false)}
end
