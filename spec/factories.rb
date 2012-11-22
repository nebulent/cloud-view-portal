FactoryGirl.define do
  factory :terminal do
    name { SecureRandom.hex(10) }
    uri { "#{SecureRandom.hex(5)}@#{SecureRandom.hex(8)}" }
  end

  factory :connection do
    association :terminal
    port { rand(64000) }
    user { SecureRandom.hex(10) }
    protocol { Connection::PROTOCOLS.sample }
    credentials { SecureRandom.hex(10) }
  end

  factory :remote_session do
    association :connection
  end
end
