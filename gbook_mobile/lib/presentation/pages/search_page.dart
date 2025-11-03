import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/book_remote_datasource.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/usecases/search_books.dart';
import '../../theme/app_theme.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/search/search_event.dart' as search_events;
import '../bloc/search/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    final dataSource = BookRemoteDataSourceImpl(client: http.Client());
    final repository = BookRepositoryImpl(remoteDataSource: dataSource);
    final searchBooks = SearchBooks(repository);
    _searchBloc = SearchBloc(searchBooks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchBloc.close();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      _searchBloc.add(search_events.SearchBooks(query));
    } else {
      _searchBloc.add(search_events.ClearSearch());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Buscar livros...',
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 18,
            ),
            onChanged: (query) {
              // Busca em tempo real com debounce simples
              Future.delayed(const Duration(milliseconds: 500), () {
                if (_searchController.text == query) {
                  _performSearch(query);
                }
              });
            },
            onSubmitted: _performSearch,
          ),
          actions: [
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _searchBloc.add(search_events.ClearSearch());
                },
              ),
          ],
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 80,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Pesquise por livros',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Digite o nome do livro para buscar',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SearchLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
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
                      'Buscando...',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SearchEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nenhum resultado encontrado',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tente buscar com outros termos',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SearchLoaded) {
              final books = state.books;
              final colors = [
                AppTheme.primary,
                AppTheme.info,
                AppTheme.error,
                AppTheme.success,
                AppTheme.warning,
                AppTheme.accent,
              ];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${books.length} ${books.length == 1 ? "resultado encontrado" : "resultados encontrados"}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        final cardColor = colors[index % colors.length];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Card(
                            elevation: 2,
                            shadowColor: cardColor.withOpacity(0.2),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/book-detail',
                                  arguments: book.id,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border(
                                    left: BorderSide(
                                      color: cardColor,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    Container(
                                      width: 60,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            cardColor.withOpacity(isDark ? 0.3 : 0.15),
                                            cardColor.withOpacity(isDark ? 0.2 : 0.08),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.menu_book,
                                        color: cardColor,
                                        size: 32,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              book.title,
                                              style: theme.textTheme.titleLarge,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              book.description,
                                              style: theme.textTheme.bodyMedium,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: cardColor.withOpacity(0.5),
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is SearchError) {
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
                        'Erro na busca',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppTheme.error,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          _performSearch(_searchController.text);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tentar Novamente'),
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