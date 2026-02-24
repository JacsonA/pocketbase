/// <reference path="../pb_data/types.d.ts" />

// cron : ca tourne tt seul 2x/jour
cronAdd("rappels_sync", "0 */12 * * *", () => {
  console.log("=== Début sync rappels ===");

  const url = "https://codelabs.formation-flutter.fr/assets/rappels.json";
  let data;

  try {
    const res = $http.send({
      url: url,
      method: "GET",
      timeout: 60,
    });
    data = JSON.parse(res.raw);
  } catch (err) {
    console.log("Erreur fetch rappels: " + err);
    return;
  }

  const collection = $app.findCollectionByNameOrId("rappels");

  for (const item of data) {
    const gtin = String(item.gtin || "");
    if (!gtin) continue;
    const numeroFiche = item.numero_fiche || "";
    try {
      let record;
      try {
        record = $app.findFirstRecordByFilter(
          "rappels",
          "gtin = {:gtin} && numero_fiche = {:fiche}",
          { gtin: gtin, fiche: numeroFiche }
        );
      } catch (err2) {
        record = new Record(collection);
      }
      record.set("gtin", gtin);
      record.set("numero_fiche", numeroFiche);
      record.set("libelle", item.libelle || "");
      record.set("marque_produit", item.marque_produit || "");
      record.set("motif_rappel", item.motif_rappel || "");
      record.set("risques_encourus", item.risques_encourus || "");
      record.set("date_debut_commercialisation", item.date_debut_commercialisation || "");
      record.set("date_fin_commercialisation", item.date_date_fin_commercialisation || "");
      record.set("distributeurs", item.distributeurs || "");
      record.set("zone_geographique", item.zone_geographique_de_vente || "");
      record.set("conduites_a_tenir", item.conduites_a_tenir_par_le_consommateur || "");
      record.set("informations_complementaires", item.informations_complementaires || "");
      record.set("preconisations_sanitaires", item.preconisations_sanitaires || "");
      record.set("lien_image", item.liens_vers_les_images || "");
      record.set("lien_pdf", item.lien_vers_affichette_pdf || "");
      record.set("date_publication", item.date_publication || "");
      $app.save(record);
    } catch (err) {
      console.log("Erreur pour gtin " + gtin + ": " + err);
    }
  }
  console.log("=== Sync terminée ===");
});

// ptite route manuelle si jve lancer la sync moi mm depuis lnavigateur
routerAdd("GET", "/api/sync-rappels", (e) => {
  try {
    console.log("=== Début sync rappels (manuelle) ===");
    const url = "https://codelabs.formation-flutter.fr/assets/rappels.json";
    const res = $http.send({ url: url, method: "GET", timeout: 60 });
    const data = JSON.parse(res.raw);
    const collection = $app.findCollectionByNameOrId("rappels");
    
    let created = 0;
    let updated = 0;

    for (const item of data) {
      const gtin = String(item.gtin || "");
      if (!gtin) continue;
      const numeroFiche = item.numero_fiche || "";
      try {
        let record;
        let isNew = false;
        try {
          record = $app.findFirstRecordByFilter(
            "rappels",
            "gtin = {:gtin} && numero_fiche = {:fiche}",
            { gtin: gtin, fiche: numeroFiche }
          );
        } catch (err2) {
          record = new Record(collection);
          isNew = true;
        }
        record.set("gtin", gtin);
        record.set("numero_fiche", numeroFiche);
        record.set("libelle", item.libelle || "");
        record.set("marque_produit", item.marque_produit || "");
        record.set("motif_rappel", item.motif_rappel || "");
        record.set("risques_encourus", item.risques_encourus || "");
        record.set("date_debut_commercialisation", item.date_debut_commercialisation || "");
        record.set("date_fin_commercialisation", item.date_date_fin_commercialisation || "");
        record.set("distributeurs", item.distributeurs || "");
        record.set("zone_geographique", item.zone_geographique_de_vente || "");
        record.set("conduites_a_tenir", item.conduites_a_tenir_par_le_consommateur || "");
        record.set("informations_complementaires", item.informations_complementaires || "");
        record.set("preconisations_sanitaires", item.preconisations_sanitaires || "");
        record.set("lien_image", item.liens_vers_les_images || "");
        record.set("lien_pdf", item.lien_vers_affichette_pdf || "");
        record.set("date_publication", item.date_publication || "");
        $app.save(record);
        if (isNew) created++; else updated++;
      } catch (err) {
        // ignore
      }
    }
    return e.json(200, { success: true, created: created, updated: updated });
  } catch (err) {
    return e.json(500, { error: String(err) });
  }
});
