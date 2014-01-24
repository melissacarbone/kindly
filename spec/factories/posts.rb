FactoryGirl.define do
  factory :post do
    title 'Coffee'
    description 'I paid for coffee for the person behind me at Starbucks.'
    location 'New York'
    category
    user
  end
end
