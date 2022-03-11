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

  def show?
    record.is_a?(Class) ? true : user_belongs_to_this_team?
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy_all?
    true
  end

  private

  def user_belongs_to_this_team?
    (record.adhesion_ids & user.adhesion_ids).one?
  end
end
