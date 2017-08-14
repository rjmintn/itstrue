class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy, through: :collaborators
  has_many :collaborators
  after_initialize {self.role ||= :standard }
  after_update :check_user_private_wiki

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
         # :validatable, :confirmable

  enum role: [:standard, :premium, :admin]

  def check_user_private_wiki
    if self.standard?
      Wiki.where(user_id: self.id, private: true).find_each do |wiki|
        wiki.update_attribute(:private, false)

      end
    end
  end

end
