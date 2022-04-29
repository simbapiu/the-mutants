class PeopleController < ApplicationController
  skip_before_action :verify_authenticity_token

  include StatsService

  def mutant
    dna = DnaAnalyzerService.new(person_params[:dna])
    dna.analyze_dna
    if dna.create_register.save
      if dna.is_mutant?
        render json: {}, status: 200
      else
        render json: {}, status: 403
      end
    else
      render json: { message: "El ADN ya ha sido analizado." }, status: 409
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
