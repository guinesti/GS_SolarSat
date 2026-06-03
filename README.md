# SolarSat — Otimização de Energia Solar com Dados Orbitais

**Global Solution 2026 · FIAP · 3SIR Sistemas de Informação**  
Gustavo Iudi Rosa Oda · Rafael Catapani Scharlack · Guilherme de Nicola Nesti

---

## Sobre o Projeto

O **SolarSat** é uma plataforma mobile desenvolvida em Flutter que utiliza dados satelitais para apoiar decisões de instalação e monitoramento de energia solar no Brasil.

**Problema:** Empresas e prefeituras instalam painéis solares sem dados precisos de irradiação local, perdendo até 30% de eficiência.

**Solução:** O SolarSat usa dados das APIs da NASA POWER, GOES-16 e Copernicus para:

- Identificar os melhores locais para instalação de painéis solares
- Estimar geração de energia e retorno financeiro
- Monitorar anomalias de desempenho em instalações existentes

## Fluxo de Telas

```
[Splash]
   ↓
[Intro — Página 1/4: Dados Satelitais]
   ↓ botão Próximo
[Intro — Página 2/4: Mapa de Potencial]
   ↓ botão Próximo
[Intro — Página 3/4: Simulador]
   ↓ botão Próximo
[Intro — Página 4/4: Monitor]
   ↓ botão Começar
[Home — Dashboard]
   ├── filtro por classificação → lista atualiza
   ├── toca em uma região → [Análise de Região]
   │       └── botão Simular → [Simulador de Retorno]
   │               └── seleciona valor → Calcular → exibe resultado
   ├── ícone Monitor (AppBar) → [Monitor de Desempenho]
   │       └── filtro por status → lista atualiza
   └── ícone Simulador (AppBar) → [Simulador de Retorno]
```

---

## Telas do Aplicativo

### 1. Splash Screen

- Exibe o logo do SolarSat (ícone de satélite + nome)
- Navega automaticamente para a Intro após 2 segundos

### 2. Intro Screen

- 4 páginas explicativas sobre o aplicativo
- Cada página tem: ícone, título e descrição
- Botões **Próximo** e **Voltar** para navegar entre páginas
- Indicador de progresso (dots) no topo
- Último slide tem botão **Começar** que leva ao Dashboard

### 3. Home Screen — Dashboard

- Lista vertical com 8 regiões solares brasileiras
- Lista horizontal de filtros por classificação (Excelente, Bom, Regular)
- Ao clicar em um filtro: lista atualiza mostrando só as regiões daquela classificação
- Botão "Limpar filtro" aparece quando um filtro está ativo
- Toque em uma região navega para a tela de Análise
- Ícones na AppBar para acessar Monitor e Simulador diretamente

### 4. Análise de Região

- Exibe detalhes completos da região selecionada
- Score de potencial solar: irradiação, capacidade ideal, geração anual, economia/ano
- Card com as fontes satelitais utilizadas (NASA POWER, GOES-16, Copernicus)
- Botão para navegar ao Simulador já com a região pré-selecionada

### 5. Simulador de Retorno

- Lista horizontal com opções de investimento (R$ 10k a R$ 500k)
- Usuário seleciona um valor e clica em **Calcular Projeção**
- Resultado exibe: geração anual em kWh, economia anual em R$ e prazo de payback
- Botão de refresh para recalcular

### 6. Monitor de Desempenho

- Resumo por status no topo (Total, Normal, Alerta, Crítico)
- Lista horizontal de filtros por status
- Lista de 5 instalações com: nome, localização, kWh esperado, kWh real e eficiência
- Status visual por cor: verde (Normal), amarelo (Alerta), vermelho (Crítico)

---

## Estrutura do Projeto

```
lib/
├── main.dart                              # Entry point + MaterialApp
├── navigation/
│   ├── app_routes.dart                    # Constantes de rotas
│   └── app_navigation.dart               # generateRoute com switch/case
├── model/
│   ├── solar_region.dart                  # Modelo de região solar
│   ├── solar_installation.dart            # Modelo de instalação
│   └── region_classification.dart         # Modelo de classificação
├── repository/
│   ├── solar_region_repository.dart       # Dados mockados de regiões
│   └── solar_installation_repository.dart # Dados mockados de instalações
└── ui/
    ├── components/
    │   ├── app_logo.dart                  # Logo reutilizável
    │   ├── solarsat_top_bar.dart          # AppBar customizada
    │   ├── classification_card.dart       # Card circular de filtro
    │   ├── solar_region_card.dart         # Card de região na lista
    │   └── installation_card.dart         # Card de instalação
    └── screens/
        ├── splash_screen.dart             # Tela de splash
        ├── intro_screen.dart              # Tela de introdução
        ├── home_screen.dart               # Dashboard principal
        ├── analysis_screen.dart           # Análise de região
        ├── simulator_screen.dart          # Simulador de retorno
        └── monitor_screen.dart            # Monitor de desempenho
```
