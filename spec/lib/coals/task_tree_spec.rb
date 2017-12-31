require 'spec_helper'
require 'ostruct'
require 'rake'

RSpec.describe Coals::TaskTree do
  include described_class

  let(:one) { Rake::Task.new('one', Rake.application) }
  let(:one_two_three) { Rake::Task.new('one:two:three', Rake.application) }
  let(:one_two_four) { Rake::Task.new('one:two:four', Rake.application) }
  let(:one_two) { Rake::Task.new('one:two', Rake.application) }
  let(:blerp) { Rake::Task.new('blerp', Rake.application) }
  let(:test_tasks) do
    [one, one_two_three, one_two_four, one_two, blerp]
  end

  let(:expected_tree) do
    {
      'one' => [
        one,
        one_two_three,
        one_two_four,
        one_two
      ],
      'blerp' => [
        blerp
      ]
    }
  end

  before do
    allow(self).to receive(:build_tasks).and_return test_tasks
  end

  it 'builds the expected data structure from Rakefile tasks' do
    expect(task_tree).to eq expected_tree
  end

  xit 'loads the Rakefile task in the current directory'
end
