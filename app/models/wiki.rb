class Wiki < ActiveRecord::Base
  attr_accessor :col_email
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  def initialize
    @col_email = col_email
  end
  # @w = Wiki.new
  # puts @w.attribute_names
  # before_save

end
