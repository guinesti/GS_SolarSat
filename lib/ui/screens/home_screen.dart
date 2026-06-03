import 'package:flutter/material.dart';
import '../../model/solar_region.dart';
import '../../model/region_classification.dart';
import '../../repository/solar_region_repository.dart';
import '../../navigation/app_routes.dart';
import '../components/solarsat_top_bar.dart';
import '../components/classification_card.dart';
import '../components/solar_region_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<RegionClassification> classifications;
  late List<SolarRegion> regionsListState;
  RegionClassification? selectedClassification;

  @override
  void initState() {
    super.initState();
    classifications = getAllClassifications();
    regionsListState = getAllRegions();
  }

  void _onClassificationClick(RegionClassification classification) {
    setState(() {
      if (selectedClassification == classification) {
        selectedClassification = null;
        regionsListState = getAllRegions();
      } else {
        selectedClassification = classification;
        regionsListState = getRegionsByClassification(classification);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolarSatTopBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.monitor);
            },
            icon: const Icon(Icons.monitor_heart_outlined),
            tooltip: 'Monitor',
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.simulator);
            },
            icon: const Icon(Icons.calculate_outlined),
            tooltip: 'Simulador',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Mapa de Potencial Solar',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Selecione uma região para análise detalhada',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 96,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  itemCount: classifications.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final c = classifications[index];
                    return ClassificationCard(
                      classification: c,
                      isSelected: selectedClassification == c,
                      onClick: _onClassificationClick,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedClassification != null
                        ? 'Regiões ${selectedClassification!.label}s'
                        : 'Todas as regiões',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (selectedClassification != null)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedClassification = null;
                          regionsListState = getAllRegions();
                        });
                      },
                      child: const Text('Limpar filtro'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: regionsListState.isEmpty
                    ? const Center(child: Text('Nenhuma região encontrada'))
                    : ListView.builder(
                        itemCount: regionsListState.length,
                        itemBuilder: (context, index) {
                          final region = regionsListState[index];
                          return SolarRegionCard(
                            region: region,
                            onClick: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.analysis,
                                arguments: region,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
