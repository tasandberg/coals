module Coals
  class Menu
    MENU_WIDTH = 4
    
    attr_reader :selection

    # Show a menu of options in a loop until the user makes a selection.
    # Return the selection value
    #
    # @param menu {Array} - list of options to choose from
    def initialize(options:, prompt: '', title: '')
      @select = nil
      @options = options
      @title = title
      @prompt = prompt
      show_menu until @selection
    end

    private

    def show_menu
      menu = @title
      menu += format_menu_options(@options)
      println menu
      get_user_selection
    end

    def get_user_selection
      print @prompt + '> '
      option_index = get_input.to_i - 1
      @selection = @options[option_index] if @options[option_index]
    end

    def get_input
      $stdin.gets.chomp
    end

    def println(str)
      $stdout.puts str
    end
    
    def print(str)
      $stdout.print str
    end

    def format_menu_options(options)
      options.each_with_index.inject('') do |result, (option, i)|
        result += "\n" if (i % MENU_WIDTH).zero?
        result + "#{i + 1}.".ljust(4) + option.ljust(30)
      end
    end
  end
end
