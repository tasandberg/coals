module Coals
  module Prompt
    def capture_selection(title: '', options:, prompt: '')
      Coals::Menu.new(title: title, options: options, prompt: prompt).selection
    end
  end
end

