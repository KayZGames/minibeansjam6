import 'package:aspen/aspen.dart';
import 'package:aspen_assets/aspen_assets.dart';

part 'assets.g.dart';

@Asset('asset:minibeansjam6/lib/assets/level')
const levels = DirAsset<TextAsset, Levels>(_levels$asset);

@Asset('asset:minibeansjam6/lib/assets/sfx')
const sfx = DirAsset<BinaryAsset, Sfx>(_sfx$asset);