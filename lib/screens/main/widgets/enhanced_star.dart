import 'package:flutter/material.dart';

class StarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;

    return Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/galaxy5.gif'), // Your GIF file
            fit: BoxFit.cover, // Make the GIF cover the entire screen responsively
          ),
        ),
    );
  }
}
