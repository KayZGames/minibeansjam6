// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprite_rendering_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$SpriteRenderingSystem extends EntitySystem {
  late final Mapper<Position> positionMapper;
  late final Mapper<Renderable> renderableMapper;
  late final Mapper<Orientation> orientationMapper;
  late final TagManager tagManager;
  late final CameraManager cameraManager;
  _$SpriteRenderingSystem()
      : super(Aspect.empty()
          ..allOf([Position, Renderable, Orientation])
          ..exclude([Border, Nebula]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    renderableMapper = Mapper<Renderable>(world);
    orientationMapper = Mapper<Orientation>(world);
    tagManager = world.getManager<TagManager>();
    cameraManager = world.getManager<CameraManager>();
  }

  @override
  void processEntities(Iterable<int> entities) {
    final positionMapper = this.positionMapper;
    final renderableMapper = this.renderableMapper;
    final orientationMapper = this.orientationMapper;
    for (final entity in entities) {
      processEntity(entity, positionMapper[entity], renderableMapper[entity],
          orientationMapper[entity]);
    }
  }

  void processEntity(int entity, Position position, Renderable renderable,
      Orientation orientation);
}

abstract class _$CachedSpriteRenderingSystem extends EntitySystem {
  late final Mapper<Position> positionMapper;
  late final Mapper<Renderable> renderableMapper;
  late final LevelManager levelManager;
  late final CameraManager cameraManager;
  late final TagManager tagManager;
  _$CachedSpriteRenderingSystem(Aspect aspect)
      : super(aspect..allOf([Position, Renderable]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    renderableMapper = Mapper<Renderable>(world);
    levelManager = world.getManager<LevelManager>();
    cameraManager = world.getManager<CameraManager>();
    tagManager = world.getManager<TagManager>();
  }
}

abstract class _$BorderRenderingSystem extends CachedSpriteRenderingSystem {
  late final Mapper<Border> borderMapper;
  _$BorderRenderingSystem(CanvasRenderingContext2D ctx, SpriteSheet sheet)
      : super(ctx, sheet, Aspect.empty()..allOf([Border]));
  @override
  void initialize() {
    super.initialize();
    borderMapper = Mapper<Border>(world);
  }
}

abstract class _$NebulaRenderingSystem extends CachedSpriteRenderingSystem {
  late final Mapper<Nebula> nebulaMapper;
  _$NebulaRenderingSystem(CanvasRenderingContext2D ctx, SpriteSheet sheet)
      : super(ctx, sheet, Aspect.empty()..allOf([Nebula]));
  @override
  void initialize() {
    super.initialize();
    nebulaMapper = Mapper<Nebula>(world);
  }
}
