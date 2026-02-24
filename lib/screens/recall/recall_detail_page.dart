import 'package:flutter/material.dart';
import 'package:formation_flutter/model/recall.dart';
import 'package:url_launcher/url_launcher.dart';

class RecallDetailPage extends StatelessWidget {
  const RecallDetailPage({super.key, required this.recall});

  final Recall recall;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du rappel'),
        actions: [
          if (recall.lienPdf != null && recall.lienPdf!.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: 'Ouvrir la fiche PDF',
              onPressed: () async {
                final url = Uri.parse(recall.lienPdf!);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // afficher l'image du produit (si dispo)
            if (recall.lienImage != null && recall.lienImage!.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    recall.lienImage!,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // infos principales sur le prod
            _buildSectionTitle('Produit'),
            _buildInfoRow('Libellé', recall.libelle),
            _buildInfoRow('Marque', recall.marqueProduit),
            _buildInfoRow('GTIN', recall.gtin),
            const Divider(height: 32),

            _buildSectionTitle('Commercialisation'),
            _buildInfoRow('Date de début', recall.dateDebutCommercialisation),
            _buildInfoRow('Date de fin', recall.dateFinCommercialisation),
            _buildInfoRow('Distributeurs', recall.distributeurs),
            _buildInfoRow('Zone géographique', recall.zoneGeographique),
            const Divider(height: 32),

            _buildSectionTitle('Motif et Risques'),
            _buildInfoRow('Motif du rappel', recall.motifRappel),
            _buildInfoRow('Risques encourus', recall.risquesEncourus),
            const Divider(height: 32),

            _buildSectionTitle('Recommandations'),
            _buildInfoRow('Conduite à tenir', recall.conduitesATenir),
            _buildInfoRow('Préconisations', recall.preconisationsSanitaires),
            _buildInfoRow(
              'Infos complémentaires',
              recall.informationsComplementaires,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF080040), // AppColors.blue
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    // l'api sépare parfois des listes avec des | donc fo formater avec des listes a puces
    final formattedValue = value.replaceAll('|', '\n• ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A6A6A), // AppColors.grey3
            ),
          ),
          const SizedBox(height: 2),
          Text(
            formattedValue.contains('\n')
                ? '• $formattedValue'
                : formattedValue,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
