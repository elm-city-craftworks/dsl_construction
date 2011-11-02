class FakeMail

  def self.deliver(&block)
    mail = MessageBuilder.new(&block).message
    mail.deliver
  end

  class MessageBuilder
    def initialize(&block)
      @message = Message.new
      instance_eval(&block) if block
    end

    attr_reader :message

    def from(text)
      message.from = text
    end

    def to(text)
      message.to = text
    end

    def subject(text)
      message.subject = text
    end

    def body(text)
      message.body = text
    end
  end

  class Message
    attr_accessor :from, :to, :subject, :body

    def deliver
      puts "Delivering a message from #{from} to #{to} "+
      "with the subject '#{subject}' and "+
      "the body '#{body}'"
    end
  end
end


puts "Via DSL"

FakeMail.deliver do
  from    "gregory.t.brown@gmail.com"
  to      "test@test.com"
  subject "Hello world"
  body    "Hi there! This isn't spam, I swear"
end

puts "Via ordinary API"

mail         = FakeMail::Message.new
mail.from    = "gregory.t.brown@gmail.com"
mail.to      = "test@test.com"
mail.subject = "Hello world"
mail.body    = "Hi there! This isn't spam, I swear"

mail.deliver
