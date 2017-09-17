module Components
  class PlayerInputComponent
    attr_reader :acceleration_speed, :max_velocity, :rotation_speed
    
    def initialize(acceleration_speed, max_velocity, rotation_speed)
      @acceleration_speed = acceleration_speed
      @max_velocity = max_velocity
      @rotation_speed = rotation_speed
    end
  end
end
