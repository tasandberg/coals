require 'spec_helper'

RSpec.describe Coals::Menu do
  subject(:dummy_class) do
    class DummyClass
      include Coals::Menu
    end
    dummy = DummyClass.new
    dummy.menu('Favorite color', )
  end

  it 'is a module' do
    expect(Coals::Menu.class).to be Module
  end
end
