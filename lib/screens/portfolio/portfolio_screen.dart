import 'package:technolenz/exports.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  PortfolioCategory? _selectedCategory;
  UseCase? _selectedUseCase;
  TechStack? _selectedTechStack;
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<PortfolioItem> get _filteredItems {
    return PortfolioConstants.portfolioItems.where((item) {
      final matchesCategory = _selectedCategory == null || item.category == _selectedCategory;
      final matchesUseCase = _selectedUseCase == null || item.useCases.contains(_selectedUseCase);
      final matchesTechStack =
          _selectedTechStack == null || item.techStack.contains(_selectedTechStack);
      final matchesSearch =
          _searchQuery.isEmpty ||
          item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.shortDescription.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesUseCase && matchesTechStack && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filteredItems = _filteredItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed:
                () =>
                    showSearch(context: context, delegate: PortfolioSearchDelegate(_filteredItems)),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Work',
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A curated selection of my projects and case studies',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PortfolioFilter(
                    selectedCategory: _selectedCategory,
                    selectedUseCase: _selectedUseCase,
                    selectedTechStack: _selectedTechStack,
                    onCategorySelected: (category) => setState(() => _selectedCategory = category),
                    onUseCaseSelected: (useCase) => setState(() => _selectedUseCase = useCase),
                    onTechStackSelected:
                        (techStack) => setState(() => _selectedTechStack = techStack),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search projects...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (filteredItems.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.work_outline,
                            size: 64,
                            color: theme.colorScheme.onSurface.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text('No projects found', style: theme.textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters or search query',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (filteredItems.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 1000
                          ? 3
                          : MediaQuery.of(context).size.width > 600
                          ? 2
                          : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => PortfolioCardItem(
                    item: filteredItems[index],
                    onTap: () => _showProjectDetails(context, filteredItems[index]),
                  ),
                  childCount: filteredItems.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showProjectDetails(BuildContext context, PortfolioItem item) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProjectDetailsScreen(item: item),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }
}

class PortfolioSearchDelegate extends SearchDelegate {
  final List<PortfolioItem> items;

  PortfolioSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        items
            .where(
              (item) =>
                  item.title.toLowerCase().contains(query.toLowerCase()) ||
                  item.shortDescription.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return _buildSearchResults(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        items
            .where(
              (item) =>
                  item.title.toLowerCase().contains(query.toLowerCase()) ||
                  item.shortDescription.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return _buildSearchResults(context, suggestions);
  }

  Widget _buildSearchResults(BuildContext context, List<PortfolioItem> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading:
              item.imageUrls.isNotEmpty
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.imageUrls.first,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                  : const Icon(Icons.work),
          title: Text(item.title),
          subtitle: Text(item.shortDescription),
          onTap: () {
            close(context, null);
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => ProjectDetailsScreen(item: item)));
          },
        );
      },
    );
  }
}
