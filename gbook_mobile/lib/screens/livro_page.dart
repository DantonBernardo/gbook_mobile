import 'package:flutter/material.dart';
import 'package:gbook_mobile/theme/app_theme.dart';
import '../services/book_service.dart';
import '../models/book.dart';

class LivroPage extends StatefulWidget {
  final int id;

  const LivroPage({super.key, required this.id});

  @override
  State<LivroPage> createState() => _LivroPageState();
}

class _LivroPageState extends State<LivroPage> {
  late Future<Book> _futureBook;

  @override
  void initState() {
    super.initState();
    _futureBook = BookService().fetchBookById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Livro"),
        centerTitle: true,
        backgroundColor: AppTheme.secondary,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<Book>(
        future: _futureBook,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Livro não encontrado"));
          }

          final book = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (book.cover != null && book.cover!.isNotEmpty)
                  Center(
                    child: Semantics(
                      label: "Capa do livro ${book.title}",
                      image: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          book.cover!,
                          height: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 100),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Semantics(
                  header: true,
                  child: Center(
                    child: Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Semantics(
                  label: "Descrição do livro",
                  child: Text(
                    book.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  label: "Abrir PDF do livro ${book.title}",
                  button: true,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      debugPrint("Abrir PDF: ${book.pdfUrl}");
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Abrir PDF"),
                  ),
                ),
                const SizedBox(height: 12),
                if (book.userId != null)
                  Semantics(
                    label: "Informação adicional",
                    child: Text(
                      "Adicionado pelo usuário #${book.userId}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
