class ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    current_user?
  end

  def show?
    #scope.where(:id => wiki.id).exists?
    current_user?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
