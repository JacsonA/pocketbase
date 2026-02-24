import 'package:flutter/material.dart';
import 'package:formation_flutter/model/recall.dart';

class RecallBanner extends StatelessWidget {
  const RecallBanner({super.key, required this.recall, this.onTap});

  final Recall recall;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Material(
        color: const Color(0x5CFF0000), // c le rouge transparent 36%
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFA60000), // rouge bcp plus for
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RAPPEL PRODUIT',
                        style: TextStyle(
                          color: Color(0xFFA60000),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recall.motifRappel ??
                            'Ce produit fait l\'objet d\'un rappel.',
                        style: const TextStyle(
                          color: Color(0xFFA60000),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
