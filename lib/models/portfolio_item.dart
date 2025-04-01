import 'package:technolenz/exports.dart';

enum PortfolioCategory {
  mobileApp,
  webApp,
  uiDesign,
  prototype,
  dataScience,
  dataViz,
  cybersecurity,
  linuxTool,
  openSource,
  caseStudy,
}

enum UseCase {
  // Existing
  productivity,
  finance,
  entertainment,
  health,
  social,
  ecommerce,
  education,
  utilities,
  techDemo,
  gaming,
  travel,
  fitness,

  // New
  dataAnalysis,
  machineLearning,
  statisticalModeling,
  penetrationTesting,
  systemAutomation,
  networkSecurity,
  ethicalHacking,
  cloudComputing,
}

enum TechStack {
  // Core Mobile/Web
  flutter,
  dart,

  // State Management
  riverpod,
  bloc,
  provider,
  getx,

  // Backend
  firebase,
  supabase,
  appwrite,
  awsAmplify,

  // Data Science
  python,
  pandas,
  numpy,
  scikitLearn,
  tensorflow,
  pytorch,
  jupyter,
  matplotlib,
  seaborn,
  plotly,
  dash,

  // Cybersecurity
  kaliLinux,
  wireshark,
  metasploit,
  burpSuite,
  nmap,
  owasp,

  // Linux/DevOps
  bashScripting,
  docker,
  kubernetes,
  ansible,
  terraform,
  aws,
  gcp,

  // Database
  sql,
  postgresql,
  mongodb,
  hive,
  isar,

  // Other
  git,
  githubActions,
  figma,
  adobeXd,
}

// Complete Icon Mappings
const Map<PortfolioCategory, IconData> categoryIcons = {
  PortfolioCategory.mobileApp: FontAwesomeIcons.mobileScreen,
  PortfolioCategory.webApp: FontAwesomeIcons.globe,
  PortfolioCategory.uiDesign: FontAwesomeIcons.paintbrush,
  PortfolioCategory.prototype: FontAwesomeIcons.lightbulb,
  PortfolioCategory.dataScience: FontAwesomeIcons.microscope,
  PortfolioCategory.dataViz: FontAwesomeIcons.chartLine,
  PortfolioCategory.cybersecurity: FontAwesomeIcons.shieldHalved,
  PortfolioCategory.linuxTool: FontAwesomeIcons.terminal,
  PortfolioCategory.openSource: FontAwesomeIcons.codeBranch,
  PortfolioCategory.caseStudy: FontAwesomeIcons.fileLines,
};

const Map<TechStack, IconData> techStackIcons = {
  // Core Mobile/Web
  TechStack.flutter: FontAwesomeIcons.mobileScreen,
  TechStack.dart: FontAwesomeIcons.code,

  // State Management
  TechStack.riverpod: FontAwesomeIcons.diagramProject,
  TechStack.bloc: FontAwesomeIcons.layerGroup,
  TechStack.provider: FontAwesomeIcons.boxesStacked,
  TechStack.getx: FontAwesomeIcons.bolt,

  // Backend
  TechStack.firebase: FontAwesomeIcons.fire,
  TechStack.supabase: FontAwesomeIcons.database,
  TechStack.appwrite: FontAwesomeIcons.server,
  TechStack.awsAmplify: FontAwesomeIcons.aws,

  // Data Science
  TechStack.python: FontAwesomeIcons.python,
  TechStack.pandas: FontAwesomeIcons.table,
  TechStack.numpy: FontAwesomeIcons.chartLine,
  TechStack.scikitLearn: FontAwesomeIcons.robot,
  TechStack.tensorflow: FontAwesomeIcons.brain,
  TechStack.pytorch: FontAwesomeIcons.fire,
  TechStack.jupyter: FontAwesomeIcons.bookOpen,

  // Visualization
  TechStack.matplotlib: FontAwesomeIcons.chartSimple,
  TechStack.seaborn: FontAwesomeIcons.chartBar,
  TechStack.plotly: FontAwesomeIcons.chartPie,
  TechStack.dash: FontAwesomeIcons.chartColumn,

  // Cybersecurity
  TechStack.kaliLinux: FontAwesomeIcons.shieldHalved,
  TechStack.wireshark: FontAwesomeIcons.eye,
  TechStack.metasploit: FontAwesomeIcons.bug,
  TechStack.burpSuite: FontAwesomeIcons.userShield,
  TechStack.nmap: FontAwesomeIcons.networkWired,
  TechStack.owasp: FontAwesomeIcons.shieldVirus,

  // Linux/DevOps
  TechStack.bashScripting: FontAwesomeIcons.terminal,
  TechStack.docker: FontAwesomeIcons.docker,
  TechStack.kubernetes: FontAwesomeIcons.cubes,
  TechStack.ansible: FontAwesomeIcons.robot,
  TechStack.terraform: FontAwesomeIcons.mountain,
  TechStack.aws: FontAwesomeIcons.aws,
  TechStack.gcp: FontAwesomeIcons.google,

  // Database
  TechStack.sql: FontAwesomeIcons.database,
  TechStack.postgresql: FontAwesomeIcons.database,
  TechStack.mongodb: FontAwesomeIcons.leaf,
  TechStack.hive: FontAwesomeIcons.database,
  TechStack.isar: FontAwesomeIcons.database,

  // Other
  TechStack.git: FontAwesomeIcons.gitAlt,
  TechStack.githubActions: FontAwesomeIcons.github,
  TechStack.figma: FontAwesomeIcons.figma,
  TechStack.adobeXd: FontAwesomeIcons.xing,
};

