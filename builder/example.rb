module FakeBuilder
  class XmlMarkup < BasicObject
    
    def initialize
      @output = ""
    end
    
    def method_missing(id, *args, &block)
      raise ArgumentError if args.first && block
      
      @output << "<#{id}>"
      if block
        block.call(self)
      else
        @output << args.first
      end
      @output << "</#{id}>"

      return @output
    end
    
  end
end


builder = FakeBuilder::XmlMarkup.new

xml = builder.class do |roster|
  roster.student { |b| b.name("Jim"); b.phone("555-1234") }
  roster.student { |b| b.name("Jordan"); b.phone("123-1234") }
  roster.student { |b| b.name("Greg"); b.phone("567-1234") }
end

puts xml
