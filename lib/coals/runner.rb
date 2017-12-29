module Coals
  class RakeRunner
    include Coals::Prompt
    include Coals::TaskTree

    def initialize
      @tasks = task_tree
      @full_command = nil
      @task = nil
      @group_key = nil
      @confirmed = false
    end

    def run
      @group_key = capture_selection(
        title: 'Rake Task Groups',
        prompt: 'Select task group',
        options: @tasks
      )

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
