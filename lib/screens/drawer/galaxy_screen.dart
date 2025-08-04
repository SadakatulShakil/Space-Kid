import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../providers/voice_player_provider.dart';
import '../main/widgets/player_widget.dart';

class GalaxyScreen extends StatefulWidget {
  const GalaxyScreen({super.key});

  @override
  State<GalaxyScreen> createState() => _GalaxyScreenState();
}

class _GalaxyScreenState extends State<GalaxyScreen> {
  late FlutterTts _flutterTts;
  final _isSheetVisible = false.obs; // Changed to obs
  final VoicePlayerController _voiceController = Get.put(VoicePlayerController());


  void showVoicePlayerSheet() {
    Get.bottomSheet(
      const Padding(
        padding: EdgeInsets.all(16),
        child: VoicePlayerWidget(),
      ),
    ).whenComplete(() {
      _isSheetVisible.value = false;
    });

    _isSheetVisible.value = true;
  }

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    _voiceController.stop();
    _flutterTts.stop();
    super.dispose();
  }

  Widget _sectionTitle(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text.tr,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _sectionParagraph(String text, {double bottom = 10}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Text(
        text.tr,
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('our_galaxy'.tr),
        actions: [
  Obx(() {
    return _voiceController.isPlaying.value
      ? Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              if (_isSheetVisible.value) {
                Get.back();
                _isSheetVisible.value = false;
              } else {
                showVoicePlayerSheet();
              }
            },
            child: SizedBox(
              width: 45,
              height: 45,
              child: Lottie.asset(
                'assets/json/voice.json',
                repeat: true,
                animate: true,
              ),
            ),
          ),
        )
      : IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            if (_voiceController.isPlaying.value) {
              _voiceController.pause();
            } else {
              _voiceController.setText(
                'title'.tr + '. ' +
                    'intro'.tr + '. ' +
                    'structure_title'.tr + '. ' +
                    'spiral'.tr + '. ' +
                    'size'.tr + '. ' +
                    'center'.tr + '. ' +
                    'location_title'.tr + '. ' +
                    'location_text'.tr + '. ' +
                    'solar_system_title'.tr + '. ' +
                    'solar_system_text'.tr + '. ' +
                    'rotation_title'.tr + '. ' +
                    'galactic_year'.tr + '. ' +
                    'galaxy_speed'.tr + '. ' +
                    'components_title'.tr + '. ' +
                    'stars_planets'.tr + '. ' +
                    'nebulae'.tr + '. ' +
                    'dark_matter'.tr + '. ' +
                    'age_title'.tr + '. ' +
                    'age_text'.tr + '. ' +
                    'satellites_title'.tr + '. ' +
                    'satellites_text'.tr,
              );
              _voiceController.play();
            }
          },
        );
})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/gif/galaxy.gif',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'title'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _sectionParagraph('intro'),

                  _sectionTitle('structure_title', context),
                  _sectionParagraph('spiral'),
                  _sectionParagraph('size'),
                  _sectionParagraph('center'),

                  _sectionTitle('location_title', context),
                  _sectionParagraph('location_text'),

                  _sectionTitle('solar_system_title', context),
                  _sectionParagraph('solar_system_text'),

                  _sectionTitle('rotation_title', context),
                  _sectionParagraph('galactic_year'),
                  _sectionParagraph('galaxy_speed'),

                  _sectionTitle('components_title', context),
                  _sectionParagraph('stars_planets'),
                  _sectionParagraph('nebulae'),
                  _sectionParagraph('dark_matter'),

                  _sectionTitle('age_title', context),
                  _sectionParagraph('age_text'),

                  _sectionTitle('satellites_title', context),
                  _sectionParagraph('satellites_text'),

                  const SizedBox(height: 16),
                  Text(
                    'resources'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'https://en.wikipedia.org/wiki/Milky_Way',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
