FactoryGirl.define do
  factory :invoice_email do
    sender_id 1
invoice_id 1
to_email "MyString"
from_email "MyString"
raw_content "MyText"
  end

end
