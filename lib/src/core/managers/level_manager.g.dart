// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_manager.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$LevelManager extends Manager {
  late final Mapper<CanBeRolledOn> canBeRolledOnMapper;
  late final Mapper<CanRoll> canRollMapper;
  late final Mapper<CanFall> canFallMapper;
  late final Mapper<CanBePushed> canBePushedMapper;
  late final Mapper<Bean> beanMapper;
  late final Mapper<Renderable> renderableMapper;
  late final TagManager tagManager;
  late final AudioManager audioManager;
  @override
  void initialize() {
    super.initialize();
    canBeRolledOnMapper = Mapper<CanBeRolledOn>(world);
    canRollMapper = Mapper<CanRoll>(world);
    canFallMapper = Mapper<CanFall>(world);
    canBePushedMapper = Mapper<CanBePushed>(world);
    beanMapper = Mapper<Bean>(world);
    renderableMapper = Mapper<Renderable>(world);
    tagManager = world.getManager<TagManager>();
    audioManager = world.getManager<AudioManager>();
  }
}
