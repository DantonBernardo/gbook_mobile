import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomPdfButton extends StatelessWidget {
  final String pdfUrl;

  const CustomPdfButton({super.key, required this.pdfUrl});

  Future<void> _openPdf() async {
    final uri = Uri.parse(pdfUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Não foi possível abrir o PDF: $pdfUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
      onPressed: _openPdf,
    );
  }
}
