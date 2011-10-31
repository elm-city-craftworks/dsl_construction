module FakeCuke
  class Step
    def initialize(pattern, &callback)
      @pattern  = pattern
      @callback = callback
    end

    def match(text)
      md = @pattern.match(text)
      @callback.call(*md.captures) if md
    end
  end

  class Scenario
    def steps     
      @steps ||= []
    end

    def step(*args, &block)
      steps << FakeCuke::Step.new(*args, &block)
    end

    def match(text)   
      steps.each { |s| s.match(text) }
    end

    def load_steps(file)
      eval File.read(file), binding
    end
  end

end

scenario = FakeCuke::Scenario.new

require "#{File.expand_path(File.dirname(ARGV[0]))}/support/env"

Dir.glob("#{File.dirname(ARGV[0])}/step_definitions/*.rb") do |step_definition|
  scenario.load_steps(File.expand_path(step_definition))
end

File.foreach(ARGV[0]) do |line|
  scenario.match(line)
end
