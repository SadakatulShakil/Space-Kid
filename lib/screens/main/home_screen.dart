import 'package:flutter/material.dart';
import 'package:planet_plus/screens/main/soler_system_view.dart';


import '../../config/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          const SolarSystemView(),
          Positioned(
            top: 40,
            left: 300,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.rocket_launch_outlined, color: Colors.white, size: 35,),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
