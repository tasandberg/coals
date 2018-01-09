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
      end
    end

    private

    def groups_menu
      options = @tasks.keys.map { |group| "#{group} (#{@tasks[group].size})" }
      print_menu(options, 'Available Task Groups')
    end

    def build_namespace_options
      @tasks.each_with_object({}) do |(group, tasks), options|
        options["#{group} (#{tasks.length})"] = group
      end
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
