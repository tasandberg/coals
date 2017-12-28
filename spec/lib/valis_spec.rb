RSpec.describe Valis do
  it 'has a version number' do
    expect(Valis::VERSION).not_to be nil
  end

  context 'when calling in an initializer-like way' do
    it 'yields configuration to the block' do
      expect do |block|
        described_class.configure(&block)
      end.to yield_with_args(Valis::Configuration.instance)
    end

    it 'returns the configuration' do
      expect(described_class.configure).to eq(Valis::Configuration.instance)
    end
  end
end
