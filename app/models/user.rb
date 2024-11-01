class User < ApplicationRecord
  has_secure_password
  has_many :secret_groups, primary_key: :name, foreign_key: :owner
  has_many :secrets, primary_key: :name, foreign_key: :owner
  has_one :default_group, class_name: "SecretGroup", primary_key: :default_group_name, foreign_key: :name, required: false

  self.primary_key = :name

  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :email,
    format: { with: /\A[a-z0-9+_.-]+@([a-z0-9]+\.)+[a-z]{2,6}\z/, message: "Invalid email."},
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 254 }

  validates :name,
    format: { with: /\A[^\s@]{4,16}\z/, message: "Invalid user name format."},
    uniqueness: { case_sensitive: false },
    length: { minimum: 4 }

  generates_token_for :password_reset, expires_in: 10.minutes do
    password_salt&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 12.hours do
    email
  end

  before_update do
    if email_changed?
      self.verified=false
    end
  end

  after_create do
    self.secret_groups.create! name: self.default_group_name, description: "Defaut group that secrets endup in."
  end
end
