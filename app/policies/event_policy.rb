class EventPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    user && user_have_access_to_this_calendar?
  end

  def create?
    user && user_belongs_to_a_team? && user_team_has_a_calendar?
  end

  def update?
    user && user_have_access_to_this_calendar?
  end

  def destroy?
    user && user_have_access_to_this_calendar?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(calendar: user.teams.map(&:calendars)&.first)
    end

    private

    attr_reader :user, :scope
  end

  private

  def user_have_access_to_this_calendar?
    user.team_ids.include? record.team.id
  end

  def user_belongs_to_a_team?
    user.teams.any?
  end

  def user_team_has_a_calendar?
    user.calendars.any?
  end
end
