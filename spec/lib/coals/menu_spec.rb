require 'spec_helper'

RSpec.describe Coals::Menu do
  subject(:menu) { described_class.new(title: 'Favorite Color', options: options) }

  let(:user_input) { "1\n" }
  let(:options) do
    {
      'Option 1' => 'option1',
      'Option 2' => 'option2'
    }
  end

  before do
    allow($stdin).to receive(:gets).and_return user_input
    allow($stdout).to receive(:puts).and_return nil
    allow($stdout).to receive(:print).and_return nil
  end

  it 'prints a menu of options to the screen' do
    menu_string = nil
    allow($stdout).to receive(:puts) { |arg| menu_string = arg }
    menu
    expect(menu_string).to include('1.  Option 1', '2.  Option 2')
  end

  it 'captures the value of a user selection' do
    expect(menu.selection).to eq 'option1'
  end
end
