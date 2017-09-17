include Components

module Systems
  class SpriteRenderSystem < Baku::System
    def initialize
      super([SpriteComponent, TransformComponent, RotationComponent], :draw)
    end

    def process_entity(entity, sprite, transform, rotation)
      sprite.texture.draw_rot(transform.x, transform.y, 0,
                              rotation.angle,
                              0.5, 0.5, # center
                              0.5, 0.5) # scale
    end
  end
end
