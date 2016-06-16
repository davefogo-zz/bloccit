class User < ActiveRecord::Base
  before_save {self.email = email.downcase if email.present?}
  before_save :format_name

  validates :name, length: {minimum:1, maximum:100}, presence: true
  validates :password, length: {minimum:6}, presence: true, unless: :password_digest
  validates :password, length: {minimum:6}, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: {case_senisitive: false},
            length: {minimum: 3, maximum: 254}

  has_secure_password

  def format_name
    if name.present?
      full_name = []
      name.split.each do |name|
        full_name << name.capitalize
      end
      self.name = full_name.join(" ")
    end

  end
end
