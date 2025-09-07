import 'package:flutter/material.dart';
import 'package:gbook_mobile/theme/app_theme.dart';
import 'app_logo.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../controllers/search_controller.dart' as search;
import '../screens/livro_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback? onSearchPressed;
  final Function(String)? onSearchChanged;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
    this.onSearchPressed,
    this.onSearchChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _animation;
  OverlayEntry? _overlayEntry;

  final search.SearchController _searchStreamController = search.SearchController();
  final BookService _bookService = BookService();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _searchController.addListener(() {
      setState(() {}); // Atualiza ícone de limpar
      _searchStreamController.updateSearch(_searchController.text);
      if (widget.onSearchChanged != null) {
        widget.onSearchChanged!(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    _searchStreamController.dispose();
    super.dispose();
  }

  void _createOverlay() {
    _removeOverlay(); // Evita duplicar overlay

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 60,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              SizeTransition(
                sizeFactor: _animation,
                child: Container(
                  height: 50,
                  color: AppTheme.background,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Digite sua pesquisa...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.white, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.white),
                              onPressed: () {
                                _searchController.clear();
                                _searchStreamController.updateSearch('');
                                if (widget.onSearchChanged != null) {
                                  widget.onSearchChanged!('');
                                }
                              },
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
              ),
              _buildSearchResults(),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildSearchResults() {
    return StreamBuilder<String>(
      stream: _searchStreamController.searchStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        return FutureBuilder<List<Book>>(
          future: _bookService.searchBooks(snapshot.data!),
          builder: (context, bookSnapshot) {
            if (bookSnapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 60,
                color: AppTheme.background.withOpacity(0.95),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              );
            }

            if (bookSnapshot.hasError) {
              return Container(
                height: 60,
                color: AppTheme.background.withOpacity(0.95),
                child: Center(
                  child: Text(
                    'Erro na busca: ${bookSnapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }

            final books = bookSnapshot.data ?? [];

            if (books.isEmpty) {
              return Container(
                height: 60,
                color: AppTheme.background.withOpacity(0.95),
                child: const Center(
                  child: Text(
                    'Nenhum resultado encontrado',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              );
            }

            return Container(
              constraints: const BoxConstraints(maxHeight: 300),
              color: AppTheme.background.withOpacity(0.95),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return ListTile(
                    title: Text(
                      book.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: const Icon(
                      Icons.book,
                      color: Colors.white70,
                    ),
                    onTap: () {
                      _searchController.text = book.title;
                      _toggleSearch();

                      // Navega para a página do livro
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LivroPage(id: book.id),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
    });

    if (_isSearchVisible) {
      _createOverlay();
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 100), () {
        _searchFocusNode.requestFocus();
      });
    } else {
      _animationController.reverse().then((_) {
        _removeOverlay();
      });
      _searchController.clear();
      _searchFocusNode.unfocus();
      _searchStreamController.updateSearch('');
    }

    if (widget.onSearchPressed != null) {
      widget.onSearchPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.background,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: widget.onMenuPressed,
      ),
      title: const AppLogo(size: 60),
      actions: [
        IconButton(
          icon: Icon(
            _isSearchVisible ? Icons.close : Icons.search,
            color: Colors.white,
          ),
          onPressed: _toggleSearch,
        ),
      ],
    );
  }
}
