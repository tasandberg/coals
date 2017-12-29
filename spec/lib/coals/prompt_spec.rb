require 'spec_helper'

RSpec.describe Coals::Prompt do
  let(:dummy_class) { Class.new { include Coals::Prompt } }
  let(:dummy_instance) { dummy_class.new }

  before do
    allow($stdout).to receive(:puts).and_return nil
    allow($stdout).to receive(:print).and_return nil
  end

  it 'provides the #capture_selection method' do
    expect(dummy_instance.respond_to?(:capture_selection)).to be true
  end

  describe '#capture_selection' do
    it 'creates a menu with the options and returns the user selection' do
      allow($stdin).to receive(:gets).and_return "2\n"
      result = dummy_instance.capture_selection(options: %w[Brown Grey White Tan])
      expect(result).to eq 'Grey'
    end
  end
end
