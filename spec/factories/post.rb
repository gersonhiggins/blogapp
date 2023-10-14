FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }
    content { 'This is a post.' }
    comments_counter { 0 }
    likes_counter { 0 }
    association :user, factory: :user
  end
end
