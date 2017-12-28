
module Coals
  module Menu

    # Show a menu of options in a loop until the user makes a selection.
    # Return the selection value
    #
    # @param menu {Array} - list of options to choose from
    def menu(title:, options:)
      @select = nil
      @options = options

      show_menu until @selection
    end

    private

    def print_menu(options, title, width = 4)
      menu = title
      options.each_with_index do |option, i|
        menu += "\n" if (i % width).zero?
        menu += "#{i + 1}.".ljust(4) + option.ljust(30)
      end
      puts menu
      puts 'Choose an option:'
    end
  end
end
