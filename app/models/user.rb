class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, lock_strategy: :failed_attempts,
          unlock_strategy: :email, maximum_attempts: 5

  has_one :cart, dependent: :destroy

  after_create :create_cart

  validates :password, 
  length: { minimum: 12 }, 
  format: { with: /\A(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{12,}\z/,
            message: "deve conter pelo menos uma letra maiúscula, um número e um caractere especial" }


  def create_cart_if_not_exists
    self.create_cart unless self.cart
  end
end
