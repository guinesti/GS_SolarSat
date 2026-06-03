import 'package:flutter/material.dart';
import '../../model/region_classification.dart';

class ClassificationCard extends StatelessWidget {
  final RegionClassification classification;
  final bool isSelected;
  final Function(RegionClassification)? onClick;

  const ClassificationCard({
    super.key,
    required this.classification,
    this.isSelected = false,
    this.onClick,
  });

  Color _getColor() {
    switch (classification.label) {
      case 'Excelente':
        return const Color(0xFFF5A623);
      case 'Bom':
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF90A4AE);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return GestureDetector(
      onTap: onClick != null ? () => onClick!(classification) : null,
      child: SizedBox(
        width: 100,
        height: 90,
        child: Card(
          shape: const CircleBorder(),
          elevation: isSelected ? 6 : 2,
          color: isSelected ? color : Theme.of(context).colorScheme.surface,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                classification.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Colors.white
                      : color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
