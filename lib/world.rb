# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

class World

  def set(matrix)
    @matrix = matrix
  end

  def living
    result = []
    y = @matrix.size
    @matrix.each_with_index do |row, row_index|
      row_result = []
      x = row.size
      row.split(//).each_with_index do |cell, cell_index|
        live_count = 0
        left = cell_index - 1
        right = cell_index + 1
        previous_row_index = row_index - 1
        next_row_index = row_index + 1

        live_count +=1 if previous_row_index >= 0 && @matrix[previous_row_index][cell_index] == "o"
        live_count +=1 if next_row_index < y && @matrix[next_row_index][cell_index] == "o"
        live_count +=1 if left >= 0 && row[left] == "o" 
        live_count +=1 if right < x && row[right] == "o"
        row_result << live_count
      end
      result << row_result.join
    end
    result
  end

  def tick
    result = []
    next_generation = @matrix.zip living
    next_generation.each_with_index do |row, row_index|
      row_result = []
      row[0].split(//).each_with_index do |cell, cell_index|
        live_neighbours = row[1][cell_index].to_i
        if live_neighbours == 3
          row_result << 'o'
        elsif live_neighbours < 2 || live_neighbours > 3
          row_result << 'x'
        elsif live_neighbours == 2 || live_neighbours == 3
          row_result << cell
        end
      end
      result << row_result.join
    end
    result
  end

end


