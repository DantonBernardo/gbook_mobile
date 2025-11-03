import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/book_remote_datasource.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/usecases/get_book_by_id.dart';
import '../../theme/app_theme.dart';
import '../bloc/books/bloc/book_detail/book_detail_bloc.dart';
import '../bloc/books/bloc/book_detail/book_detail_event.dart';
import '../bloc/books/bloc/book_detail/book_detail_state.dart';

class BookDetailPage extends StatelessWidget {
  final int bookId;

  const BookDetailPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final dataSource = BookRemoteDataSourceImpl(client: http.Client());
    final repository = BookRepositoryImpl(remoteDataSource: dataSource);
    final getBookById = GetBookById(repository);

    return BlocProvider(
      create: (_) => BookDetailBloc(getBookById)..add(LoadBookDetail(bookId)),
      child: Scaffold(
        body: BlocBuilder<BookDetailBloc, BookDetailState>(
          builder: (context, state) {
            if (state is BookDetailLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Carregando detalhes...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              );
            } else if (state is BookDetailLoaded) {
              final book = state.book;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppTheme.primary,
                              AppTheme.primary.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.menu_book,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.description,
                                        color: AppTheme.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Descrição',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    book.description,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.info_outline,
                                        color: AppTheme.info,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Informações',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  _InfoRow(
                                    icon: Icons.tag,
                                    label: 'ID',
                                    value: '#${book.id}',
                                  ),
                                  const Divider(height: 24),
                                  _InfoRow(
                                    icon: Icons.picture_as_pdf,
                                    label: 'PDF',
                                    value: book.pdfUrl.isNotEmpty
                                        ? 'Disponível'
                                        : 'Não disponível',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (book.pdfUrl.isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Ação para abrir o PDF
                                },
                                icon: const Icon(Icons.picture_as_pdf),
                                label: const Text('Abrir PDF'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is BookDetailError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.error.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: AppTheme.error,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Erro ao carregar detalhes',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.error,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<BookDetailBloc>().add(LoadBookDetail(bookId));
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tentar Novamente'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Voltar'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}