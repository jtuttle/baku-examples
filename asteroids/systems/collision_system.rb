include Components

module Systems
  class CollisionSystem < Baku::System
    def initialize
      super([ColliderComponent,
             TransformComponent], :draw)
    end

    def process_entities(entities)
#      for i in (0..entities.length)
#        for j in ((i + 1)..entities.length)
#          puts "woo"
#        end
#      end
    end
  end
end
