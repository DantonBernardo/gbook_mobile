import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pdfUrlController = TextEditingController();
  final BookService _bookService = BookService();

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      Book newBook = await _bookService.createBook(
        _titleController.text.trim(),
        _descriptionController.text.trim(),
        _pdfUrlController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Livro criado com sucesso!")),
        );
        Navigator.pop(context, newBook);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Livro"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Título
              TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  color: Colors.white,
                ), // texto digitado branco
                decoration: const InputDecoration(
                  labelText: "Título",
                  labelStyle: TextStyle(color: Colors.white), // label branca
                  hintText: "Digite o título",
                  hintStyle: TextStyle(
                    color: Colors.white70,
                  ), // placeholder branco suave
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ), // borda normal branca
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ), // borda ao focar
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Digite o título" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Descrição",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "Digite a descrição",
                  hintStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? "Digite a descrição"
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _pdfUrlController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Link do PDF",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "https://...",
                  hintStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite o link do PDF";
                  }
                  if (!value.startsWith("http")) {
                    return "O link deve começar com http ou https";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botão
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Salvar Livro"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
