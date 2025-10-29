import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onMenuPressed,
        tooltip: 'Menu',
      ),
      title: Center(
        child: Image.asset(
          'assets/images/gbook_logo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO: Implementar busca futura
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Busca em desenvolvimento')),
            );
          },
          tooltip: 'Buscar',
        ),
      ],
    );
  }
}

class PageWithMenu extends StatefulWidget {
  final Widget child;
  final String title;

  const PageWithMenu({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  State<PageWithMenu> createState() => _PageWithMenuState();
}

class _PageWithMenuState extends State<PageWithMenu> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onMenuPressed: _toggleMenu),
      body: Stack(
        children: [
          widget.child,
          if (_isMenuOpen)
            ExpandableMenu(
              onClose: _toggleMenu,
            ),
        ],
      ),
    );
  }
}

class ExpandableMenu extends StatefulWidget {
  final VoidCallback onClose;

  const ExpandableMenu({
    super.key,
    required this.onClose,
  });

  @override
  State<ExpandableMenu> createState() => _ExpandableMenuState();
}

class _ExpandableMenuState extends State<ExpandableMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateTo(BuildContext context, String route) {
    _controller.reverse().then((_) {
      widget.onClose();
      Navigator.pushNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _controller.reverse().then((_) => widget.onClose());
          },
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                color: Colors.black.withOpacity(0.5 * _animation.value),
              );
            },
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-250 * (1 - _animation.value), 0),
                child: child,
              );
            },
            child: Container(
              width: 250,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/gbook_logo.png',
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Menu',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        _MenuItemTile(
                          icon: Icons.library_books,
                          title: 'Biblioteca',
                          subtitle: 'Todos os livros',
                          onTap: () => _navigateTo(context, '/all-books'),
                        ),
                        _MenuItemTile(
                          icon: Icons.add_box,
                          title: 'Criar Livro',
                          subtitle: 'Adicionar novo livro',
                          onTap: () => _navigateTo(context, '/create-book'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItemTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}