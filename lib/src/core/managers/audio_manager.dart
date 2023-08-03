import 'dart:typed_data';
import 'dart:web_audio';

import 'package:dartemis/dartemis.dart';

import '../../assets.dart';

part 'audio_manager.g.dart';

@Generate(Manager)
class AudioManager extends _$AudioManager {
  final Map<Sfx, AudioBuffer> _cachedSfx = {};
  AudioContext? _ctx;

  void playAudio(Sfx sfx) {
    final ctx = _ctx;
    if (ctx != null) {
      ctx.createBufferSource()
        ..buffer = _cachedSfx[sfx]
        ..connectNode(ctx.destination!)
        ..start(0);
    }
  }

  void resume() {
    if (AudioContext.supported) {
      final ctx = _ctx = AudioContext();
      for (final sfxItem in Sfx.values) {
        final sound = sfx[sfxItem].decode().toList();
        ctx.decodeAudioData(Uint8List.fromList(sound).buffer, (buffer) {
          _cachedSfx[sfxItem] = buffer;
        }, print);
      }
    }
  }
}
