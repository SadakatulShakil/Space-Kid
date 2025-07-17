import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/voice_player_provider.dart';

class VoicePlayerWidget extends StatelessWidget {
  const VoicePlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VoicePlayerController>(
      builder: (context, controller, child) {
        return Row(
          children: [
            IconButton(
              icon: Icon(controller.isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                controller.isPlaying ? controller.pause() : controller.play();
              },
            ),
            Expanded(
              child: Slider(
                value: controller.progress,
                onChanged: (value) => controller.seek(value),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: controller.stop,
            ),
          ],
        );
      },
    );
  }
}
