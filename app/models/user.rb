class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[user admin].freeze

  def admin?
    role == 'admin'
  end
end


# class User < ApplicationRecord
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable

#   ROLES = %w[user admin].freeze
#   DEFAULT_ROLE = 'user'

#   validates :role, inclusion: { in: ROLES }

#   before_validation :set_default_role, on: :create

#   def admin?
#     role == 'admin'
#   end

#   private

#   def set_default_role
#     self.role ||= DEFAULT_ROLE
#   end
# end
