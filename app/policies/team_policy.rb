class TeamPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(adhesions: user.adhesions)
      end
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end
end
