include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :sentence, aliases: [:title, :content] do
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

    trait :ldap do
      provider 'ldapmain'
      extern_uid 'my-ldap-id'
    end

    factory :admin, traits: [:admin]
  end

  factory :group do
    sequence(:name) { |n| "group#{n}" }
    path { name.downcase.gsub(/\s/, '_') }
    type 'Group'
  end

  factory :namespace do
    sequence(:name) { |n| "namespace#{n}" }
    path { name.downcase.gsub(/\s/, '_') }
    owner
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

end
