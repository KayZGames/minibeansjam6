// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_to_action_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$ControllerToActionSystem extends EntityProcessingSystem {
  Mapper<Controller> controllerMapper;
  Mapper<Position> positionMapper;
  LevelManager levelManager;
  GameStateManager gameStateManager;
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
}
