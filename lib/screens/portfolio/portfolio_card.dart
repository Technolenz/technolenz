import 'package:intl/intl.dart';
import 'package:technolenz/exports.dart';

class PortfolioCardItem extends StatefulWidget {
  final PortfolioItem item;
  final VoidCallback onTap;

  const PortfolioCardItem({required this.item, required this.onTap, super.key});

  @override
  State<PortfolioCardItem> createState() => _PortfolioCardItemState();
}

class _PortfolioCardItemState extends State<PortfolioCardItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() => _isHovering = hovering);
    if (hovering) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Card(
            elevation: _isHovering ? 8 : 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Background Image
                if (widget.item.imageUrls.isNotEmpty)
                  Positioned.fill(
                    child: Image.asset(
                      widget.item.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: isDark ? Colors.grey[800] : Colors.grey[200],
                            child: const Icon(Icons.broken_image),
                          ),
                    ),
                  )
                else
                  Container(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    child: const Center(child: Icon(Icons.work)),
                  ),

                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.2),
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),

                // Content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.item.shortDescription,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            ...widget.item.techStack
                                .take(3)
                                .map(
                                  (tech) => Chip(
                                    label: Text(
                                      tech.toString().split('.').last,
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.black.withOpacity(0.5),
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ),
                            if (widget.item.techStack.length > 3)
                              Chip(
                                label: Text(
                                  '+${widget.item.techStack.length - 3}',
                                  style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
                                ),
                                backgroundColor: Colors.black.withOpacity(0.5),
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Badges
                Positioned(
                  top: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (widget.item.appRating != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                widget.item.appRating.toString(),
                                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 8),
                      if (widget.item.downloadCount != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.download, color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.item.downloadCount}+',
                                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Hover overlay
                if (_isHovering)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: Icon(Icons.zoom_in, color: Colors.white, size: 48),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectDetailsScreen extends StatelessWidget {
  final PortfolioItem item;

  const ProjectDetailsScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: [
          if (item.githubUrl != null)
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.github),
              onPressed: () => launchUrl(Uri.parse(item.githubUrl!)),
            ),
          if (item.liveDemoUrl != null)
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.globe),
              onPressed: () => launchUrl(Uri.parse(item.liveDemoUrl!)),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Gallery
            SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: item.imageUrls.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder:
                    (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item.imageUrls[index],
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              width: 300,
                              height: 300,
                              color: isDark ? Colors.grey[800] : Colors.grey[200],
                              child: const Icon(Icons.broken_image),
                            ),
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 24),

            // Project Details
            Text(
              item.title,
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              item.shortDescription,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 24),

            // Tech Stack
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  item.techStack
                      .map(
                        (tech) => Chip(
                          label: Text(tech.toString().split('.').last),
                          avatar: Icon(techStackIcons[tech] ?? Icons.code),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 24),

            // Description
            Text(
              'Description',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item.longDescription, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 24),

            // Features
            if (item.features.isNotEmpty) ...[
              Text(
                'Key Features',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...item.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(feature)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Stats
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _StatItem(
                  icon: Icons.calendar_today,
                  label: 'Released',
                  value: DateFormat('MMM yyyy').format(item.releaseDate),
                ),
                if (item.developmentTime != null)
                  _StatItem(
                    icon: Icons.timer,
                    label: 'Development',
                    value: '${item.developmentTime!.inDays} days',
                  ),
                if (item.downloadCount != null)
                  _StatItem(
                    icon: Icons.download,
                    label: 'Downloads',
                    value: '${item.downloadCount!}+',
                  ),
                if (item.appRating != null)
                  _StatItem(
                    icon: Icons.star,
                    label: 'Rating',
                    value: item.appRating!.toStringAsFixed(1),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
