class Book {
  final int id;
  final String title;
  final String description;
  final String? cover;
  final String pdfUrl;
  final int? userId;

  Book({
    required this.id,
    required this.title,
    required this.description,
    this.cover,
    required this.pdfUrl,
    this.userId,
  });

  // Construtor que cria um Book a partir de JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      cover: json['cover'],
      pdfUrl: json['pdf_url'],
      userId: json['userId'],
    );
  }

  // Transforma o objeto Book em JSON (para enviar para API)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "cover": cover,
      "pdf_url": pdfUrl,
      "userId": userId,
    };
  }
}
