module Coals
  class Task
    attr_reader :full_command, :group, :command, :arguments

    def initialize(row)
      @full_command = COMMAND_REGEX.match(row).captures[0]
      @command = @full_command.split('[')[0]
      @group = /(\S+):/.match(@full_command) && /(\S+):/.match(@full_command).captures[0]
      @arguments = args
      @prefix = 'bundle exec rake'
    end

    def runnable?
      !@arguments || @arguments.values.none?(&:nil?)
    end

    def build_command
      raise 'Task not buildable' unless runnable?
      argument_str = @arguments ? "[#{@arguments.values.join(',')}]" : ''
      "#{@prefix} #{@command}#{argument_str}"
    end

    def args
      args = ARGS_REGEX.match(full_command)
      args && args.captures[0].split(',').each_with_object({}) { |arg_name, obj| obj[arg_name] = nil }
    end

    def get_argument(key)
      puts "Enter #{key}:"
      entry = gets.chomp
      puts "\"#{entry}\" entered for #{key}."
      @arguments[key] = entry
    end

    def arguments_prompt
      until runnable?
        @arguments.each do |arg_name, value|
          get_argument(arg_name) if value.nil?
        end
      end
    end
  end
end
