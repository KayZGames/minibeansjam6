// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_manager.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$LevelManager extends Manager {
  Mapper<CanBeRolledOn> canBeRolledOnMapper;
  Mapper<CanRoll> canRollMapper;
  Mapper<CanFall> canFallMapper;
  Mapper<CanBePushed> canBePushedMapper;
  Mapper<Bean> beanMapper;
  Mapper<Renderable> renderableMapper;
  TagManager tagManager;
  AudioManager audioManager;
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
