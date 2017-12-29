require 'rake'

module Coals
  module TaskTree
    def task_tree
      @_task_tree ||= build_tasks
    end
    
    # Coals assumes that any task lacking a description
    # is not meant to be called directly, i.e. a 'subtask'
    # This is in line with the list rendered by `rake -T`
    def build_tasks
      load_rakefile
      Rake.application.tasks.reject { |t| t.comment.nil? }
    end

    def load_rakefile
      Rake::TaskManager.record_task_metadata = true
      load 'Rakefile'
    end
  end
end
