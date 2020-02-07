class GameCard
    attr_accessor :id, :code, :face, :top_left_x, :top_left_y, :width, :height, :local_player

    def initialize(id, code, face, top_left_x, top_left_y, width, height, local_player)
        @id = id
        @code = code
        @face = face
        @top_left_x = top_left_x
        @top_left_y = top_left_y
        @width = width
        @height = height
        @local_player = local_player
    end

    def ==(other)
        @id == other.id &&
        @code == other.code &&
        @face == other.face && 
        @top_left_x == other.top_left_x && 
        @top_left_y == other.top_left_y && 
        @width == other.width && 
        @height == other.height && 
        @local_player == other.local_player
    end
end