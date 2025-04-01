import 'package:technolenz/exports.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: AppColors.getGlassDecoration(isDarkMode),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Services I Offer",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "I provide high-quality development & tech solutions tailored to your needs.",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // Responsive Grid Layout for Services
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _ServiceCard(
                icon: FontAwesomeIcons.mobileAlt,
                title: "Mobile App Development",
                description:
                    "Cross-platform Flutter apps with stunning UI/UX and high performance.",
                email: "mailto:technolenz@example.com",
              ),
              _ServiceCard(
                icon: FontAwesomeIcons.laptopCode,
                title: "Web Development",
                description: "Modern, responsive, and high-performance websites and web apps.",
                email: "mailto:technolenz@example.com",
              ),
              _ServiceCard(
                icon: FontAwesomeIcons.chartLine,
                title: "Data Science & Analysis",
                description: "Transforming raw data into actionable insights using Python and SQL.",
                email: "mailto:technolenz@example.com",
              ),
              _ServiceCard(
                icon: FontAwesomeIcons.shieldHalved,
                title: "Cybersecurity & Pen Testing",
                description: "Securing systems with ethical hacking and vulnerability assessments.",
                email: "mailto:technolenz@example.com",
              ),
              _ServiceCard(
                icon: FontAwesomeIcons.paintBrush,
                title: "UI/UX Design",
                description: "Creating clean, modern, and user-friendly interfaces for your apps.",
                email: "mailto:technolenz@example.com",
              ),
              _ServiceCard(
                icon: FontAwesomeIcons.cogs,
                title: "Software Consulting",
                description: "Providing expert guidance and best practices for your projects.",
                email: "mailto:technolenz@example.com",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String email;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.glassDark : AppColors.glassLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (isDarkMode ? AppColors.primaryDark : AppColors.primaryLight).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(icon, size: 50, color: AppColors.primaryDark),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () async {
              final Uri uri = Uri.parse(email);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Could not open email app.")));
              }
            },
            icon: const Icon(Icons.mail),
            label: const Text("Contact Me"),
          ),
        ],
      ),
    );
  }
}
