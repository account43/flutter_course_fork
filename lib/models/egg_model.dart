enum EggSelection {
  soft,
  medium,
  hard,
}

class EggModel {
  final String hardnessTitle;
  final double time;

  EggModel({
    required this.hardnessTitle,
    required this.time,
  });
}
