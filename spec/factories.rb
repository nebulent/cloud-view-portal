FactoryGirl.define do
  factory :terminal do
    name { SecureRandom.hex(10) }
    uri { "vnc://#{SecureRandom.hex(5)}@#{SecureRandom.hex(8)}:9292" }
  end
end
