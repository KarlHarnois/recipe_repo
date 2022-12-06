class Recipe < ActiveRecord::Base
  validates :name, presence: true
  has_many :recipe_versions

  def current_version
    versions.max_by(&:created_at)
  end

  def ingredients
    current_version.ingredients
  end

  alias latest_version current_version
  alias_attribute :versions, :recipe_versions
end
