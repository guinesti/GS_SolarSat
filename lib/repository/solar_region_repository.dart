import '../model/solar_region.dart';
import '../model/region_classification.dart';

const saoFrancisco = SolarRegion(
  name: 'Vale do São Francisco',
  state: 'BA/PE',
  irradiation: 6.5,
  classification: 'Excelente',
  icon: '☀️',
);

const nordeste = SolarRegion(
  name: 'Sertão Nordestino',
  state: 'CE',
  irradiation: 6.2,
  classification: 'Excelente',
  icon: '☀️',
);

const cerrado = SolarRegion(
  name: 'Cerrado Central',
  state: 'GO',
  irradiation: 5.8,
  classification: 'Excelente',
  icon: '🌤️',
);

const matogrosso = SolarRegion(
  name: 'Mato Grosso',
  state: 'MT',
  irradiation: 5.5,
  classification: 'Bom',
  icon: '🌤️',
);

const saoPaulo = SolarRegion(
  name: 'Interior Paulista',
  state: 'SP',
  irradiation: 5.0,
  classification: 'Bom',
  icon: '⛅',
);

const minasGerais = SolarRegion(
  name: 'Triângulo Mineiro',
  state: 'MG',
  irradiation: 5.2,
  classification: 'Bom',
  icon: '🌤️',
);

const paranaSul = SolarRegion(
  name: 'Norte do Paraná',
  state: 'PR',
  irradiation: 4.8,
  classification: 'Regular',
  icon: '⛅',
);

const rioGrandeSul = SolarRegion(
  name: 'Campanha Gaúcha',
  state: 'RS',
  irradiation: 4.3,
  classification: 'Regular',
  icon: '⛅',
);

List<SolarRegion> getAllRegions() {
  return const [
    saoFrancisco,
    nordeste,
    cerrado,
    matogrosso,
    saoPaulo,
    minasGerais,
    paranaSul,
    rioGrandeSul,
  ];
}

List<SolarRegion> getRegionsByClassification(RegionClassification classification) {
  return getAllRegions()
      .where((r) => r.classification == classification.label)
      .toList();
}

List<RegionClassification> getAllClassifications() {
  return const [
    RegionClassification(label: 'Excelente'),
    RegionClassification(label: 'Bom'),
    RegionClassification(label: 'Regular'),
  ];
}
