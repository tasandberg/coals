DESCRIPTION_REGEX = /\s+#\s(.+)/
COMMAND_REGEX = /rake (\S+)/
ARGS_REGEX = /\S+\[(\S+)\]/

module Coals
  class RakeRunner
    def initialize
      @tasks = build_tasks
      @full_command = nil
      @task = nil
      @group_key = nil
      @confirmed = false
    end

    def run
      until @group_key
        groups_menu
        entry = Integer(gets.chomp)
        @group_key = @tasks.keys[entry - 1] if (1..(@tasks.keys.length)).member?(entry)
        puts ""
      end

      until @task
        command_menu
        entry = Integer(gets.chomp)
        @task = @tasks[@group_key][entry - 1]
        puts ""
      end

      until @task.runnable?
        arguments_menu
      end

      until @confirmed
        puts 'REVIEW COMMAND'
        puts @task.build_command
        puts 'Run? (yes/no)'
        entry = gets.chomp
        @confirmed = entry == 'yes'
        puts ""
      end

      puts `#{@task.build_command}`
    rescue ArgumentError => e
      if e.message =~ /invalid value for Integer\(\)/
        puts 'Please enter a number'
        run
      else
        raise e
      end
    end

    private

    def build_tasks
      result = `bundle exec rake --tasks`
      rows = result.split("\n")
      rows.each_with_object({}) do |r, object|
        task = Task.new(r)
        if task.group
          object[task.group] ||= []
          object[task.group] << task
        else
          object[task.command] = [task]
        end
      end
    end

    def print_menu(options, title, width = 4)
      menu = title
      options.each_with_index do |option, i|
        menu += "\n" if (i % width).zero?
        menu += "#{i + 1}.".ljust(4) + option.ljust(30)
      end
      puts menu
      puts 'Choose an option:'
    end

    def groups_menu
      options = @tasks.keys.map { |group| "#{group} (#{@tasks[group].size})" }
      print_menu(options, 'Available Task Groups')
    end

    def command_menu
      menu_items = @tasks[@group_key].map(&:full_command)
      print_menu(menu_items, "Available `#{@group_key}` Commands", 1)
    end

    def arguments_menu
      desc = `bundle exec rake --describe #{@task.command}`.split("\n")[1].chomp
      @task.arguments_prompt
    end
  end
end
