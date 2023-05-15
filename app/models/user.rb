class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :first_name, :last_name, :furigana, :nihongo, :gender, :phone, :postal_code, :address, :job, presence: true

  validates :manager, :factory, :role, :status, presence: true, on: :update

end
