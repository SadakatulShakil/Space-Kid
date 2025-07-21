import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/voice_player_provider.dart';

class VoicePlayerWidget extends StatelessWidget {
  const VoicePlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final VoicePlayerController controller = Get.find();

    return Obx(() => Row(
      children: [
        IconButton(
          icon: Icon(controller.isPlaying.value ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (controller.isPlaying.value) {
              controller.pause();
            } else {
              controller.play();
            }
          },
        ),
        Expanded(
          child: Slider(
            value: controller.progress.value,
            onChanged: controller.seek,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          onPressed: controller.stop,
        ),
      ],
    ));
  }
}