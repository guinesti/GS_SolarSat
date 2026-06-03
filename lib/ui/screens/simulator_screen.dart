import 'package:flutter/material.dart';
import '../../model/solar_region.dart';

class SimulatorScreen extends StatefulWidget {
  final SolarRegion? region;

  const SimulatorScreen({super.key, this.region});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  final List<int> _investmentOptions = [10000, 30000, 50000, 100000, 200000, 500000];
  int? _selectedInvestment;
  bool _calculated = false;

  double _annualGeneration = 0;
  double _annualSavings = 0;
  double _paybackYears = 0;

  void _selectInvestment(int value) {
    setState(() {
      _selectedInvestment = value;
      _calculated = false;
    });
  }

  void _calculate() {
    if (_selectedInvestment == null) return;
    final irr = widget.region?.irradiation ?? 5.5;
    final kwp = _selectedInvestment! / 4000;
    final generation = kwp * irr * 365;
    final savings = generation * 0.85;
    final payback = _selectedInvestment! / savings;

    setState(() {
      _calculated = true;
      _annualGeneration = generation;
      _annualSavings = savings;
      _paybackYears = payback;
    });
  }

  void _reset() {
    setState(() {
      _calculated = false;
      _selectedInvestment = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Retorno'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_calculated)
            IconButton(
              onPressed: _reset,
              icon: const Icon(Icons.refresh),
              tooltip: 'Recalcular',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.region != null)
              Card(
                color: const Color(0xFFF5A623).withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(widget.region!.icon,
                          style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.region!.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Irradiação: ${widget.region!.irradiation} kWh/m²/dia',
                            style: const TextStyle(
                              color: Color(0xFFF5A623),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Selecione o valor do investimento:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _investmentOptions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final value = _investmentOptions[index];
                  final isSelected = _selectedInvestment == value;
                  return GestureDetector(
                    onTap: () => _selectInvestment(value),
                    child: Chip(
                      label: Text(
                        'R\$ ${value ~/ 1000}k',
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFFF5A623),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: isSelected
                          ? const Color(0xFFF5A623)
                          : const Color(0xFFF5A623).withValues(alpha: 0.1),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            if (_selectedInvestment != null)
              Text(
                'Investimento selecionado: R\$ $_selectedInvestment',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFF5A623),
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedInvestment != null ? _calculate : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Calcular Projeção',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_calculated)
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      'Projeção de Retorno',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _resultCard(
                      context,
                      'Geração Anual Estimada',
                      '${_annualGeneration.toStringAsFixed(0)} kWh',
                      Icons.bolt,
                      const Color(0xFF4CAF50),
                    ),
                    const SizedBox(height: 8),
                    _resultCard(
                      context,
                      'Economia Anual em Reais',
                      'R\$ ${_annualSavings.toStringAsFixed(0)}',
                      Icons.savings_outlined,
                      const Color(0xFF4CAF50),
                    ),
                    const SizedBox(height: 8),
                    _resultCard(
                      context,
                      'Prazo de Payback',
                      '${_paybackYears.toStringAsFixed(1)} anos',
                      Icons.schedule,
                      const Color(0xFFF5A623),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline,
                                color: Color(0xFF4CAF50), size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Dados com base em irradiação satelital. '
                                'Tarifa média: R\$ 0,85/kWh.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _resultCard(BuildContext context, String label, String value,
      IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
