class GameCard
    attr_accessor :id, :code, :top_left_x, :top_left_y, :width, :height, :local_player

    def initialize(id, code, top_left_x, top_left_y, width, height, local_player)
        @id = id
        @code = code
        @top_left_x = top_left_x
        @top_left_y = top_left_y
        @width = width
        @height = height
        @local_player = local_player
    end

    def ==(other)
        self.id == other.id &&
        self.code == other.code
    end
end