class Recipe < ActiveRecord::Base
  validates :name, presence: true

  has_many :versions, class_name: RecipeVersion.to_s
end
