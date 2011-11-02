module FakeBuilder
  class XmlMarkup < BasicObject
    def initialize
      @output = ""
    end
    
    def method_missing(id, *args, &block)
      @output << "<#{id}>"
      
      block ? block.call(self) : @output << args.first

      @output << "</#{id}>"

      return @output
    end
  end
end

require "builder"

builder = Builder::XmlMarkup.new

xml = builder.class do |roster|
  roster.student { |s| s.name("Jim");    s.phone("555-1234") }
  roster.student { |s| s.name("Jordan"); s.phone("123-1234") }
  roster.student { |s| s.name("Greg");   s.phone("567-1234") }
end

puts xml
