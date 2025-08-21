import 'package:flutter/material.dart';
import 'package:gbook_mobile/theme/app_theme.dart';

class ExpandableMenu extends StatefulWidget {
  final Widget child;

  const ExpandableMenu({super.key, required this.child});

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
                    style: AppTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                ListTile(
                  title: Text(
                    'Biblioteca', 
                    style: AppTheme.bodyLarge
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/biblioteca');
                  },
                ),
                ListTile(
                  title: Text(
                    'Perfil', 
                    style: AppTheme.bodyLarge
                  )
                ),
                ListTile(
                  title: Text(
                    'Livros salvos', 
                    style: AppTheme.bodyLarge
                  )
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
                // Aqui você vai injetar a AppBar depois
                Expanded(child: widget.child),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
