include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :sentence, aliases: [:title, :content, :description] do
    Faker::Lorem.sentence
  end

  sequence :name, aliases: [:file_name] do
    Faker::Name.name
  end

  sequence(:url) { Faker::Internet.uri('http') }

  factory :user, aliases: [:author, :assignee, :owner, :creator] do
    email { Faker::Internet.email }
    name
    sequence(:username) { |n| "#{Faker::Internet.user_name}#{n}" }
    password "12345678"
    password_confirmation { password }
    confirmed_at { Time.now }
    confirmation_token { nil }

    trait :admin do
      admin true
    end

    trait :facebook do
      provider 'facebook'
      extern_uid 'facebook_user'
    end

    factory :admin, traits: [:admin]
  end

  factory :group do
    sequence(:name) { |n| "group#{n}" }
    description "Some description"
  end

  factory :email do
    user
    email do
      Faker::Internet.email('alias')
    end

    factory :another_email do
      email do
        Faker::Internet.email('another.alias')
      end
    end
  end

  factory :area do
    name { Faker::Internet.user_name }
    description
    owner { create(:user) }
  end

  factory :focalpoint do
    area { create(:area) }
    owner { create(:user) }
    name { Faker::Internet.user_name }
    description
  end

  factory :company do
    owner { create(:user) }
    name { Faker::Company.name }
    description
    visibility_level Incudia::VisibilityLevel::PUBLIC
  end

end
