# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :doubanuser do
    id 1
    data "MyText"
    gender "MyString"
  end
end
