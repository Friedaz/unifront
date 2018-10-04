class User < ApplicationRecord
  has_many :product, dependent: :destroy
  has_many :store, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  acts_as_messageable

  def name
    "User #{id}"
  end

  def mailboxer_email(object)
    "User #{email}"
  end

end
