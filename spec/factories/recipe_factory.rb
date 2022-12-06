FactoryBot.define do
  factory :recipe do
    name { 'Sushi' }
    recipe_versions { build_list :recipe_version, 1 }
  end
end
