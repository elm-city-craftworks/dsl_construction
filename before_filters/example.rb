class BasicController
  def self.before_filters
    @before_filters ||= []
  end

  def self.before_filter(callback, params={})
    before_filters << params.merge(:callback => callback)
  end

  def self.inherited(child_class)
    before_filters.each { |f| child_class.before_filters.unshift(f) }
  end

  def execute(action)
    matched_filters = self.class.before_filters.select do |f| 
      f[:only].nil? || f[:only].include?(action) 
    end

    matched_filters.each { |f| send f[:callback] }
    send(action)
  end
end


class ApplicationController < BasicController
  before_filter :authenticate

  def authenticate
    puts "Authenticating current user"
  end
end

class PeopleController < ApplicationController 
  before_filter :locate_person, :only => [:show, :edit, :update]

  def show
    puts "showing a person's data"
  end

  def edit
    puts "displaying a person edit form"
  end

  def update
    puts "committing updated person data to the database"
  end

  def create
    puts "creating a new person"
  end

  def locate_person
    puts "Locating a person"
  end
end

controller = PeopleController.new

puts "EXECUTING SHOW"
controller.execute(:show)

puts

puts "EXECUTING CREATE"
controller.execute(:create)
