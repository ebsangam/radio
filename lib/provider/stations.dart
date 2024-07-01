import 'package:fuzzy/fuzzy.dart';
import 'package:radio/radio_station.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stations.g.dart';

@riverpod
class Stations extends _$Stations {
  final fuzzy = Fuzzy<RadioStation>(
    radioStations,
    options: FuzzyOptions(
      keys: [
        WeightedKey(
          name: 'name',
          getter: (obj) => obj.name,
          weight: 0.6,
        ),
        WeightedKey(
          name: 'frequency',
          getter: (obj) => obj.frequency?.toString() ?? '',
          weight: 0.3,
        ),
        WeightedKey(
          name: 'address',
          getter: (obj) => obj.address ?? '',
          weight: 0.1,
        ),
      ],
    ),
  );

  @override
  List<RadioStation> build() {
    return radioStations;
  }

  void search(String pattern) {
    final trimmed = pattern.trim();
    if (trimmed.isEmpty) state = radioStations;
    state = fuzzy.search(trimmed).map((e) => e.item).toList();
  }
}
