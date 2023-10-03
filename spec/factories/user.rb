FactoryBot.define do
  factory :user do
    name { 'Tom' }
    bio { 'bio' }
    post_counter { 0 }
  end
end