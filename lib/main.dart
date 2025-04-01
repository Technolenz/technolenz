import 'exports.dart';

Future<void> main() async {
  // 1. Ensure Flutter binding is initialized first
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Configure channel buffering for critical plugins
  _configureChannelBuffers();
  runApp(
    ErrorWidgetBuilder(
      child: ChangeNotifierProvider(create: (_) => ThemeProvider(), child: const TechnolenzApp()),
    ),
  );
}

void _configureChannelBuffers() {
  // Configure channels that might send early messages
  const channel = MethodChannel('flutter/lifecycle');
  ServicesBinding.instance.defaultBinaryMessenger.setMessageHandler(channel.name, (message) async {
    // Handle or buffer the message appropriately
    return null;
  });
}

class ErrorWidgetBuilder extends StatelessWidget {
  final Widget child;

  const ErrorWidgetBuilder({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 50, color: Colors.red),
                    const SizedBox(height: 20),
                    Text('Something went wrong!', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 30),
                    ElevatedButton(onPressed: () => main(), child: const Text('Restart App')),
                  ],
                ),
              ),
            ),
          );
        };
        return widget ?? const SizedBox.shrink();
      },
      home: child,
    );
  }
}

class TechnolenzApp extends StatefulWidget {
  const TechnolenzApp({super.key});

  @override
  State<TechnolenzApp> createState() => _TechnolenzAppState();
}

class _TechnolenzAppState extends State<TechnolenzApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Technolenz',
          theme: themeProvider.themeData,
          home: const SafeArea(child: MainPage()),
        );
      },
    );
  }
}
