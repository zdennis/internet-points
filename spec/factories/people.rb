FactoryGirl.define do
  factory :person do
    sequence(:nick){ |i| "user#{i}"}
  end
end
