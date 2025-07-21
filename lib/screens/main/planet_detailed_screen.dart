import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planet_plus/screens/main/widgets/player_widget.dart';
import 'package:planet_plus/models/planet_model.dart';
import 'package:planet_plus/services/pdf_service.dart';

import '../../providers/planet_provider.dart';
import '../../providers/voice_player_provider.dart';

class PlanetDetailScreen extends StatefulWidget {
  const PlanetDetailScreen({super.key});

  @override
  State<PlanetDetailScreen> createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen> {
  late FlutterTts _flutterTts;
  final _isSheetVisible = false.obs; // Changed to obs
  final PlanetController _planetController = Get.find();
  final VoicePlayerController _voiceController = Get.find();

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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final planet = _planetController.selectedPlanet;
      if (planet == null) return const SizedBox.shrink();

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final top = constraints.biggest.height;
                  final bool isCollapsed = top <= kToolbarHeight + 20;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: planet.id,
                        child: Image.asset(
                          planet.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (isCollapsed)
                        Container(
                          color: Colors.black,
                        ),
                      FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          opacity: isCollapsed ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            planet.name.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        background: Container(),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                Obx(() {
                  return Row(
                    children: [
                      _voiceController.isPlaying.value
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
                            var character1 = '${planet.characteristics['type']}';
                            var character2 = '${planet.characteristics['atmosphere']}';
                            var character3 = '${planet.characteristics['surface']}';
                            var character4 = '${planet.characteristics['magnetic field']}';
                            var character5 = '${planet.characteristics['rings']}';
                            _voiceController.setText(
                                'planet_name'.tr + '${planet.name.tr}. ${planet.description.tr}. '
                                    + 'physical_characteristics'.tr
                                    + 'planet_type'.tr + '${character1.tr}. '
                                    + 'planet_atmosphere'.tr + '${character2.tr}. '
                                    + 'planet_surface'.tr + '${character3.tr}. '
                                    + 'planet_magnetic_field'.tr + '${character4.tr}. '
                                    + 'planet_rings'.tr + '${character5.tr}. '
                                    + 'interesting_facts'.tr + '${planet.facts.map((fact) => fact.tr).join(". ")}.'
                                    + 'other_info'.tr
                                    + 'diameter'.tr + '${planet.diameter} kilometers. '
                                    + 'mass'.tr + '${planet.mass.toStringAsExponential(2)} kilograms. '
                                    + 'distance_from_sun'.tr + '${planet.distanceFromSun} million kilometers. '
                                    + 'orbital_period'.tr + '${planet.orbitalPeriod} Earth days. '
                                    + 'rotation_period'.tr + '${planet.rotationPeriod} Earth days. '
                            );
                            _voiceController.play();
                          }
                        },
                      ),
                    ],
                  );
                }),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planet.description.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    ///Physical Characteristics
                    const SizedBox(height: 24),
                    Text(
                      'physical_characteristics'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCharacteristicsTable(planet),
                    const SizedBox(height: 24),
                    /// Interesting Facts
                    Text(
                      'interesting_facts'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFactsList(planet),
                    ///Other Information
                    const SizedBox(height: 24),
                    Text(
                      'other_info'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildOtherInfoTable(planet),
                    const SizedBox(height: 24),

                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCharacteristicsTable(CelestialBody planet) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
          },
          children: [
            _buildTableRow('planet_type'.tr, '${planet.characteristics['type']}'.tr),
            _buildTableRow('planet_atmosphere'.tr, '${planet.characteristics['atmosphere']}'.tr),
            _buildTableRow('planet_surface'.tr, '${planet.characteristics['surface']}'.tr),
            _buildTableRow('planet_magnetic_field'.tr, '${planet.characteristics['magnetic field']}'.tr),
            _buildTableRow('planet_rings'.tr, '${planet.characteristics['rings']}'.tr),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildOtherInfoTable(CelestialBody planet) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
          },
          children: [
            _buildOtherInfoTableRow('diameter'.tr, '${planet.diameter} km'),
            _buildOtherInfoTableRow('mass'.tr, '${planet.mass.toStringAsExponential(2)} kg'),
            _buildOtherInfoTableRow('distance_from_sun'.tr, '${planet.distanceFromSun} million km'),
            _buildOtherInfoTableRow('orbital_period'.tr, '${planet.orbitalPeriod} Earth days'),
            _buildOtherInfoTableRow('rotation_period'.tr, '${planet.rotationPeriod} Earth days'),
          ],
        ),
      ),
    );
  }

  TableRow _buildOtherInfoTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildFactsList(CelestialBody planet) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: planet.facts
              .map((fact) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 18)),
                Expanded(child: Text(fact.tr)),
              ],
            ),
          ))
              .toList(),
        ),
      ),
    );
  }

  Future<void> _downloadPdf(CelestialBody planet) async {
    try {
      final pdfService = PdfService();
      final pdfBytes = await pdfService.generatePlanetPdf(planet);

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${planet.name.toLowerCase()}_info.pdf');
      await file.writeAsBytes(pdfBytes);

      Get.snackbar('Success', 'PDF saved to ${file.path}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate PDF');
    }
  }
}