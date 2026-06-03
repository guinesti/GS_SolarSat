import 'package:flutter/material.dart';
import '../../model/solar_installation.dart';

class InstallationCard extends StatelessWidget {
  final SolarInstallation installation;

  const InstallationCard({super.key, required this.installation});

  Color _statusColor() {
    switch (installation.status) {
      case 'Normal':
        return const Color(0xFF4CAF50);
      case 'Alerta':
        return const Color(0xFFF5A623);
      default:
        return const Color(0xFFE53935);
    }
  }

  IconData _statusIcon() {
    switch (installation.status) {
      case 'Normal':
        return Icons.check_circle;
      case 'Alerta':
        return Icons.warning_amber_rounded;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = _statusColor();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withValues(alpha: 0.4), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          installation.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          installation.location,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(_statusIcon(), color: color, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        installation.status,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Esperado', style: Theme.of(context).textTheme.labelSmall),
                        Text(
                          '${installation.expectedKwh.toStringAsFixed(0)} kWh',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Real', style: Theme.of(context).textTheme.labelSmall),
                        Text(
                          '${installation.actualKwh.toStringAsFixed(0)} kWh',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Eficiência', style: Theme.of(context).textTheme.labelSmall),
                        Text(
                          '${installation.efficiency.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
