FactoryBot.define do
  factory :comment do
    content { "This is a comment." }  # Set a default content for comments
    association :user, factory: :user
    association :post, factory: :post
  end
end