import 'dart:async';

class SearchController {
  final StreamController<String> _searchController = StreamController<String>.broadcast();
  Timer? _debounceTimer;

  // Stream que emite as queries de busca
  Stream<String> get searchStream => _searchController.stream;

  void updateSearch(String query) {
    // Cancela o timer anterior se existir
    _debounceTimer?.cancel();
    
    // Cria um novo timer com 1 segundo de delay
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      _searchController.add(query);
    });
  }

  void dispose() {
    _debounceTimer?.cancel();
    _searchController.close();
  }
}