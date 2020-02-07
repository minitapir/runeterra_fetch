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
        @id == other.id &&
        @code == other.code &&
        @top_left_x == other.top_left_x && 
        @top_left_y == other.top_left_y && 
        @width == other.width && 
        @height == other.height && 
        @local_player == other.local_player
    end

    def to_output
        {
            "CardId" => @id,
            "CardCode" => @code,
            "TopLeftX" => @top_left_x,
            "TopLeftY" => @top_left_y,
            "Width" => @width,
            "Height" => @height,
            "LocalPlayer" => @local_player
        }
    end
end