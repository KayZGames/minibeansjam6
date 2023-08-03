// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$ControllerSystem extends GenericInputHandlingSystem {
  late final Mapper<Controller> controllerMapper;
  late final GameStateManager gameStateManager;
  _$ControllerSystem(List<Element> ignoreInputFromElements)
      : super(Aspect.empty()..allOf([Controller]), ignoreInputFromElements);
  @override
  void initialize() {
    super.initialize();
    controllerMapper = Mapper<Controller>(world);
    gameStateManager = world.getManager<GameStateManager>();
  }
}
