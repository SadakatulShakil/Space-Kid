import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/planet_model.dart';

class PdfService {
  Future<Uint8List> generatePlanetPdf(CelestialBody planet) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(planet.name,
                style: pw.TextStyle(fontSize: 40)
            ),
          ),
          pw.Paragraph(text: planet.description),
          pw.Header(
            level: 1,
            child: pw.Text('Physical Characteristics'),
          ),
          pw.Table.fromTextArray(
            context: context,
            data: <List<String>>[
              ['Property', 'Value'],
              ['Diameter', '${planet.diameter} km'],
              ['Mass', '${planet.mass} kg'],
              ['Distance from Sun', '${planet.distanceFromSun} million km'],
              ['Orbital Period', '${planet.orbitalPeriod} Earth days'],
              ['Rotation Period', '${planet.rotationPeriod} Earth days'],
            ],
          ),
          pw.Header(
            level: 1,
            child: pw.Text('Interesting Facts'),
          ),
          // pw.BulletedList(
          //   items: planet.facts.map((fact) => pw.Text(fact)).toList(),
          // ),
        ],
      ),
    );

    return pdf.save();
  }
}