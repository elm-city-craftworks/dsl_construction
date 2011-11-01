class Module
  def attribute(*attribs)
    attribs.each do |a|
      define_method(a) { instance_variable_get("@#{a}") }
      define_method("#{a}=") { |val| instance_variable_set("@#{a}", val) }
    end
  end
end

class Person
  attribute :name, :email
end

person      = Person.new
person.name = "Greg Brown"

p person.name
