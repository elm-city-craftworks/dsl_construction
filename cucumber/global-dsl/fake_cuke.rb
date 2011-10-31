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
end

def steps     
  @steps ||= []
end

def step(*args, &block)
  steps << FakeCuke::Step.new(*args, &block)
end

def match(text)   
  steps.each { |s| s.match(text) }
end

Dir.glob("#{File.dirname(ARGV[0])}/step_definitions/*.rb") do |step_definition|
  require File.expand_path(step_definition)
end

File.foreach(ARGV[0]) do |line|
  match(line)
end
