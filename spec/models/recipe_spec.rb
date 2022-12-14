require 'rails_helper'

RSpec.describe Recipe do
  describe '#name' do
    it 'is required by the model' do
      subject.name = nil

      expect(subject.valid?).to be false
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
    subject do
      build :recipe, versions: [
        build(:recipe_version, created_at: 1.week.ago),
        latest_version,
        build(:recipe_version, created_at: 1.month.ago)
      ]
    end

    let(:latest_version) { build :recipe_version, created_at: Time.now }

    it 'returns the correct version' do
      expect(subject.current_version).to eq latest_version
    end

    it 'is aliased' do
      expect(subject.latest_version).to eq latest_version
    end
  end

  describe '#ingredients' do
    let(:old_version) { build :recipe_version, created_at: 3.weeks.ago }
    let(:new_version) { build :recipe_version, created_at: 3.days.ago, ingredients: ingredients }
    let(:ingredients) { build_list :ingredient, 2 }

    before do
      subject.versions = [old_version, new_version]
    end

    it 'returns the current ingredients' do
      expect(subject.ingredients).to eq ingredients
    end
  end
end
