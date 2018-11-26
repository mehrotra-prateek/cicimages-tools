require 'utils/commandline/return'
require 'rspec/bash'
shared_context :shell_spec do |script_root:|
  include Rspec::Bash

  let(:script_path){"#{__dir__}/../../../#{script_root}/#{self.class.top_level_description}"}

  attr_reader :last_result
  def execute_function(function, env_vars = {})
    stdout, stderr, status = stubbed_env.execute_function(
        script_path,
        function,
        env_vars
    )

    @last_result = Commandline::Return.new(stdout: stdout, stderr: stderr, exit_code: status.exitstatus)
  end

  around do |example|
    example.call

    if example.exception
      puts last_result
    end
  end
end