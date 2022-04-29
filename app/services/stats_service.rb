module StatsService
  class << self
    def get_stats
      return {} if Person.all.empty?

      {
        count_mutant_dna: count_mutant_dna,
        count_human_dna: count_human_dna,
        ratio: ratio
      }
    end

    def count_human_dna
      Person.not_mutant.count
    end

    def count_mutant_dna
      Person.is_mutant.count
    end

    def ratio
      return 0 if count_human_dna.zero?

      count_mutant_dna.fdiv(count_human_dna)
    end
  end
end
