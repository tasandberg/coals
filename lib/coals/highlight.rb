module Coals
  COLORS = {
    BLACK:          30,
    RED:            31,
    GREEN:          32,
    BROWN:          33,
    BLUE:           34,
    MAGENTA:        35,
    CYAN:           36,
    GRAY:           37,
    BG_BLACK:       40,
    BG_RED:         41,
    BG_GREEN:       42,
    BG_BROWN:       43,
    BG_BLUE:        44,
    BG_MAGENTA:     45,
    BG_CYAN:        46,
    BG_GRAY:        47,
    BOLD:           1,
    ITALIC:         3,
    UNDERLINE:      4
  }.freeze

  module Highlight
    refine String do
      def colorize(code)
        "\033[#{code}m#{self}\033[0m"
      end

      COLORS.each do |color_name, code|
        define_method color_name.downcase.to_sym do
          colorize(code)
        end
      end
    end
  end
end
