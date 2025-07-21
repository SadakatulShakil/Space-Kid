import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class VoicePlayerController extends GetxController {
  final FlutterTts _tts = FlutterTts();

  final text = ''.obs;
  final isPlaying = false.obs;
  final progress = 0.0.obs;

  int _wordIndex = 0;
  List<String> _words = [];

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  Duration _estimatedDuration = Duration.zero;
  Duration _alreadyPlayed = Duration.zero;
  DateTime? _startTime;
  Timer? _progressTimer;

  Future<void> _initTts() async {
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);

    _tts.setStartHandler(() => _updatePlaying(true));

    _tts.setCompletionHandler(() {
      _wordIndex = _words.length;
      _updatePlaying(false);
      _onPlaybackComplete();
      print('play stopped');
      updateProgress();
    });
    _tts.setCancelHandler(() => _updatePlaying(false));
    _tts.setPauseHandler(() => _updatePlaying(false));

    _tts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      int count = 0;
      for (int i = 0; i < this.text.value.length && i < startOffset; i++) {
        if (this.text.value[i] == ' ') count++;
      }

      int currentIndex = count.clamp(0, _words.length - 1);
      if (currentIndex != _wordIndex) {
        _wordIndex = currentIndex;
        updateProgress();
      }
    });
  }

  void _updatePlaying(bool playing) {
    isPlaying.value = playing;
  }

  void setText(String newText) async {
    text.value = newText;
    _words = newText.split(' ');
    _wordIndex = 0;
    progress.value = 0;

    await _detectAndSetLanguage(newText);
  }

  Future<void> _detectAndSetLanguage(String input) async {
    final isBangla = RegExp(r'[\u0980-\u09FF]').hasMatch(input);
    if (isBangla) {
      await _tts.setLanguage('bn-BD');
      await _setVoiceByLocale('bn-BD');
    } else {
      await _tts.setLanguage('en-US');
      await _setVoiceByLocale('en-US');
    }
  }

  Future<void> _setVoiceByLocale(String locale) async {
    List voices = await _tts.getVoices;
    for (var voice in voices) {
      final voiceMap = Map<String, String>.from(voice);
      if (voiceMap['locale'] == locale) {
        await _tts.setVoice(voiceMap);
        break;
      }
    }
  }

  Future<void> play() async {
    if (_wordIndex >= _words.length) return;

    final remainingText = _words.sublist(_wordIndex).join(' ');
    isPlaying.value = true;

    // Estimate duration based on remaining words
    final estimatedMillis = remainingText.split(' ').length * 600;
    _estimatedDuration = Duration(milliseconds: estimatedMillis);
    _startTime = DateTime.now();

    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(Duration(milliseconds: 500), (_) {
      if (_startTime == null) return;

      final playedNow = DateTime.now().difference(_startTime!);
      final totalPlayed = _alreadyPlayed + playedNow;
      double newProgress = totalPlayed.inMilliseconds / _estimatedDuration.inMilliseconds;

      progress.value = newProgress.clamp(0.0, 1.0);
    });

    await _tts.speak(remainingText);
  }

  Future<void> pause() async {
    await _tts.pause();
    isPlaying.value = false;

    if (_startTime != null) {
      _alreadyPlayed += DateTime.now().difference(_startTime!);
    }

    _progressTimer?.cancel();
  }

  Future<void> stop() async {
    await _tts.stop();
    isPlaying.value = false;

    _progressTimer?.cancel();
    _wordIndex = 0;
    progress.value = 0.0;

    _alreadyPlayed = Duration.zero;
    _startTime = null;
  }

  void seek(double value) {
    _wordIndex = (value * _words.length).floor().clamp(0, _words.length - 1);
    progress.value = value;

    _alreadyPlayed = Duration(
      milliseconds: (_estimatedDuration.inMilliseconds * value).floor(),
    );
    _startTime = DateTime.now();

    stop(); // Ensure old voice is cancelled
    Future.delayed(Duration(milliseconds: 200), () {
      play(); // Resume from new position
    });
  }


  void updateProgress() {
    if (_words.isNotEmpty) {
      progress.value = _wordIndex / _words.length;
    }
  }

  void _onPlaybackComplete() {
    print('play stopped');
    isPlaying.value = false;
    _progressTimer?.cancel();
    _alreadyPlayed = Duration.zero;
    _startTime = null;
    _wordIndex = _words.length;
    progress.value = 1.0;
  }

}