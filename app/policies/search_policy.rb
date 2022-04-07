# frozen_string_literal: true

class SearchPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def search?
    true
  end
end
