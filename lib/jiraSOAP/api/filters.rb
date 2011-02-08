module JIRA
module RemoteAPI
  # @group Working with Filters

  # Retrieves favourite filters for the currently logged in user.
  # @return [Array<JIRA::Filter>]
  def get_favourite_filters
    jira_call JIRA::Filter, 'getFavouriteFilters'
  end
  alias_method :get_favorite_filters, :get_favourite_filters

  # @param [String] id
  # @return [Fixnum]
  def get_issue_count_for_filter_with_id id
    call( 'getIssueCountForFilter', id ).to_i
  end

  # @endgroup
end
end