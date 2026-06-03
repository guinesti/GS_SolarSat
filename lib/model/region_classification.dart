import 'package:equatable/equatable.dart';

class RegionClassification extends Equatable {
  final String label;

  const RegionClassification({required this.label});

  @override
  List<Object?> get props => [label];
}