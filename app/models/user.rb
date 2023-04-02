class User < ApplicationRecord
  has_person_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30 }
  validates :mobile, presence: true, length: { minimum: 11, maximum: 11 }
  validates_format_of :mobile, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"

  enum :role, %i(user admin)
end