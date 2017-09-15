module Components
  class PlayerInputComponent
    attr_reader :max_speed, :rotate_speed
    
    def initialize(max_speed, rotate_speed)
      @max_speed = max_speed
      @rotate_speed = rotate_speed
    end
  end
end
