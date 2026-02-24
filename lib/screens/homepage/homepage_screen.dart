import 'package:flutter/material.dart';
import 'package:formation_flutter/l10n/app_localizations.dart';
import 'package:formation_flutter/screens/homepage/homepage_empty.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.my_scans_screen_title),
        centerTitle: false,
      ),
      body: HomePageEmpty(onScan: () => _onScanButtonPressed(context)),
    );
  }

  void _onScanButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String barcode = '';
        return AlertDialog(
          title: const Text('Entrez un code-barres'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Ex : 3383883752028 (Rappel)",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => barcode = value,
          ),
          actions: [
            // bouton pr annuler
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // check si c'est pas vide pr éviter de push un truc vide
                if (barcode.isNotEmpty) {
                  context.push('/product', extra: barcode);
                }
              },
              child: const Text('Chercher'),
            ),
          ],
        );
      },
    );
  }
}
