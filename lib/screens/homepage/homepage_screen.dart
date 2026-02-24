import 'package:flutter/material.dart';
import 'package:formation_flutter/l10n/app_localizations.dart';
import 'package:formation_flutter/res/app_icons.dart';
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
        actions: <Widget>[
          IconButton(
            onPressed: () => _onScanButtonPressed(context),
            icon: Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: Icon(AppIcons.barcode),
            ),
          ),
        ],
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
            // bton pr annul
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // g géré l cas ou le mec clik alor ki a ri1 ecri pour pa ksa crash
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
