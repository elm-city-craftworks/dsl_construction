require "minitest/autorun"

# inspired by some code from Chris Wanstrath (shared w. me by Ryan Smith)
# https://gist.github.com/25455
#
# heavily modified by Gregory Brown at this point..
#
# NOTE: It's recommended to use MiniTest::Spec instead of these helpers now that
# it has gained widespread adoption.

def context(*args, &block)
  return super unless (name = args.first) && block

  context_class = Class.new(MiniTest::Unit::TestCase) do
    class << self
      def test(name, &block)
        block ||= lambda { skip(name) }

        define_method("test: #{name} ", &block)
      end

      def setup(&block)
        define_method(:setup, &block)
      end

      def teardown(&block)
        define_method(:teardown, &block)
      end

       def to_s
         name
       end
    end
  end

   context_class.singleton_class.instance_eval do
     define_method(:name) { name }
   end

  context_class.class_eval(&block)
end
