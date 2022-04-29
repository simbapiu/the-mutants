#frozen_string_literal: true
require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  describe '#GET /stats' do
    context 'When user get empty dna stats' do
      it 'return status 200' do
        get(:stats, params: {})

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq("{}")
      end
    end

    context 'When user get dna stats' do
      let!(:mutant) { FactoryBot.create(:person) }
      let!(:not_mutant) { FactoryBot.create(:person, :not_mutant) }

      it 'return status 200 and payload count of mutants and humans' do
        get(:stats, params: {})

        count_human_dna = Person.not_mutant.count
        count_mutant_dna = Person.is_mutant.count
        ratio = count_mutant_dna.fdiv(count_human_dna)

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(stats_request(count_human_dna, count_mutant_dna, ratio).to_json)
      end
    end
  end

  describe '#POST /mutant' do
    context 'When the dna analyzed is a human' do
      let(:params) do
        { "person": 
          { "dna": 
            ["ATGCGA", "CAGTGC", "TTATTT", "AGACGG", "GCGTCA", "TCACTG"]
          }
        }
      end
      it 'return status 403 forbidden' do
        post(:mutant, params: params)

        expect(response).to have_http_status(403)
      end
    end

    context 'When the dna analyzed is a human' do
      let(:params) do
        { "person": 
          { "dna": 
            ["ATGCGA", "CAGTGC", "TTATGT", "AGAAGG", "CCCCTA", "TCACTG"]
          }
        }
      end
      it 'return status 200 ok' do
        post(:mutant, params: params)

        expect(response).to have_http_status(:ok)
      end
    end
  end 

  def stats_request(count_human_dna, count_mutant_dna, ratio)
    {
      count_mutant_dna: count_mutant_dna,
      count_human_dna: count_human_dna,
      ratio: ratio
    }
  end
end
