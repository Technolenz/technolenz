import 'package:technolenz/exports.dart';

class PortfolioFilter extends StatelessWidget {
  final PortfolioCategory? selectedCategory;
  final UseCase? selectedUseCase;
  final TechStack? selectedTechStack;
  final Function(PortfolioCategory?) onCategorySelected;
  final Function(UseCase?) onUseCaseSelected;
  final Function(TechStack?) onTechStackSelected;
  final bool isMobile;

  const PortfolioFilter({
    super.key,
    required this.selectedCategory,
    required this.selectedUseCase,
    required this.selectedTechStack,
    required this.onCategorySelected,
    required this.onUseCaseSelected,
    required this.onTechStackSelected,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;

    return Column(
      children: [
        // Category Filters
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            // "All" filter chip
            FilterChip(
              label: Text(
                'All',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: selectedCategory == null ? Colors.white : primaryColor,
                ),
              ),
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
              backgroundColor: isDark ? AppColors.glassDark : AppColors.glassLight,
              selectedColor: primaryColor,
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
              ),
            ),
            // Category filter chips
            ...PortfolioCategory.values.map((category) {
              return FilterChip(
                label: Text(
                  _formatCategoryName(category.toString()),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: selectedCategory == category ? Colors.white : primaryColor,
                  ),
                ),
                selected: selectedCategory == category,
                onSelected: (selected) => onCategorySelected(selected ? category : null),
                backgroundColor: isDark ? AppColors.glassDark : AppColors.glassLight,
                selectedColor: primaryColor,
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
                ),
              );
            }),
          ],
        ),
        if (!isMobile) ...[
          const SizedBox(height: 16),
          // Use Case Filters
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              FilterChip(
                label: Text(
                  'All Use Cases',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: selectedUseCase == null ? Colors.white : primaryColor,
                  ),
                ),
                selected: selectedUseCase == null,
                onSelected: (_) => onUseCaseSelected(null),
                backgroundColor: isDark ? AppColors.glassDark : AppColors.glassLight,
                selectedColor: primaryColor,
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
                ),
              ),
              ...UseCase.values.map((useCase) {
                return FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        useCaseIcons[useCase] ?? FontAwesomeIcons.star,
                        size: 16,
                        color: selectedUseCase == useCase ? Colors.white : primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatCategoryName(useCase.toString()),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: selectedUseCase == useCase ? Colors.white : primaryColor,
                        ),
                      ),
                    ],
                  ),
                  selected: selectedUseCase == useCase,
                  onSelected: (selected) => onUseCaseSelected(selected ? useCase : null),
                  backgroundColor: isDark ? AppColors.glassDark : AppColors.glassLight,
                  selectedColor: primaryColor,
                  checkmarkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          // Tech Stack Filters
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              FilterChip(
                label: Text(
                  'All Tech Stacks',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: selectedTechStack == null ? Colors.white : primaryColor,
                  ),
                ),
                selected: selectedTechStack == null,
                onSelected: (_) => onTechStackSelected(null),
                backgroundColor: isDark ? AppColors.glassDark : AppColors.glassLight,
                selectedColor: primaryColor,
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
                ),
              ),
              ...TechStack.values.map((techStack) {
                return FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        techStackIcons[techStack] ?? FontAwesomeIcons.code,
                        size: 16,
                        color: selectedTechStack == techStack ? Colors.white : primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatCategoryName(techStack.toString()),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: selectedTechStack == techStack ? Colors.white : primaryColor,
                        ),
                      ),
                    ],
                  ),
                  selected: selectedTechStack == techStack,
                  onSelected: (selected) => onTechStackSelected(selected ? techStack : null),
                  backgroundColor: isDark ? AppColors.glassDark : AppColors.glassLight,
                  selectedColor: primaryColor,
                  checkmarkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
                  ),
                );
              }),
            ],
          ),
        ],
      ],
    );
  }

  String _formatCategoryName(String enumString) {
    return enumString
        .split('.')
        .last
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim();
  }
}
