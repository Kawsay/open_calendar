# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    authorize :search, :search?

    if search_query.present?
      @results = PgSearch.multisearch(search_query)
                         .group_by(&:searchable_type)
    else
      @results = nil
    end


    puts "RESULTS:"
    puts @results.inspect

    render turbo_stream: turbo_stream.replace(
      'global-search-results',
      partial: 'search/global_search_result',
      locals: { results: @results }
    )
  end

  private

  def search_query
    @search_query ||= params[:query].strip
  end
end
