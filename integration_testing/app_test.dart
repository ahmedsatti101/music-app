import 'package:demo_music_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('main.dart', () {
    testWidgets('Test search bar is visible', (tester) async {
      app.main();
      await tester.pumpAndSettle();
    });
  });
}