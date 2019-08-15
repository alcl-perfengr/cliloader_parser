class TestState < Minitest::Test

  def test_3D
    begin
    File::open("./3D/clintercept_log.txt", "r") { |f|
      CLILoader::State::activate_states
      CLILoader::Files::dir = "./3D/"
      objects, events = CLILoader::Parser.parse(f)
      assert_equal( 7, objects.size)
      assert_equal( 1527, events.size)
      objects.each { |_, ol|
        ol.each { |o|
          assert_equal( 105, o.deletion_date)
        }
      }
      objects.each { |_, ol|
        ol.each { |o|
          if o.kind_of? CLILoader::CL::Kernel
            assert_equal( 14, o.state[:args].length )
            assert_equal( 14, o.state[:arg_files].length )
            assert_equal( 0, o.state[:arg_buff_files_in].length )
            assert_equal( 0, o.state[:arg_buff_files_out].length )
          elsif o.kind_of? CLILoader::CL::Program
            assert o.state[:source]
            assert_nil o.state[:build_options]
            assert_equal( 1, o.state[:compile_number] )
          end
        }
      } 
    }
    ensure
      CLILoader::State::deactivate_states
      CLILoader::Files::dir = nil
    end
  end

  def test_lud
    begin
    File::open("./lud/clintercept_log.txt", "r") { |f|
      CLILoader::State::activate_states
      CLILoader::Files::dir = "./lud/"
      objects, events = CLILoader::Parser.parse(f)
      assert_equal( 7, objects.size)
      assert_equal( 1157, events.size)
      objects.each { |_, ol|
        ol.each { |o|
          if o.kind_of? CLILoader::CL::Program
            assert o.state[:source]
            assert o.state[:build_options]
            assert_equal( 1, o.state[:compile_number] )
          end
        }
      } 
    }
    ensure
      CLILoader::State::deactivate_states
      CLILoader::Files::dir = nil
    end
  end

end
