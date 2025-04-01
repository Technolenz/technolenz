import '../exports.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;
  bool _isDarkMode;

  ThemeProvider() : _isDarkMode = true {
    _themeData = _darkTheme;
  }

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryDark,
    hintColor: AppColors.accentDark,
    cardColor: AppColors.glassDark,
    shadowColor: AppColors.shadowDark,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      labelLarge: TextStyle(color: Colors.white),
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.appBarDark,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    dialogBackgroundColor: AppColors.dialogDark,
    cardTheme: CardTheme(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primaryLight,
    hintColor: AppColors.accentLight,
    cardColor: AppColors.glassLight,
    shadowColor: AppColors.shadowLight,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
      labelLarge: TextStyle(color: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.appBarLight,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    dialogBackgroundColor: AppColors.dialogLight,
    cardTheme: CardTheme(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}

class AppColors {
  // Dark Theme Colors - Keeping your original palette
  static const Color darkBackground = Color(0xFF121212);
  static const Color primaryDark = Color(0xFF00E5FF);
  static const Color accentDark = Color(0xFF00B8D4);
  static const Color glassDark = Color.fromRGBO(30, 30, 30, 0.2);
  static const Color shadowDark = Colors.white10;
  static const Color appBarDark = Color.fromRGBO(31, 31, 31, 0.4);
  static const Color dialogDark = Color.fromRGBO(30, 30, 30, 0.3);

  // Light Theme Colors - Keeping your original palette
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color primaryLight = Color(0xFF448AFF);
  static const Color accentLight = Color(0xFF536DFE);
  static const Color glassLight = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color shadowLight = Colors.black12;
  static const Color appBarLight = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color dialogLight = Color.fromRGBO(255, 255, 255, 0.9);
  static const Color secondaryDark = Color(0xFF00FFAB);
  static const Color secondaryLight = Color(0xFF7C4DFF);
  // New additions (optional extras that work with your palette)
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);

  // Enhanced glass effects (keeping your style but more reusable)
  static BoxDecoration getGlassDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? glassDark : glassLight,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: (isDark ? primaryDark : primaryLight).withOpacity(0.2), width: 1),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.1),
          blurRadius: 12,
          spreadRadius: -4,
        ),
      ],
    );
  }

  // Your original gradients preserved
  static const Gradient darkGradient = LinearGradient(
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient lightGradient = LinearGradient(
    colors: [Color(0xFF85FFBD), Color(0xFFFFFB7D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
