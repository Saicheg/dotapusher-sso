class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :cas_authenticatable, :omniauthable, :omniauth_providers => [:facebook, :vkontakte, :twitter, :bnet, :steam, :wargaming]

  before_save :set_uuid

  has_many :external_authentications

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
