require 'spec_helper'

RSpec.describe Coals::Menu do
  subject(:menu) { described_class.new(title: 'Favorite Color', options: options) }
  let(:user_input) { "1\n" }
  let(:options) { ['Option1', 'Option2'] }

  before do
    allow($stdin).to receive(:gets).and_return user_input
    allow($stdout).to receive(:puts).and_return nil
    allow($stdout).to receive(:print).and_return nil
  end

  it 'prints a menu of options to the screen' do
    expected_output = <<~MENU
      Favorite Color
      1.  Option1                       2.  Option2                       
    MENU
    menu
    expect(STDOUT).to have_received(:puts).with expected_output.chomp
  end

  it 'captures the value of a user selection' do
    expect(menu.selection).to eq 'Option1'
  end
end
