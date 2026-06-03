import 'package:flutter/material.dart';
import '../../model/solar_installation.dart';
import '../../repository/solar_installation_repository.dart';
import '../components/installation_card.dart';

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({super.key});

  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  late List<SolarInstallation> allInstallations;
  late List<SolarInstallation> filteredInstallations;
  String _selectedStatus = 'Todos';

  final List<String> _statusFilters = ['Todos', 'Normal', 'Alerta', 'Crítico'];

  @override
  void initState() {
    super.initState();
    allInstallations = getAllInstallations();
    filteredInstallations = allInstallations;
  }

  void _filterByStatus(String status) {
    setState(() {
      _selectedStatus = status;
      if (status == 'Todos') {
        filteredInstallations = allInstallations;
      } else {
        filteredInstallations =
            allInstallations.where((i) => i.status == status).toList();
      }
    });
  }

  Color _filterColor(String status) {
    switch (status) {
      case 'Normal':
        return const Color(0xFF4CAF50);
      case 'Alerta':
        return const Color(0xFFF5A623);
      case 'Crítico':
        return const Color(0xFFE53935);
      default:
        return Colors.grey;
    }
  }

  int _countByStatus(String status) {
    if (status == 'Todos') return allInstallations.length;
    return allInstallations.where((i) => i.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor de Desempenho'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                _summaryCard(context, 'Total', _countByStatus('Todos'), Colors.grey),
                const SizedBox(width: 8),
                _summaryCard(context, 'Normal', _countByStatus('Normal'), const Color(0xFF4CAF50)),
                const SizedBox(width: 8),
                _summaryCard(context, 'Alerta', _countByStatus('Alerta'), const Color(0xFFF5A623)),
                const SizedBox(width: 8),
                _summaryCard(context, 'Crítico', _countByStatus('Crítico'), const Color(0xFFE53935)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _statusFilters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final status = _statusFilters[index];
                  final isSelected = _selectedStatus == status;
                  final color = _filterColor(status);
                  return GestureDetector(
                    onTap: () => _filterByStatus(status),
                    child: Chip(
                      label: Text(
                        status,
                        style: TextStyle(
                          color: isSelected ? Colors.white : color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: isSelected ? color : color.withValues(alpha: 0.1),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${filteredInstallations.length} instalação(ões) encontrada(s)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filteredInstallations.isEmpty
                  ? const Center(child: Text('Nenhuma instalação encontrada'))
                  : ListView.builder(
                      itemCount: filteredInstallations.length,
                      itemBuilder: (context, index) {
                        return InstallationCard(
                          installation: filteredInstallations[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(BuildContext context, String label, int count, Color color) {
    return Expanded(
      child: Card(
        color: color.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            children: [
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 11, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