const Map<UseCase, IconData> useCaseIcons = {
  // Existing
  UseCase.productivity: FontAwesomeIcons.rocket,
  UseCase.finance: FontAwesomeIcons.moneyBillWave,
  UseCase.entertainment: FontAwesomeIcons.film,
  UseCase.health: FontAwesomeIcons.heartPulse,
  UseCase.social: FontAwesomeIcons.users,
  UseCase.ecommerce: FontAwesomeIcons.cartShopping,
  UseCase.education: FontAwesomeIcons.graduationCap,
  UseCase.utilities: FontAwesomeIcons.toolbox,
  UseCase.techDemo: FontAwesomeIcons.vial,
  UseCase.gaming: FontAwesomeIcons.gamepad,
  UseCase.travel: FontAwesomeIcons.plane,
  UseCase.fitness: FontAwesomeIcons.dumbbell,

  // New
  UseCase.dataAnalysis: FontAwesomeIcons.magnifyingGlassChart,
  UseCase.machineLearning: FontAwesomeIcons.robot,
  UseCase.statisticalModeling: FontAwesomeIcons.chartLine,
  UseCase.penetrationTesting: FontAwesomeIcons.userShield,
  UseCase.systemAutomation: FontAwesomeIcons.robot,
  UseCase.networkSecurity: FontAwesomeIcons.networkWired,
  UseCase.ethicalHacking: FontAwesomeIcons.mask,
  UseCase.cloudComputing: FontAwesomeIcons.cloud,
};

class PortfolioItem {
  final String id;
  final String title;
  final String shortDescription;
  final String longDescription;
  final List<String> imageUrls;
  final String? videoUrl;
  final String? liveDemoUrl;
  final String? githubUrl;
  final String? caseStudyUrl;
  final String? researchPaperUrl;
  final PortfolioCategory category;
  final List<UseCase> useCases;
  final List<TechStack> techStack;

  // Project metadata
  final DateTime releaseDate;
  final Duration? developmentTime;
  final bool isFeatured;
  final bool isOpenSource;

  // Technical details
  final List<String> features;
  final List<String> challenges;
  final List<String> learnings;

  // Metrics
  final int? downloadCount;
  final double? appRating;
  final int? datasetSize;
  final String? modelAccuracy;
  final List<String> vulnerabilitiesFound;

  // Team info
  final bool isTeamProject;
  final String? teamSize;
  final String? myRole;

  const PortfolioItem({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.imageUrls,
    this.videoUrl,
    this.liveDemoUrl,
    this.githubUrl,
    this.caseStudyUrl,
    this.researchPaperUrl,
    required this.category,
    required this.useCases,
    required this.techStack,
    required this.releaseDate,
    this.developmentTime,
    required this.features,
    required this.challenges,
    required this.learnings,
    this.downloadCount,
    this.appRating,
    this.datasetSize,
    this.modelAccuracy,
    required this.vulnerabilitiesFound,
    this.isFeatured = false,
    this.isOpenSource = false,
    this.isTeamProject = false,
    this.teamSize,
    this.myRole,
  });

  // Helper Methods
  String get categoryDisplayName {
    switch (category) {
      case PortfolioCategory.mobileApp:
        return 'Mobile App';
      case PortfolioCategory.webApp:
        return 'Web App';
      case PortfolioCategory.uiDesign:
        return 'UI Design';
      case PortfolioCategory.prototype:
        return 'Prototype';
      case PortfolioCategory.dataScience:
        return 'Data Science';
      case PortfolioCategory.dataViz:
        return 'Data Visualization';
      case PortfolioCategory.cybersecurity:
        return 'Cybersecurity';
      case PortfolioCategory.linuxTool:
        return 'Linux Tool';
      case PortfolioCategory.openSource:
        return 'Open Source';
      case PortfolioCategory.caseStudy:
        return 'Case Study';
    }
  }

  bool get hasSecurityRelevance =>
      useCases.contains(UseCase.penetrationTesting) ||
      useCases.contains(UseCase.ethicalHacking) ||
      useCases.contains(UseCase.networkSecurity) ||
      techStack.contains(TechStack.kaliLinux) ||
      techStack.contains(TechStack.metasploit);

  bool get isDataProject =>
      category == PortfolioCategory.dataScience ||
      category == PortfolioCategory.dataViz ||
      techStack.contains(TechStack.python) ||
      techStack.contains(TechStack.pandas);
}

extension PortfolioItemExtensions on PortfolioItem {
  IconData get categoryIcon => categoryIcons[category] ?? FontAwesomeIcons.folder;

  List<IconData> get techIcons =>
      techStack.map((tech) => techStackIcons[tech] ?? FontAwesomeIcons.code).toList();

  List<IconData> get useCaseIconsList =>
      useCases.map((useCase) => useCaseIcons[useCase] ?? FontAwesomeIcons.star).toList();

  // Bonus: Get associated colors
  Color get categoryColor {
    switch (category) {
      case PortfolioCategory.mobileApp:
        return Colors.blue;
      case PortfolioCategory.webApp:
        return Colors.green;
      case PortfolioCategory.dataScience:
        return Colors.purple;
      case PortfolioCategory.cybersecurity:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
