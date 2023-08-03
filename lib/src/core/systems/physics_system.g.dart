// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physics_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$PhysicsSystem extends EntitySystem {
  late final Mapper<Position> positionMapper;
  late final LevelManager levelManager;
  _$PhysicsSystem(Aspect aspect) : super(aspect..allOf([Position]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    levelManager = world.getManager<LevelManager>();
  }
}

abstract class _$CanFallPhysicsSystem extends PhysicsSystem {
  late final Mapper<CanFall> canFallMapper;
  late final Mapper<CanBeKilledByFallingObject>
      canBeKilledByFallingObjectMapper;
  late final Mapper<Controller> controllerMapper;
  late final AudioManager audioManager;
  _$CanFallPhysicsSystem() : super(Aspect.empty()..allOf([CanFall]));
  @override
  void initialize() {
    super.initialize();
    canFallMapper = Mapper<CanFall>(world);
    canBeKilledByFallingObjectMapper =
        Mapper<CanBeKilledByFallingObject>(world);
    controllerMapper = Mapper<Controller>(world);
    audioManager = world.getManager<AudioManager>();
  }
}

abstract class _$CanRollPhysicsSystem extends PhysicsSystem {
  late final Mapper<CanRoll> canRollMapper;
  late final Mapper<Orientation> orientationMapper;
  _$CanRollPhysicsSystem()
      : super(Aspect.empty()..allOf([CanRoll, Orientation]));
  @override
  void initialize() {
    super.initialize();
    canRollMapper = Mapper<CanRoll>(world);
    orientationMapper = Mapper<Orientation>(world);
  }
}

abstract class _$PushSystem extends EntitySystem {
  late final Mapper<Position> positionMapper;
  late final Mapper<CanBePushed> canBePushedMapper;
  _$PushSystem() : super(Aspect.empty()..allOf([Position, CanBePushed]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    canBePushedMapper = Mapper<CanBePushed>(world);
  }

  @override
  void processEntities(Iterable<int> entities) {
    final positionMapper = this.positionMapper;
    final canBePushedMapper = this.canBePushedMapper;
    for (final entity in entities) {
      processEntity(entity, positionMapper[entity], canBePushedMapper[entity]);
    }
  }

  void processEntity(int entity, Position position, CanBePushed canBePushed);
}
