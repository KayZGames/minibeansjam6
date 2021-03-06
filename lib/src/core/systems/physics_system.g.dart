// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physics_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$PhysicsSystem extends EntitySystem {
  Mapper<Position> positionMapper;
  _$PhysicsSystem(Aspect aspect) : super(aspect..allOf([Position]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
  }
}

abstract class _$CanFallPhysicsSystem extends PhysicsSystem {
  Mapper<CanFall> canFallMapper;
  Mapper<CanBeKilledByFallingObject> canBeKilledByFallingObjectMapper;
  Mapper<Controller> controllerMapper;
  LevelManager levelManager;
  AudioManager audioManager;
  _$CanFallPhysicsSystem() : super(Aspect.empty()..allOf([CanFall]));
  @override
  void initialize() {
    super.initialize();
    canFallMapper = Mapper<CanFall>(world);
    canBeKilledByFallingObjectMapper =
        Mapper<CanBeKilledByFallingObject>(world);
    controllerMapper = Mapper<Controller>(world);
    levelManager = world.getManager<LevelManager>();
    audioManager = world.getManager<AudioManager>();
  }
}

abstract class _$CanRollPhysicsSystem extends PhysicsSystem {
  Mapper<CanRoll> canRollMapper;
  Mapper<Orientation> orientationMapper;
  LevelManager levelManager;
  _$CanRollPhysicsSystem()
      : super(Aspect.empty()..allOf([CanRoll, Orientation]));
  @override
  void initialize() {
    super.initialize();
    canRollMapper = Mapper<CanRoll>(world);
    orientationMapper = Mapper<Orientation>(world);
    levelManager = world.getManager<LevelManager>();
  }
}

abstract class _$PushSystem extends EntityProcessingSystem {
  Mapper<Position> positionMapper;
  Mapper<CanBePushed> canBePushedMapper;
  _$PushSystem() : super(Aspect.empty()..allOf([Position, CanBePushed]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    canBePushedMapper = Mapper<CanBePushed>(world);
  }
}
