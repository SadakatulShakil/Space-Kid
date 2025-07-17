import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planet_plus/screens/main/widgets/player_widget.dart';
import 'package:provider/provider.dart';

import '../../models/planet_model.dart';
import '../../providers/planet_provider.dart';
import '../../providers/voice_player_provider.dart';
import '../../services/pdf_service.dart';

class PlanetDetailScreen extends StatefulWidget {
  const PlanetDetailScreen({super.key});

  @override
  State<PlanetDetailScreen> createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen> {
  late FlutterTts _flutterTts;
  bool _isSheetVisible = false;

  void showVoicePlayerSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const Padding(
        padding: EdgeInsets.all(16),
        child: VoicePlayerWidget(),
      ),
    ).whenComplete(() {
      setState(() {
        _isSheetVisible = false;
      });
    });

    setState(() {
      _isSheetVisible = true;
    });
  }


  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    _flutterTts.stop(); // Stop speaking when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanetProvider>(
      builder: (context, provider, child) {
        final planet = provider.selectedPlanet;
        if (planet == null) return const SizedBox.shrink();

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.transparent, // Initially transparent
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
                              planet.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          background: Container(), // background is already in the Hero
                        ),
                      ],
                    );
                  },
                ),
                actions: [
                  Consumer<VoicePlayerController>(
                    builder: (context, controller, child) {
                      final planet = Provider.of<PlanetProvider>(context, listen: false).selectedPlanet;
                      if (planet == null) return const SizedBox.shrink();

                      return Row(
                        children: [
                          // Play/Pause button
                          if (!controller.isPlaying)
                          IconButton(
                            icon: Icon(Icons.volume_up),
                            onPressed: () {
                              if (controller.isPlaying) {
                                controller.pause();
                              } else {
                                controller.setText(
                                  'Planet name: ${planet.name}. ${planet.description}. '
                                      'Diameter: ${planet.diameter} kilometers. '
                                      'Mass: ${planet.mass.toStringAsExponential(2)} kilograms. '
                                      'Distance from Sun: ${planet.distanceFromSun} million kilometers. '
                                      'Orbital Period: ${planet.orbitalPeriod} Earth days. '
                                      'Rotation Period: ${planet.rotationPeriod} Earth days. '
                                      'Interesting facts: ${planet.facts.join(". ")}.',
                                );
                                controller.play();
                              }
                            },
                          ),

                          // If playing, show a separate button to toggle bottom sheet
                          if (controller.isPlaying)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  if (_isSheetVisible) {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _isSheetVisible = false;
                                    });
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
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        planet.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Physical Characteristics',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCharacteristicsTable(planet),
                      const SizedBox(height: 24),
                      const Text(
                        'Interesting Facts',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFactsList(planet),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
            _buildTableRow('Diameter', '${planet.diameter} km'),
            _buildTableRow('Mass', '${planet.mass.toStringAsExponential(2)} kg'),
            _buildTableRow('Distance from Sun', '${planet.distanceFromSun} million km'),
            _buildTableRow('Orbital Period', '${planet.orbitalPeriod} Earth days'),
            _buildTableRow('Rotation Period', '${planet.rotationPeriod} Earth days'),
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
                Expanded(child: Text(fact)),
              ],
            ),
          ))
              .toList(),
        ),
      ),
    );
  }

  Future<void> _downloadPdf(BuildContext context, CelestialBody planet) async {
    try {
      final pdfService = PdfService();
      final pdfBytes = await pdfService.generatePlanetPdf(planet);

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${planet.name.toLowerCase()}_info.pdf');
      await file.writeAsBytes(pdfBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate PDF')),
      );
    }
  }
}