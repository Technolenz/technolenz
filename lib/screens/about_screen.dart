import 'package:technolenz/exports.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
          // Hero Section
          CircleAvatar(
            radius: screenWidth > 800 ? 80 : 60,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          const SizedBox(height: 20),
          Text(
            "Technolenz",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Text(
            "Full Stack Developer | Flutter & Data Science Enthusiast",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),

          // Biography
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth > 800 ? 100 : 20),
            child: const Text(
              "I am an experienced cross-platform mobile and full-stack web developer specializing in Flutter. "
              "I also have strong skills in statistical analysis, data visualization, and Python programming, "
              "allowing me to bridge the gap between development and data science. "
              "Currently, I’m expanding my expertise in machine learning and cybersecurity.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 30),

          // Skills Overview
          const _SkillSection(),

          const SizedBox(height: 30),

          // Technologies Used
          const _TechStack(),

          const SizedBox(height: 30),

          // Contact or Call to Action
          ElevatedButton.icon(
            onPressed: () {
              // Add navigation to Contact Section
            },
            icon: const Icon(Icons.mail),
            label: const Text("Get in Touch"),
          ),
        ],
      ),
    );
  }
}

class _SkillSection extends StatelessWidget {
  const _SkillSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SkillBar(skill: "Flutter", level: 75),
        _SkillBar(skill: "Dart", level: 80),
        _SkillBar(skill: "Python (Data Science)", level: 70),
        _SkillBar(skill: "SQL & Databases", level: 75),
        _SkillBar(skill: "Linux", level: 75),
        _SkillBar(skill: "Cybersecurity & Pen Testing", level: 40),
      ],
    );
  }
}

class _SkillBar extends StatelessWidget {
  final String skill;
  final double level;

  const _SkillBar({required this.skill, required this.level, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: level / 100,
            minHeight: 6,
            backgroundColor: Colors.grey.withOpacity(0.3),
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}

class _TechStack extends StatelessWidget {
  const _TechStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Tech Stack", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _TechIcon(icon: FontAwesomeIcons.flutter, label: "Flutter"),
            _TechIcon(icon: FontAwesomeIcons.code, label: "Dart"),
            _TechIcon(icon: FontAwesomeIcons.python, label: "Python"),
            _TechIcon(icon: FontAwesomeIcons.database, label: "SQL"),
            _TechIcon(icon: FontAwesomeIcons.linux, label: "Linux"),
            _TechIcon(icon: FontAwesomeIcons.shieldHalved, label: "Security"),
          ],
        ),
      ],
    );
  }
}

class _TechIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TechIcon({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, size: 40),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
