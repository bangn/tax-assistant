# frozen_string_literal: true

class User < ApplicationRecord
  validates :given_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :uid, presence: true, uniqueness: true

  def full_name
    "#{given_name} #{last_name}"
  end

  def self.from_omniauth(user_info)
    user = find_or_initialize_by(email: user_info.email)
    user.uid ||= SecureRandom.uuid
    user.given_name = user_info.given_name
    user.last_name = user_info.family_name
    user.username = user_info.nickname

    user.save!
  end
end
