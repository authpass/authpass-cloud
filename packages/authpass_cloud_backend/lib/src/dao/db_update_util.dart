import 'package:postgres/postgres.dart';

class DbUpdateTracker {
  DbUpdateTracker(this.prefix);
  DbUpdateTracker.merge(List<DbUpdateTracker> tracker) : prefix = '' {
    results.addEntries(
      tracker.expand(
        (e) => e.results.entries.map(
          (entry) => MapEntry(
            [e.prefix, entry.key].join('.'),
            entry.value,
          ),
        ),
      ),
    );
  }

  final String prefix;

  final Map<String, ({int affectedRowCount})> results = {};

  Future<void> track(
      String label, Future<PostgreSQLResult> Function() run) async {
    final result = await run();
    results[label] = (affectedRowCount: result.affectedRowCount);
  }
}
