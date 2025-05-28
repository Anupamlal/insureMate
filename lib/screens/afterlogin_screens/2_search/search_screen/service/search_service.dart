import 'dart:ui';

import 'package:insure_mate/db_helper/shared_preference/app_shared_preference.dart';

class SearchService {

  List<String> _recentSearches = [];

  SearchService() {
    _fetchRecentSearches();
  }

  List<String> getRecentSearches() => _recentSearches;

  void _fetchRecentSearches() async {
    final allSearchesList = await AppSharedPreference.getRecentSearchesList();
    _recentSearches = allSearchesList ?? [];
  }

  void updateRecentSearches(String term, VoidCallback refreshSearchList) {
    final existing = _recentSearches.indexWhere((t) => t.toLowerCase() == term.toLowerCase());
    if (existing != -1) _recentSearches.removeAt(existing);
    _recentSearches.insert(0, term);
    if (_recentSearches.length > 6) _recentSearches.removeLast();
    AppSharedPreference.saveRecentSearchesList(_recentSearches);

    refreshSearchList();
  }
}