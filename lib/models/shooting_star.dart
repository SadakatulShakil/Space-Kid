import 'dart:ui';

class ShootingStar {
  final Offset start;
  final Offset end;
  final double progress;

  ShootingStar({
    required this.start,
    required this.end,
    required this.progress,
  });

  ShootingStar copyWith({double? progress}) {
    return ShootingStar(
      start: start,
      end: end,
      progress: progress ?? this.progress,
    );
  }
}