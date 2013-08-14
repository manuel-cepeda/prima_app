FactoryGirl.define do

	factory :venue do
		title "Mi gran venue"
		body "esta es la decripcion"
	end

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:fb_id)  { |n| "#{n}" }
    gender    "male"
  
    factory :admin do
      admin true
    end
  end    

	factory :post do
    content "lorem ipsum"
    user
    venue
	end

end