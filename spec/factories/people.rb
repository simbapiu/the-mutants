FactoryBot.define do
  factory :person do
    is_mutant { true }
    dna { "ATGCGA-CAGTGC-TTATGT-AGAAGG-CCCCTA-TCACTG" }

    trait :not_mutant do
      is_mutant { false }
      dna { "ATGCGA-CAGTGC-TTATTT-AGACGG-GCGTCA-TCACTG" }
    end
  end
end
