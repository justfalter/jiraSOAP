module JIRA
module RemoteAPI

##
# This module has all relevant APIs as of JIRA 4.2
module ServerInfos

  ##
  # The @build_date attribute is a Time value, but does not include a time.
  #
  # @return [JIRA::ServerInfo]
  def get_server_info
    JIRA::ServerInfo.new_with_xml jira_call( 'getServerInfo' )
  end

  ##
  # @return [JIRA::ServerConfiguration]
  def get_server_configuration
    JIRA::ServerConfiguration.new_with_xml jira_call( 'getConfiguration' )
  end

end
end
end
