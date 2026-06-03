import 'package:equatable/equatable.dart';

class SolarInstallation extends Equatable {
  final String name;
  final String location;
  final double expectedKwh;
  final double actualKwh;
  final String status;

  const SolarInstallation({
    required this.name,
    required this.location,
    required this.expectedKwh,
    required this.actualKwh,
    required this.status,
  });

  double get efficiency => (actualKwh / expectedKwh) * 100;

  @override
  List<Object?> get props => [name, location];
}