class EventPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(calendar: user.teams.map(&:calendars))
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end
end
