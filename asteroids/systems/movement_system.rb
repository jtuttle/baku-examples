include Components

module Systems
  class MovementSystem < Baku::System
    def initialize
      super([TransformComponent, VelocityComponent, AccelerationComponent], :update)
    end

    def process_entity(entity, transform, velocity, acceleration)

    end
  end
end
