class Load < Obake::State
  def initialize
    super(:load)
  end

  def on_enter(data)
    world = create_world
    player = EntityFactory.create_player(world)
    
    create_starter_asteroid(world, 100, 100)
    create_starter_asteroid(world, GameConfig::SCREEN_WIDTH - 100, 100)
    create_starter_asteroid(world, 100, GameConfig::SCREEN_HEIGHT - 100)
    create_starter_asteroid(world,
                            GameConfig::SCREEN_WIDTH - 100,
                            GameConfig::SCREEN_HEIGHT - 100)

    exit(:play, { world: world, player: player })
  end

  private

  def create_world
    world = Baku::World.new

    # update systems
    world.add_system(Systems::InputSystem.new)
    world.add_system(Systems::LaserSystem.new)
    world.add_system(Systems::MovementSystem.new)
    world.add_system(Systems::ScreenWrapSystem.new)
    world.add_system(Systems::TimedDestroySystem.new)
    world.add_system(Systems::CollisionSystem.new)
    world.add_system(Systems::AsteroidSplitSystem.new)
    world.add_system(Systems::PlayerDeathSystem.new)

    # draw systems
    world.add_system(Systems::SpriteRenderSystem.new)
    #world.add_system(Systems::ColliderRenderSystem.new)

    world
  end
  
  def create_starter_asteroid(world, x, y)
    EntityFactory.create_asteroid(world, 3, x, y)
  end
end
