import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';

import 'app_config.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/galaxy_header.png',),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppConstants.appName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Version ${AppConstants.appVersion}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.language,
              title: 'Galaxy',
              onTap: () => Get.toNamed('/galaxy'),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.stars,
              title: 'Sun & Moon',
              onTap: () => Get.toNamed('/sun&moon'),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.rocket,
              title: 'Space Stations',
              onTap: () => Get.toNamed('/space-stations'),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.history,
              title: 'Rocket History',
              onTap: () => Get.toNamed('/rocket-history'),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.science,
              title: 'About NASA',
              onTap: () => Get.toNamed('/about-nasa'),
            ),
            const Divider(color: Colors.white24),
            _buildDrawerItem(
              context: context,
              icon: Icons.info,
              title: 'About',
              onTap: () => Get.toNamed('/about'),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.share,
              title: 'Share App',
              onTap: () => _shareApp(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70),
      ),
      onTap: onTap,
    );
  }

  void _shareApp(BuildContext context) {
    // Implement share functionality
    Share.share(
      'Explore the Solar System with ${AppConstants.appName}!\n'
          'Download now: [App Store Link]',
    );
  }
}
