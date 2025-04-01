import 'package:technolenz/exports.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  final List<double> _sectionHeights = [600, 800, 1000, 600]; // Adjust these values as needed

  final List<Widget> _sections = const [
    AboutSection(),
    ServicesSection(),
    PortfolioPreview(),
    ContactSection(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Calculate scroll position based on accumulated section heights
    double scrollPosition = 0;
    for (int i = 0; i < index; i++) {
      scrollPosition += _sectionHeights[i];
    }

    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Sidebar with improved styling
        Container(
          width: 280, // Increased width for better spacing
          decoration: BoxDecoration(
            color: AppColors.darkBackground,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Brand moved to sidebar
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Technolenz',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              // Navigation buttons with better spacing
              Expanded(
                child: Column(
                  children: [
                    _NavButton(icon: Icons.person, label: 'About', index: 0),
                    _NavButton(icon: Icons.build, label: 'Services', index: 1),
                    _NavButton(icon: Icons.work, label: 'Portfolio', index: 2),
                    _NavButton(icon: Icons.mail, label: 'Contact', index: 3),
                  ],
                ),
              ),
              // Theme toggle moved to sidebar bottom
              Padding(
                padding: const EdgeInsets.all(24),
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return IconButton(
                      icon: Icon(
                        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => themeProvider.toggleTheme(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // Main content area
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(children: _sections),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const Header(),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: _sections),
          ),
        ),
        BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'About',
              backgroundColor: AppColors.primaryDark,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Services',
              backgroundColor: AppColors.primaryDark,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Portfolio',
              backgroundColor: AppColors.primaryDark,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Contact',
              backgroundColor: AppColors.primaryDark,
            ),
          ],
        ),
      ],
    );
  }
}

class SidebarNavigation extends StatelessWidget {
  const SidebarNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Technolenz',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              _NavButton(icon: Icons.person, label: 'About', index: 0),
              _NavButton(icon: Icons.build, label: 'Services', index: 1),
              _NavButton(icon: Icons.work, label: 'Portfolio', index: 2),
              _NavButton(icon: Icons.mail, label: 'Contact', index: 3),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => themeProvider.toggleTheme(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;

  const _NavButton({required this.icon, required this.label, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextButton.icon(
        onPressed: () {
          final mainPageState = context.findAncestorStateOfType<_MainPageState>();
          mainPageState?._onItemTapped(index);
        },
        icon: Icon(icon, color: Colors.white, size: 24),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Technolenz', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
