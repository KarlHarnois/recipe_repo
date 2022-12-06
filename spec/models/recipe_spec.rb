require 'rails_helper'

RSpec.describe Recipe do
  describe '#name' do
    it 'is required by the model' do
      subject.name = nil

      expect(subject.valid?).to eq false
    end

    it 'is required at the database level' do
      subject.name = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end
  end
end
