import 'package:flutter/material.dart';
import '../../model/solar_region.dart';
import '../../navigation/app_routes.dart';

class AnalysisScreen extends StatelessWidget {
  final SolarRegion region;

  const AnalysisScreen({super.key, required this.region});

  Color _classificationColor() {
    switch (region.classification) {
      case 'Excelente':
        return const Color(0xFFF5A623);
      case 'Bom':
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF90A4AE);
    }
  }

  Widget _infoCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = _classificationColor();

    final recommendedCapacity = (region.irradiation * 8).toStringAsFixed(0);
    final annualGeneration = (region.irradiation * 365 * 10).toStringAsFixed(0);
    final annualSavings = (region.irradiation * 365 * 10 * 0.85).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: Text(region.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: color.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: color.withValues(alpha: 0.3)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(region.icon, style: const TextStyle(fontSize: 48)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            region.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(region.state),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              region.classification,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Score de Potencial Solar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    context,
                    'Irradiação',
                    '${region.irradiation} kWh/m²',
                    Icons.wb_sunny_outlined,
                    color,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _infoCard(
                    context,
                    'Capacidade Ideal',
                    '$recommendedCapacity kWp',
                    Icons.solar_power,
                    color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    context,
                    'Geração Anual',
                    '$annualGeneration kWh',
                    Icons.bolt,
                    const Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _infoCard(
                    context,
                    'Economia/ano',
                    'R\$ $annualSavings',
                    Icons.savings_outlined,
                    const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.satellite_alt, size: 18, color: Color(0xFFF5A623)),
                        SizedBox(width: 8),
                        Text(
                          'Fontes Satelitais',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• NASA POWER — Irradiação histórica e em tempo real\n'
                      '• GOES-16 — Cobertura de nuvens e clima\n'
                      '• Copernicus ESA — Terreno e sombreamento',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.simulator,
                    arguments: region,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.calculate_outlined),
                label: const Text(
                  'Simular Retorno do Investimento',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
