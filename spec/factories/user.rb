FactoryGirl.define do

   factory :user do
     email 'alice@example.com'
     password '12345678'
     password_confirmation '12345678'


   factory :userfail do
     password_confirmation '123456789'
   end
end
end
