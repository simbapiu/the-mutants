#frozen_string_literal: true
require 'matrix'

class DnaAnalyzerService
  
  def initialize(dna)
    @dna = dna
  end

  def dna
    @dna
  end
  
  def analyze_dna
    @secuence_count = 4

    matrix_dna = [
      [dna[0][0], dna[0][1], dna[0][2], dna[0][3], dna[0][4], dna[0][5]],
      [dna[1][0], dna[1][1], dna[1][2], dna[1][3], dna[1][4], dna[1][5]],
      [dna[2][0], dna[2][1], dna[2][2], dna[2][3], dna[2][4], dna[2][5]],
      [dna[3][0], dna[3][1], dna[3][2], dna[3][3], dna[3][4], dna[3][5]],
      [dna[4][0], dna[4][1], dna[4][2], dna[4][3], dna[4][4], dna[4][5]],
      [dna[5][0], dna[5][1], dna[5][2], dna[5][3], dna[5][4], dna[5][5]]
    ]

    @total_secuences = 0
    @total_secuences += calculate_horizontal(matrix_dna)
    @total_secuences += calculate_vertical(matrix_dna)
    @total_secuences += calculate_diagonal(matrix_dna)
    @total_secuences += calculate_diagonal(rotated_matrix_dna(matrix_dna))
  end

  def is_mutant?
    @total_secuences > 1 ? true : false
  end

  def create_register
    Person.new(is_mutant: is_mutant?, dna: dna.join("-"))
  end

  private

  def calculate(dna)
    secuences = 0
    dna.each do |rows_dna|
      rows_dna = rows_dna.join
      max_index = rows_dna.length - @secuence_count
      (0..max_index).each do |index|
        range = index + 3
        secuences += 1 if 
          rows_dna[index..range] == "A"*@secuence_count ||
          rows_dna[index..range] == "T"*@secuence_count ||
          rows_dna[index..range] == "C"*@secuence_count ||
          rows_dna[index..range] == "G"*@secuence_count
      end
    end
  
    secuences
  end
  
  def calculate_horizontal(dna)
    calculate(dna)
  end
  
  def calculate_vertical(dna)
    calculate(dna.transpose)
  end
  
  def calculate_diagonal(dna)
    dna_diagonals = []
    dna_diagonals << Matrix.rows(dna).each(:diagonal).to_a
    dna_diagonals << (0..4).collect { |i| dna[i][i+1] }
    dna_diagonals << (0..3).collect { |i| dna[i][i+2] }
    dna_diagonals << (0..4).collect { |i| dna[i+1][i] }
    dna_diagonals << (0..3).collect { |i| dna[i+2][i] }
    calculate(dna_diagonals)
  end
  
  def rotated_matrix_dna(dna)
    dna.transpose.map do |row|
      row.reverse
    end
  end
end
