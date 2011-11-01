class Portal
  attr_accessor :blue, :orange

  def open?
    !!(blue && orange)
  end
end


if __FILE__ == $PROGRAM_NAME
  require_relative "test_helper"

  context "A Portal" do
    setup do
      @portal = Portal.new
    end

    test "must not be open by default" do
      refute @portal.open?
    end

    test "must not be open when just the orange endpoint is set" do
      @portal.orange = [3,3,3]
      refute @portal.open?
    end

    test "must not be open when just the blue endpoint is set" do
      @portal.blue = [5,5,5]
      refute @portal.open?
    end

    test "must be open when both endpoints are set" do
      @portal.orange = [3,3,3]
      @portal.blue = [5,5,5]

      assert @portal.open?
    end

    test "must require endpoints to be a 3 element array of numbers"
  end
end

