include Components

module Systems
  class InputSystem < Baku::System
    def initialize
      super([PlayerInputComponent,
             VelocityComponent,
             RotationComponent], :update)
    end

    def process_entity(entity, player_input, velocity, rotation)
      player_input.accelerating = Gosu.button_down?(Gosu::KB_UP)
      
      velocity.rotational =
        (Gosu.button_down?(Gosu::KB_LEFT) ? -player_input.rotation_speed : 0) +
        (Gosu.button_down?(Gosu::KB_RIGHT) ? player_input.rotation_speed : 0)
    end
  end
end
