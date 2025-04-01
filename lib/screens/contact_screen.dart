import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:technolenz/exports.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ResumeViewer(),
          const SizedBox(height: 60),
          const ContactForm(),
          const SizedBox(height: 60),
          const Footer(),
        ],
      ),
    );
  }
}

class ResumeViewer extends StatefulWidget {
  const ResumeViewer({super.key});

  @override
  State<ResumeViewer> createState() => _ResumeViewerState();
}

class _ResumeViewerState extends State<ResumeViewer> {
  late PdfControllerPinch _pdfController;
  bool _isLoading = true;
  bool _isHovering = false;
  int _currentPage = 1;
  int? _totalPages;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final data = await rootBundle.load('assets/resume.pdf');
      _pdfController = PdfControllerPinch(
        document: PdfDocument.openData(data.buffer.asUint8List()),
        initialPage: 1,
      )..addListener(() {
        if (_pdfController.pagesCount != null && _totalPages == null) {
          setState(() => _totalPages = _pdfController.pagesCount);
        }
        if (_pdfController.page != _currentPage) {
          setState(() => _currentPage = _pdfController.page.round());
        }
      });

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackbar("Failed to load resume: ${e.toString()}");
    }
  }

  Future<void> _downloadResume() async {
    try {
      final data = await rootBundle.load('assets/resume.pdf');
      final bytes = data.buffer.asUint8List();

      if (kIsWeb) {
        final blob = html.Blob([bytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor =
            html.AnchorElement(href: url)
              ..download = 'technolenz_resume_${DateTime.now().year}.pdf'
              ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        // For mobile/desktop using file_saver package
        await FileSaver.instance.saveFile(
          name: 'technolenz_resume_${DateTime.now().year}',
          bytes: bytes,
          ext: 'pdf',
          mimeType: MimeType.pdf,
        );
      }
    } catch (e) {
      _showErrorSnackbar("Failed to download resume: ${e.toString()}");
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MY RESUME",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Professional Experience & Skills",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
                  child: ElevatedButton.icon(
                    onPressed: _downloadResume,
                    icon: const Icon(FontAwesomeIcons.download, size: 16),
                    label: const Text("Download CV"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          if (_isLoading)
            Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text("Loading resume...", style: theme.textTheme.bodyMedium),
                ],
              ),
            )
          else
            Container(
              height: 600,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    PdfViewPinch(
                      controller: _pdfController,
                      scrollDirection: Axis.vertical,
                      onDocumentError:
                          (error) =>
                              _showErrorSnackbar("Error displaying PDF: ${error.toString()}"),
                      onDocumentLoaded: (document) {
                        setState(() => _totalPages = document.pagesCount);
                      },
                    ),
                    if (_totalPages != null)
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Page $_currentPage of $_totalPages',
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          if (!_isLoading && _totalPages != null) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed:
                      _currentPage > 1
                          ? () => _pdfController.animateToPage(
                            pageNumber: _currentPage - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          )
                          : null,
                ),
                ...List.generate(
                  _totalPages!.clamp(0, 5),
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap:
                          () => _pdfController.animateToPage(
                            pageNumber: index + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              _currentPage == index + 1
                                  ? theme.colorScheme.primary
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                _currentPage == index + 1 ? Colors.transparent : theme.dividerColor,
                          ),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color:
                                _currentPage == index + 1
                                    ? Colors.white
                                    : theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed:
                      _currentPage < _totalPages!
                          ? () => _pdfController.animateToPage(
                            pageNumber: _currentPage + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          )
                          : null,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      final emailUri = Uri(
        scheme: 'mailto',
        path: 'technolenz@gmail.com',
        queryParameters: {
          'subject': 'Contact from Portfolio',
          'body': '''
Name: ${_nameController.text}
Email: ${_emailController.text}
Message: ${_messageController.text}
          ''',
        },
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
        _formKey.currentState!.reset();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Email app opened successfully")));
      } else {
        throw Exception("Could not launch email app");
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to open email app")));
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          const Text("Get In Touch", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            "Have a project or question? I'd love to hear from you!",
            style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
          ),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Your Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return "Please enter your email";
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: "Your Message",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  maxLines: 5,
                  validator: (value) => value!.isEmpty ? "Please enter your message" : null,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _sendEmail,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child:
                        _isSending
                            ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                            : const Text("Send Message", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const Text("Let's Connect", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(
            "Feel free to reach out for collaborations or just a friendly hello",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: "https://linkedin.com/in/technolenz",
                tooltip: "LinkedIn",
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.github,
                url: "https://github.com/technolenz",
                tooltip: "GitHub",
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.twitter,
                url: "https://twitter.com/@miclenzy",
                tooltip: "Twitter",
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.envelope,
                url: "mailto:technolenz@gmail.com",
                tooltip: "Email",
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(height: 1),
          const SizedBox(height: 20),
          const Text(
            "© 2025 Technolenz. All rights reserved.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  final String tooltip;

  const _SocialIcon({required this.icon, required this.url, required this.tooltip, super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: FaIcon(icon, size: 24),
        color: isDarkMode ? Colors.white : Colors.black87,
        onPressed: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Could not open $tooltip")));
          }
        },
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
          ),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
