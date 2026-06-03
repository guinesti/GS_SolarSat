import 'package:flutter/material.dart';
import '../../navigation/app_routes.dart';

class IntroPage {
  final IconData icon;
  final String title;
  final String description;

  const IntroPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}

const _pages = [
  IntroPage(
    icon: Icons.public,
    title: 'Dados Satelitais Reais',
    description:
        'O SolarSat usa dados da NASA POWER, GOES-16 e Copernicus — satélites reais em órbita monitorando o Brasil agora.',
  ),
  IntroPage(
    icon: Icons.map_outlined,
    title: 'Mapa de Potencial Solar',
    description:
        'Identifique as melhores regiões para instalar painéis solares com dados precisos de irradiação por coordenada.',
  ),
  IntroPage(
    icon: Icons.trending_up,
    title: 'Simule seu Retorno',
    description:
        'Calcule a geração estimada em kWh, economia anual em reais e prazo de payback antes de investir.',
  ),
  IntroPage(
    icon: Icons.monitor_heart_outlined,
    title: 'Monitor de Desempenho',
    description:
        'Acompanhe instalações existentes em tempo real e receba alertas automáticos quando o desempenho cair.',
  ),
];

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPage = 0;

  void _next() {
    if (_currentPage < _pages.length - 1) {
      setState(() => _currentPage++);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _back() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _currentPage ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _currentPage
                          ? const Color(0xFFF5A623)
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5A623).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  page.icon,
                  size: 56,
                  color: const Color(0xFFF5A623),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.6,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _back,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white30),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Voltar'),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5A623),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLast ? 'Começar' : 'Próximo',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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
