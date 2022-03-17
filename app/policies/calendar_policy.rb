# frozen_string_literal: true

class CalendarPolicy < ApplicationPolicy
  def index?
    user && owner?
  end

  def show?
    user && owner?
  end

  def create?
    user
  end

  def update?
    user && owner?
  end

  def destroy?
    user && owner?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(team: user.teams)
      end
    end

    private

    attr_reader :user, :scope
  end

  private

  def owner?
    user.team_ids.include?(record.team_id)
  end
end
