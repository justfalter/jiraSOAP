module JIRA

# Contains a base64 encoded avatar image and metadata about the avatar.
class Avatar < JIRA::DynamicEntity
  add_attributes({
    'owner'       => [:owner=,       :to_s],
    'type'        => [:type=,        :to_s],
    'contentType' => [:mime_type=,   :to_s],
    'base64Data'  => [:base64_data=, :to_s],
    'system'      => [:system=,      :to_boolean],
  })

  # @return [String]
  attr_accessor :owner

  # @return [String] the place where the avatar is used
  attr_accessor :type

  # @return [String]
  attr_accessor :mime_type

  # @return [String]
  attr_accessor :base64_data

  # @return [boolean] indicates if the image is the system default
  attr_accessor :system
  alias_method :system?, :system
end

end
