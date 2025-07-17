import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoicePlayerController extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();

  String _text = '';
  bool isPlaying = false;
  double progress = 0.0;
  int _wordIndex = 0;
  List<String> _words = [];

  VoicePlayerController() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);

    // ... your voice selection code ...

    _tts.setStartHandler(() => _updatePlaying(true));
    _tts.setCompletionHandler(() {
      _wordIndex = _words.length;
      _updatePlaying(false);
      updateProgress();
    });
    _tts.setCancelHandler(() => _updatePlaying(false));
    _tts.setPauseHandler(() => _updatePlaying(false));

    _tts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      int count = 0;
      for (int i = 0; i < _text.length && i < startOffset; i++) {
        if (_text[i] == ' ') count++;
      }
      int currentIndex = count;

      if (currentIndex != _wordIndex && currentIndex < _words.length) {
        _wordIndex = currentIndex;
        updateProgress();
      }
    });
  }

  void _updatePlaying(bool playing) {
    isPlaying = playing;
    notifyListeners();
  }

  void setText(String text) {
    _text = text;
    _words = text.split(' ');
    _wordIndex = 0;
    progress = 0;
    notifyListeners();
  }

  Future<void> play() async {
    if (_wordIndex >= _words.length) return;

    isPlaying = true;
    final remainingText = _words.sublist(_wordIndex).join(' ');
    notifyListeners();

    await _tts.speak(remainingText);
  }

  Future<void> pause() async {
    await _tts.pause();
    isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
    await _tts.stop();
    _wordIndex = 0;
    progress = 0;
    isPlaying = false;
    notifyListeners();
  }

  void seek(double value) {
    final newIndex = (value * _words.length).floor();
    _wordIndex = newIndex.clamp(0, _words.length - 1);
    progress = value;
    play(); // Resume from new point
  }

  void updateProgress() {
    if (_words.isNotEmpty) {
      progress = _wordIndex / _words.length;
      notifyListeners();
    }
  }
}