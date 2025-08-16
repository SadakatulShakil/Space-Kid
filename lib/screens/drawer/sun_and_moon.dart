import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

import '../../providers/voice_player_provider.dart';
import '../main/widgets/player_widget.dart';

class SunAndMoonScreen extends StatefulWidget {
  const SunAndMoonScreen({super.key});

  @override
  State<SunAndMoonScreen> createState() => _SunAndMoonScreenState();
}

class _SunAndMoonScreenState extends State<SunAndMoonScreen> {
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
        title: Text('sun&moon'.tr),
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
                    'sun_title'.tr + '. ' +
                        'sun_intro'.tr + '. ' +
                        'sun_structure_title'.tr + '. ' +
                        'core'.tr + '. ' +
                        'radiative'.tr + '. ' +
                        'convective'.tr + '. ' +
                        'surface'.tr + '. ' +
                        'features_title'.tr + '. ' +
                        'sun_size'.tr + '. ' +
                        'sun_mass'.tr + '. ' +
                        'temp'.tr + '. ' +
                        'importance_title'.tr + '. ' +
                        'life'.tr + '. ' +
                        'climate'.tr + '. ' +
                        'solar_energy'.tr + '. ' +
                        'sun_rotation_title'.tr + '. ' +
                        'rotation_text'.tr + '. ' +
                        'solar_activity_title'.tr + '. ' +
                        'sunspots'.tr + '. ' +
                        'flares'.tr + '. ' +
                        'wind'.tr + '. ' +
                        'moon_title'.tr + '. ' +
                        'moon_intro'.tr +'..' +
                        'moon_structure_title'.tr +'..' +
                        'crust'.tr +'..' +
                        'mantle'.tr +'..' +
                        'moon_core'.tr +'..' +
                        'moon_features_title'.tr +'..' +
                        'moon_size'.tr +'..' +
                        'distance'.tr +'..' +
                        'gravity'.tr +'..' +
                        'surface_title'.tr +'..' +
                        'craters'.tr +'..' +
                        'maria'.tr +'..' +
                        'mountains'.tr +'..' +
                        'phases_title'.tr +'..' +
                        'phases_text'.tr +'..' +
                        'moon_rotation_title'.tr +'..' +
                        'moon_rotation_text'.tr +'..' +
                        'influence_title'.tr +'..' +
                        'tides'.tr +'..' +
                        'stability'.tr +'..' +
                        'night_light'.tr +'..' +
                        'moon_age_title'.tr +'..' +
                        'moon_age_text'.tr
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
            //Sun part
            Image.asset(
              'assets/images/sun_data.jpg',
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
                    'sun_title'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _sectionParagraph('sun_intro'),

                  _sectionTitle('sun_structure_title', context),
                  _sectionParagraph('core'),
                  _sectionParagraph('radiative'),
                  _sectionParagraph('convective'),
                  _sectionParagraph('surface'),

                  _sectionTitle('features_title', context),
                  _sectionParagraph('sun_size'),
                  _sectionParagraph('sun_mass'),
                  _sectionParagraph('temp'),

                  _sectionTitle('importance_title', context),
                  _sectionParagraph('life'),
                  _sectionParagraph('climate'),
                  _sectionParagraph('solar_energy'),

                  _sectionTitle('sun_rotation_title', context),
                  _sectionParagraph('rotation_text'),

                  _sectionTitle('solar_activity_title', context),
                  _sectionParagraph('sunspots'),
                  _sectionParagraph('flares'),
                  _sectionParagraph('wind'),

                  _sectionTitle('sun_age_title', context),
                  _sectionParagraph('sun_age_text'),

                  const SizedBox(height: 16),
                  Text(
                    'sun_resources'.tr,
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

            //Moon part
            Image.asset(
              'assets/images/moon.jpg',
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
                    'moon_title'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _sectionParagraph('moon_intro'),

                  _sectionTitle('moon_structure_title', context),
                  _sectionParagraph('crust'),
                  _sectionParagraph('mantle'),
                  _sectionParagraph('moon_core'),

                  _sectionTitle('moon_features_title', context),
                  _sectionParagraph('moon_size'),
                  _sectionParagraph('distance'),
                  _sectionParagraph('gravity'),

                  _sectionTitle('surface_title', context),
                  _sectionParagraph('craters'),
                  _sectionParagraph('maria'),
                  _sectionParagraph('mountains'),

                  _sectionTitle('phases_title', context),
                  _sectionParagraph('phases_text'),

                  _sectionTitle('moon_rotation_title', context),
                  _sectionParagraph('moon_rotation_text'),

                  _sectionTitle('influence_title', context),
                  _sectionParagraph('tides'),
                  _sectionParagraph('stability'),
                  _sectionParagraph('night_light'),

                  _sectionTitle('moon_age_title', context),
                  _sectionParagraph('moon_age_text'),

                  const SizedBox(height: 16),
                  Text(
                    'moon_resources'.tr,
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