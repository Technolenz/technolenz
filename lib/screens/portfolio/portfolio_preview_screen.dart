import 'package:technolenz/exports.dart';

class PortfolioPreview extends StatelessWidget {
  const PortfolioPreview({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: AppColors.getGlassDecoration(isDarkMode),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("My Portfolio", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text(
            "Check out my latest projects showcasing my skills in Flutter, full-stack development, and cybersecurity.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PortfolioScreen()),
              );
            },
            icon: const Icon(Icons.work),
            label: const Text("View Portfolio"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
