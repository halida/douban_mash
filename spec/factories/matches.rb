# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match do
    user_id 1
    item_id ""
    item_type "MyString"
    doubanuser_id 1
  end
end
