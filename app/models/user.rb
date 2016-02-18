class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :cas_authenticatable

  before_save :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
