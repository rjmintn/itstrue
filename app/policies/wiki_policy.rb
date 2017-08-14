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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
# testing
        puts wikis.count
        puts Collaborator.first
      elsif user.role == 'premium'
        # puts wiki.user
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.collaborators.include?(user)
            wikis << wiki
# testing
            puts wiki.collaborators
          end
        end
# testing
        puts wikis.count
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
# testing
        puts wikis.count
      end
      wikis
    end
  end
end
