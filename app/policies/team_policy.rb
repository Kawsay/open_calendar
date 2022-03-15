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
    false
  end

  def show?
    record.is_a?(Class) ? true : user_belongs_to_this_team?
  end

  def create?
    user
  end

  def update?
    user_belongs_to_this_team?
  end

  def destroy?
    user_belongs_to_this_team?
  end

  # DEV only, will be remove in v0
  def destroy_all?
    user
  end

  private

  def user_belongs_to_this_team?
    user && (record.adhesion_ids & user.adhesion_ids).one?
  end
end
