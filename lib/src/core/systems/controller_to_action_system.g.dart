// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_to_action_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$ControllerToActionSystem extends EntitySystem {
  late final Mapper<Controller> controllerMapper;
  late final Mapper<Position> positionMapper;
  late final LevelManager levelManager;
  late final GameStateManager gameStateManager;
  _$ControllerToActionSystem()
      : super(Aspect.empty()..allOf([Controller, Position]));
  @override
  void initialize() {
    super.initialize();
    controllerMapper = Mapper<Controller>(world);
    positionMapper = Mapper<Position>(world);
    levelManager = world.getManager<LevelManager>();
    gameStateManager = world.getManager<GameStateManager>();
  }

  @override
  void processEntities(Iterable<int> entities) {
    final controllerMapper = this.controllerMapper;
    final positionMapper = this.positionMapper;
    for (final entity in entities) {
      processEntity(entity, controllerMapper[entity], positionMapper[entity]);
    }
  }

  void processEntity(int entity, Controller controller, Position position);
}
