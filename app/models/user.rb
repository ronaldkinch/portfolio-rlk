class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :omniauthable, :trackable, :validatable

  has_many :articles, foreign_key: "author_id"

  def editor?
    role == "editor"
  end

  def author?
    role == "author"
  end

  def visitor?
    role.nil?
  end

  # def self.from_omniauth(auth)
  #   auth_search = { email: auth.info.email }

  #   where(auth_search).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid =  auth.uid
  #     user.username = auth.info.nickname
  #     user.email = auth.info.email
  #   end
  # end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    # where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.nickname
      user.email = "#{user.name}-CHANGEME@twitter.example.com"
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
