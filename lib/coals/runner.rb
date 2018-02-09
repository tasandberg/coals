module Coals
  class RakeRunner
    include Coals::Prompt
    include Coals::TaskTree

    def initialize
      @tasks = task_tree
      @full_command = nil
      @task = nil
      @task_arguments = {}
      @group_key = nil
      @confirmed = false
    end

    # TODO: Some cascading condition set such that user can back up or go forward by 1 step
    def run
      until @confirmed
        @namespace = capture_selection(
          title: 'Avalable Task Groups:',
          options: build_namespace_options
        )

        @task = capture_selection(
          title: "Available '#{@namespace}' commands:",
          options: build_task_options
        )

        unless @task.arg_names.empty?
          @task_arguments = @task.arg_names.each_with_object({}) { |arg, obj| obj[arg] = nil }
          capture_task_arguments while @task_arguments.values.any?(&:nil?)
        end

        @confirmed = capture_confirmation
      end

      # Invoke ensures that prerequirement tasks like rails :environment are run first.
      @task.invoke(*@task_arguments.values)
    end

    private

    def groups_menu
      options = @tasks.keys.map { |group| "#{group} (#{@tasks[group].size})" }
      print_menu(options, 'Available Task Groups')
    end

    def build_namespace_options
      @tasks.each_with_object({}) do |(group, tasks), options|
        options["#{group} (#{tasks.length})".ljust(55)] = group
      end
    end

    def capture_task_arguments
      @task_arguments.select { |_, v| v.nil? }.each_key do |arg_name|
        input = ''
        while input.empty?
          print "\nRake task '#{@task.name_with_args}'\nEnter #{arg_name}: "
          input = gets.chomp
        end
        @task_arguments[arg_name] = input
      end
    end

    def capture_confirmation
      input = nil

      until /y|yes|n|no/ =~ input
        task_string = "rake #{@task.name}"
        task_string += "[#{@task_arguments.values.join(',')}]" if @task_arguments.size.positive?
        puts 'Execute rake task? (y/n)'
        puts "   #{task_string}"
        input = gets.chomp.downcase
      end

      !!(/y|yes/ =~ input)
    end

    def subtasks
      @tasks[@namespace]
    end

    def build_task_options
      subtasks.each_with_object({}) do |task, options|
        label = task.name_with_args.to_s.ljust(30) + '# ' + task.comment
        options[label] = task
      end
    end
  end
end
