module JIRA

# @abstract
# The base class for all JIRA objects that can be created by the server.
class Entity

  class << self
    attr_accessor :attributes

    # @param [Hash] attributes
    # @return [Hash]
    def add_attributes attributes
      @attributes = ancestors[1].attributes.dup
      @attributes.update attributes
    end
  end

  @attributes = {} # needs to be initialized

  # @todo change name to #new_from_xml
  # @param [Handsoap::XmlQueryFront::NokogiriDriver] frag
  # @return [JIRA::Entity]
  def self.new_with_xml_fragment frag
    entity = allocate
    entity.initialize_with_xml frag
    entity
  end

  # @todo put debug message through the logger
  # @todo make this faster by cutting out NokogiriDriver,
  #  but I will need to add an accessor for @element of the
  #  driver object and then need to inject the marshaling
  #  methods into Nokogiri classes
  # @param [Handsoap::XmlQueryFront::NokogiriDriver] frag
  def initialize_with_xml frag
    attributes = self.class.attributes
    frag.children.each { |node|
      action = attributes[node.node_name]
      self.send action[0], (node.send *action[1..-1]) if action
      #puts "Action is #{action.inspect} for #{node.node_name}"
    }
  end
end

# @abstract
# Most JIRA objects will have an id attribute as a unique identifier in
# their area.
class DynamicEntity < JIRA::Entity

  @attributes = ancestors[1].attributes
  @attributes['id'] = [:id=, :to_s]

  # @return [String] usually holds a numerical value but for consistency with
  #  with id's from custom fields this attribute is always a String
  attr_accessor :id

end

# @abstract
# Many JIRA objects include a name.
class NamedEntity < JIRA::DynamicEntity

  @attributes = ancestors[1].attributes
  @attributes['name'] = [:name=, :to_s]

  # @return [String] a plain language name
  attr_accessor :name

end

# @abstract
# Several JIRA objects include a short description.
class DescribedEntity < JIRA::NamedEntity

  @attributes = ancestors[1].attributes
  @attributes['description'] = [:description=, :to_s]

  # @return [String] usually a short blurb
  attr_accessor :description

end

# @abstract
# Represents a scheme used by the server. Not very useful for the sake of the
# API; a more useful case might be if you wanted to emulate the server's
# behaviour.
class Scheme < JIRA::DescribedEntity
  # Schemes that inherit this class will have to be careful when they try
  # to encode the scheme type in an xml message.
  # @return [Class]
  alias_method :type, :class
end

# @abstract
# A common base for most issue properties. Core issue properties have
# an icon to go with them to help identify properties of issues more
# quickly.
class IssueProperty < JIRA::DescribedEntity

  @attributes = ancestors[1].attributes
  @attributes['icon'] = [:icon=, :to_url]

  # @return [URL] A NSURL on MacRuby and a URI::HTTP object in CRuby
  attr_accessor :icon

end

end
