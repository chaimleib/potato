FactoryGirl.define do
  factory :due_date do
    branch_name "master"
    due "07/24/2015"
    due_ref nil

    trait :ref do
      branch_name "_eos"
      due  nil
      # due_ref nil  # must set from creator
    end
    factory :ref_due_date, traits: [:ref]
  end
end
