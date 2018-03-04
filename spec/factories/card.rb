FactoryBot.define do
  factory :card do
    suit '♠'
    sequence(:value) { |n| 1 + n }

    initialize_with { new(suit, value) }

    trait :facecard do
      value 'K'
    end

    trait :ace do
      value 'A'
    end

    trait :red do
      suit '♥'
    end

    trait :nine do
      value 9
    end
  end
end
