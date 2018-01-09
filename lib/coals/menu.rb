module Coals
  class Menu
    using Coals::Highlight
    attr_reader :selection

    # Show a menu of options in a loop until the user makes a selection.
    # Return the selection value
    #
    # @param menu {Array} - list of options to choose from
    def initialize(options:, prompt: nil, title: '')
      @select = nil
      @options = options
      @title = title
      @prompt = prompt
      show_menu until @selection
    end

    private

    def show_menu
      menu = "\nCOALS -- #{@title}\n".brown
      menu += format_menu_options
      println menu
      integer_input
    end

    def integer_input
      print "\nChoose an option: ".bold
      option_index = raw_input.to_i - 1
      @selection = @options.values[option_index]
    end

    def raw_input
      input = $stdin.gets.chomp
      input =~ /quit|exit|q/ ? abort('Goodbye 👋') : input
    end

    def println(str)
      $stdout.puts str
    end

    def print(str)
      $stdout.print str
    end

    def min_column_width
      @options.keys.max_by(&:length).length
    end

    def columns_per_window
      cols = `tput cols`.chomp.to_i / min_column_width
      cols > 3 ? 3 : cols
    end

    def format_menu_options
      @options.keys.each_with_index.inject('') do |result, (option, i)|
        result += "\n" if (i % columns_per_window).zero?
        result + "#{i + 1}.".ljust(4) + option.ljust(30)
      end
    end
  end
end
