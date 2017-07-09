FactoryGirl.define do 
  factory :user do 
    sequence :email do |n| 
      "dummyEmail#{n}@gmail.com"
    end

    password "secretPassword"
    password_confirmation "secretPassword"
  end


  factory :game do 
    #association :piece
  end

  factory :piece do
    association :game
  end

  factory :king do
    association :piece
  end

  factory :queen do
    association :piece
  end

  factory :rook do
    association :piece
  end
  
  factory :bishop do
    association :piece
  end

  factory :knight do
    association :piece
  end

  factory :pawn do
    association :piece
  end

end
