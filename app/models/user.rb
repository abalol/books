class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:name]

  has_many :books, dependent: :destroy
  attachment :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }, uniqueness: false
  validates_uniqueness_of :name
  validates_presence_of :name

  # 登録時にemailを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end

end
