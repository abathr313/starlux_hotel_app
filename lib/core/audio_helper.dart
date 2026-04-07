import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AudioHelper {
  static final AudioPlayer _player = AudioPlayer();
  static final FlutterTts _tts = FlutterTts();

  static Future<void> playClick() async {
    // Assuming assets/audio/click.mp3 exists
    // await _player.play(AssetSource('audio/click.mp3'));
  }

  static Future<void> playSuccess() async {
    // await _player.play(AssetSource('audio/success.mp3'));
  }

  static Future<void> playAlert() async {
    // await _player.play(AssetSource('audio/alert.mp3'));
  }

  static Future<void> speak(String text, String lang) async {
    await _tts.setLanguage(lang == 'ar' ? 'ar-SA' : 'en-US');
    await _tts.setPitch(1.0);
    await _tts.speak(text);
  }
}
