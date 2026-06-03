import '../model/solar_installation.dart';

List<SolarInstallation> getAllInstallations() {
  return const [
    SolarInstallation(
      name: 'Usina Petrolina A',
      location: 'Petrolina, PE',
      expectedKwh: 1200,
      actualKwh: 1185,
      status: 'Normal',
    ),
    SolarInstallation(
      name: 'Parque Solar Sobral',
      location: 'Sobral, CE',
      expectedKwh: 980,
      actualKwh: 745,
      status: 'Alerta',
    ),
    SolarInstallation(
      name: 'Usina Chapada',
      location: 'Chapada dos Veadeiros, GO',
      expectedKwh: 1540,
      actualKwh: 1520,
      status: 'Normal',
    ),
    SolarInstallation(
      name: 'Parque Solar Barreiras',
      location: 'Barreiras, BA',
      expectedKwh: 870,
      actualKwh: 430,
      status: 'Crítico',
    ),
    SolarInstallation(
      name: 'Usina Mossoró',
      location: 'Mossoró, RN',
      expectedKwh: 1100,
      actualKwh: 1088,
      status: 'Normal',
    ),
  ];
}
