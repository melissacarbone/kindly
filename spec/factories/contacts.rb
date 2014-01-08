FactoryGirl.define do
  factory :contact do
    email 'user@example.com'
    subject 'Hello'
    description 'I like this site'
    first_name 'Jane'
    last_name 'Doe'
    user
  end
end
