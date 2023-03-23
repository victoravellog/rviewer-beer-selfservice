FactoryBot.define do
  factory :dispenser_usage do
    dispenser
    open_time { Time.now }
    close_time { Time.now }
  end
end
