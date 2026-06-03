import 'package:equatable/equatable.dart';

class SolarRegion extends Equatable {
  final String name;
  final String state;
  final double irradiation;
  final String classification;
  final String icon;

  const SolarRegion({
    required this.name,
    required this.state,
    required this.irradiation,
    required this.classification,
    required this.icon,
  });

  @override
  List<Object?> get props => [name, state];
}