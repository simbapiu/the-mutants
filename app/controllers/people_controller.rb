class PeopleController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "secretPass"

  include StatsService

  def mutant
    byebug
    dna = DnaAnalyzerService.new(person_params[:dna])
    byebug
    dna.analyze_dna
    dna.save_register

    if dna.is_mutant?
      render json: {}, status: 200
    else
      render json: {}, status: 403
    end
  end

  def stats
    stats = StatsService.get_stats

    render json: stats,
           status: 200
  end

  private

  def person_params
    params.require(:person).permit(dna: [])
  end

end
