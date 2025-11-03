import 'package:gbook_mobile/domain/entities/book.dart';

abstract class BookDetailState {}

class BookDetailInitial extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final Book book;
  BookDetailLoaded(this.book);
}

class BookDetailError extends BookDetailState {
  final String message;
  BookDetailError(this.message);
}