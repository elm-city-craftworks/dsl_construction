class FakeMail
  def self.deliver(&block)
    mail = Message.new(&block)
    mail.deliver
  end

  class Message
    def initialize(&block)
      instance_eval(&block) if block
    end

    attr_writer :from, :to, :subject, :body

    def from(text=nil)
      return @from unless text 

      self.from = text
    end

    def to(text=nil)
      return @to unless text

      self.to = text
    end

    def subject(text=nil)
      return @subject unless text

      self.subject = text
    end

    def body(text=nil)
      return @body unless text

      self.body = text
    end

    # this is just a placeholder for a real delivery method
    def deliver
      puts "Delivering a message from #{@from} to #{@to} "+
      "with the subject '#{@subject}' and "+
      "the body '#{@body}'"
    end
  end
end


#=begin
FakeMail.deliver do
  from    "gregory.t.brown@gmail.com"
  to      "test@test.com"
  subject "Hello world"
  body    "Hi there! This isn't spam, I swear"
end
#=end
 
mail         = FakeMail::Message.new
mail.from    = "gregory.t.brown@gmail.com"
mail.to      = "test@test.com"
mail.body    = "Hi there! This isn't spam, I swear"
mail.subject = "Hello world"

mail.deliver
