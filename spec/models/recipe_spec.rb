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

  describe '#versions' do
    let(:recipe) { build :recipe, versions: versions }
    let(:versions) { build_list :recipe_version, 2 }

    it 'can be associated' do
      expect(recipe.versions).to eq versions
    end
  end
end
