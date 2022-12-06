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

  describe '#current_version' do
    let(:latest_version) { build :recipe_version, created_at: Time.now }

    subject do
      build :recipe, versions: [
        build(:recipe_version, created_at: 1.week.ago),
        latest_version,
        build(:recipe_version, created_at: 1.month.ago)
      ]
    end

    it 'returns the correct version' do
      expect(subject.current_version).to eq latest_version
    end

    it 'is aliased' do
      expect(subject.latest_version).to eq latest_version
    end
  end
end
