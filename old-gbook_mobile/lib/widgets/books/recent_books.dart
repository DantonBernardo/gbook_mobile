import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/book.dart';
import '../../screens/livro_page.dart'; // Import da página de detalhes do livro

class BookCarousel extends StatefulWidget {
  final Future<List<Book>> booksFuture;

  const BookCarousel({super.key, required this.booksFuture});

  @override
  State<BookCarousel> createState() => _BookCarouselState();
}

class _BookCarouselState extends State<BookCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    // Detecta se é tema escuro ou claro
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    
    // Define as cores baseado no tema
    final textColor = isDark ? const Color(0xFFF4F0F0) : const Color(0xFF1A1A1A);
    final titleColor = isDark ? const Color(0xFFF4F0F0) : const Color(0xFF1A1A1A);

    return FutureBuilder<List<Book>>(
      future: widget.booksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(
            'Erro ao carregar livros',
            style: TextStyle(color: textColor),
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(
            'Nenhum livro encontrado.',
            style: TextStyle(color: textColor),
          ));
        } else {
          final books = snapshot.data!;
          final int itemsPerPage = 1;
          final int pageCount = (books.length / itemsPerPage).ceil();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Título centralizado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Center(
                  child: Text(
                    'Livros recentes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Carousel
              CarouselSlider.builder(
                itemCount: pageCount,
                itemBuilder: (context, pageIndex, realIndex) {
                  final start = pageIndex * itemsPerPage;
                  final end = (start + itemsPerPage).clamp(0, books.length);
                  final pageItems = books.sublist(start, end);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pageItems.map((book) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navega para a página de detalhes do livro
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LivroPage(id: book.id),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/images/books/noCover.jpg',
                                    height: 180,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8), // Espaço entre imagem e título
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    book.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.95,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  height: 250,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 8),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),

              // Bolinhas de controle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pageCount, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _current == index ? 12 : 8,
                    height: _current == index ? 12 : 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? textColor : textColor.withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ],
          );
        }
      },
    );
  }
}