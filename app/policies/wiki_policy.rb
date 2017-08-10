class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def show?
    user.present?
  end

  def edit?
    user.present? && (user == wiki.user || user.admin?)
  end

  def destroy?
    user.present? && (user == wiki.user || user.admin?)
  end

  def new?
    if wiki.private?
      user.admin? || user.premium?
    else
      user.present?
    end
  end

end
