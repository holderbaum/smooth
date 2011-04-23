require 'helper'

class SmoothCLITest < Test::Unit::TestCase

  context 'build' do
    test "it should create the whole project" do
      init_haml_template
      in_test_dir do
        Smooth::CLI.new.build

        assert_slides_creation
      end
      clear_test_dir
    end
  end

end
