# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def index?
    false
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

  def destroy?
    true
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      #scope.where(calendar: user.teams.map(&:calendars)&.first)
      scope
    end

    private

    attr_reader :user, :scope
  end

  private

end
