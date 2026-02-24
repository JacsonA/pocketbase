import 'package:pocketbase/pocketbase.dart';

class Recall {
  Recall({
    required this.id,
    required this.gtin,
    this.numeroFiche,
    this.libelle,
    this.marqueProduit,
    this.motifRappel,
    this.risquesEncourus,
    this.dateDebutCommercialisation,
    this.dateFinCommercialisation,
    this.distributeurs,
    this.zoneGeographique,
    this.conduitesATenir,
    this.informationsComplementaires,
    this.preconisationsSanitaires,
    this.lienImage,
    this.lienPdf,
    this.datePublication,
  });

  // permet de transfo le json repondu par pb direct en obj dart
  factory Recall.fromRecord(RecordModel record) {
    return Recall(
      id: record.id,
      gtin: record.getStringValue('gtin'),
      numeroFiche: record.getStringValue('numero_fiche'),
      libelle: record.getStringValue('libelle'),
      marqueProduit: record.getStringValue('marque_produit'),
      motifRappel: record.getStringValue('motif_rappel'),
      risquesEncourus: record.getStringValue('risques_encourus'),
      dateDebutCommercialisation: record.getStringValue(
        'date_debut_commercialisation',
      ),
      dateFinCommercialisation: record.getStringValue(
        'date_fin_commercialisation',
      ),
      distributeurs: record.getStringValue('distributeurs'),
      zoneGeographique: record.getStringValue('zone_geographique'),
      conduitesATenir: record.getStringValue('conduites_a_tenir'),
      informationsComplementaires: record.getStringValue(
        'informations_complementaires',
      ),
      preconisationsSanitaires: record.getStringValue(
        'preconisations_sanitaires',
      ),
      lienImage: record.getStringValue('lien_image'),
      lienPdf: record.getStringValue('lien_pdf'),
      datePublication: record.getStringValue('date_publication'),
    );
  }

  final String id;
  final String gtin;
  final String? numeroFiche;
  final String? libelle;
  final String? marqueProduit;
  final String? motifRappel;
  final String? risquesEncourus;
  final String? dateDebutCommercialisation;
  final String? dateFinCommercialisation;
  final String? distributeurs;
  final String? zoneGeographique;
  final String? conduitesATenir;
  final String? informationsComplementaires;
  final String? preconisationsSanitaires;
  final String? lienImage;
  final String? lienPdf;
  final String? datePublication;
}
