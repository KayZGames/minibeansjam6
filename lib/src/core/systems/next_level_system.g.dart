// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_level_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$NextLevelSystem extends EntitySystem {
  late final Mapper<Controller> controllerMapper;
  late final LevelManager levelManager;
  late final GameStateManager gameStateManager;
  _$NextLevelSystem() : super(Aspect.empty()..allOf([Controller]));
  @override
  void initialize() {
    super.initialize();
    controllerMapper = Mapper<Controller>(world);
    levelManager = world.getManager<LevelManager>();
    gameStateManager = world.getManager<GameStateManager>();
  }

  @override
  void processEntities(Iterable<int> entities) {
    final controllerMapper = this.controllerMapper;
    for (final entity in entities) {
      processEntity(entity, controllerMapper[entity]);
    }
  }

  void processEntity(int entity, Controller controller);
}
