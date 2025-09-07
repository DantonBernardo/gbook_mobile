import 'package:flutter/material.dart';
import 'package:gbook_mobile/theme/app_theme.dart';

class ExpandableMenu extends StatefulWidget {
  final Widget child;
  final bool isDarkTheme;
  final VoidCallback onThemeToggle;

  const ExpandableMenu({
    super.key, 
    required this.child,
    required this.isDarkTheme,
    required this.onThemeToggle,
  });

  @override
  ExpandableMenuState createState() => ExpandableMenuState();
}

class ExpandableMenuState extends State<ExpandableMenu> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      isMenuOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Menu lateral
        Container(
          width: screenWidth * 0.7,
          color: AppTheme.darkerPrimary,
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Home',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Sempre branco no menu lateral
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                ListTile(
                  title: Text(
                    'Biblioteca',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Sempre branco no menu lateral
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/biblioteca');
                  },
                ),
                ListTile(
                  title: Text(
                    'Adicionar livro',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Sempre branco no menu lateral
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/addBook');
                  },
                ),
              ],
            ),
          ),
        ),
        // Conteúdo principal
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: isMenuOpen ? screenWidth * 0.6 : 0,
          top: 0,
          bottom: 0,
          right: isMenuOpen ? -screenWidth * 0.6 : 0,
          child: Material(
            elevation: 8,
            child: Column(
              children: [
                Expanded(child: widget.child),
              ],
            ),
          ),
        ),
        // Botão de alternância de tema
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: AppTheme.primary,
            onPressed: widget.onThemeToggle,
            child: Icon(
              widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}