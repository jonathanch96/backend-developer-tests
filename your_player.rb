require './base_player.rb'

class YourPlayer < BasePlayer

  def initialize(game:, name:)
    @game = game
    @name = name

    @lastPosition = {
      rows: 0,
      columns: 0
    }
    @direction = ''
    @visited = {}
  end

  def move_right
    @lastPosition[:columns] += 1
    @visited["#{@lastPosition[:rows]}-#{@lastPosition[:columns]}"] = true

  end
  def move_up
    @lastPosition[:rows] -= 1
    @visited["#{@lastPosition[:rows]}-#{@lastPosition[:columns]}"] = true

  end
  def move_left
    @lastPosition[:columns] -= 1
    @visited["#{@lastPosition[:rows]}-#{@lastPosition[:columns]}"] = true

  end
  def move_down
    @lastPosition[:rows] += 1
    @visited["#{@lastPosition[:rows]}-#{@lastPosition[:columns]}"] = true

  end


  def next_point(time:)
    # My Strategy are to visit all nodes like a spiral
    if @direction.empty?
      @direction = 'right'
      @visited["#{@lastPosition[:rows]}-#{@lastPosition[:columns]}"] = true
      return {
        row: @lastPosition[:rows],
        col: @lastPosition[:columns]
      }
    end

    if @direction == 'right'
      nextMove = @visited["#{ @lastPosition[:rows] }-#{ @lastPosition[:columns] + 1 }"]
      if @lastPosition[:columns] < grid.max_col && nextMove.nil?
        move_right
        return {
          row: @lastPosition[:rows],
          col: @lastPosition[:columns]
        }
      else
        @direction = 'down'
      end
    end

    if @direction == 'down' 
      nextMove = @visited["#{ @lastPosition[:rows] + 1 }-#{ @lastPosition[:columns] }"]
      if @lastPosition[:rows]  < grid.max_row && nextMove.nil?
        move_down
        return {
          row: @lastPosition[:rows],
          col: @lastPosition[:columns]
        }
      else
        @direction = 'left'
      end
    end

    if @direction == 'left' 
      nextMove = @visited["#{ @lastPosition[:rows] }-#{ @lastPosition[:columns] - 1 }"]
      if @lastPosition[:columns] > 0 && nextMove.nil?
        move_left
        return {
          row: @lastPosition[:rows],
          col: @lastPosition[:columns]
        }
      else
        @direction = 'up'
      end
    end

    if @direction == 'up' 
      nextMove = @visited["#{ @lastPosition[:rows] - 1 }-#{ @lastPosition[:columns] }"]
      if @lastPosition[:rows] > 0 && nextMove.nil?
        move_up
        return {
          row: @lastPosition[:rows],
          col: @lastPosition[:columns]
        }
      else
        @direction = 'right'
        move_right
        return {
          row: @lastPosition[:rows],
          col: @lastPosition[:columns]
        }
      end
    end
  end

  def grid
    game.grid
  end
end
