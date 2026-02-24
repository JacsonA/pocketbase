/// <reference path="../pb_data/types.d.ts" />

// migration : création de la collection "rappels"
migrate(
  (app) => {
    const collection = new Collection({
      name: "rappels",
      type: "base",
      listRule: "",
      viewRule: "",
      fields: [
        {
          name: "gtin",
          type: "text",
          required: true,
        },
        {
          name: "numero_fiche",
          type: "text",
          required: false,
        },
        {
          name: "libelle",
          type: "text",
          required: false,
        },
        {
          name: "marque_produit",
          type: "text",
          required: false,
        },
        {
          name: "motif_rappel",
          type: "text",
          required: false,
        },
        {
          name: "risques_encourus",
          type: "text",
          required: false,
        },
        {
          name: "date_debut_commercialisation",
          type: "text",
          required: false,
        },
        {
          name: "date_fin_commercialisation",
          type: "text",
          required: false,
        },
        {
          name: "distributeurs",
          type: "text",
          required: false,
        },
        {
          name: "zone_geographique",
          type: "text",
          required: false,
        },
        {
          name: "conduites_a_tenir",
          type: "text",
          required: false,
        },
        {
          name: "informations_complementaires",
          type: "text",
          required: false,
        },
        {
          name: "preconisations_sanitaires",
          type: "text",
          required: false,
        },
        {
          name: "lien_image",
          type: "url",
          required: false,
        },
        {
          name: "lien_pdf",
          type: "url",
          required: false,
        },
        {
          name: "date_publication",
          type: "text",
          required: false,
        },
      ],
      indexes: ["CREATE INDEX idx_rappels_gtin ON rappels (gtin)"],
    });

    app.save(collection);
  },
  (app) => {
    const collection = app.findCollectionByNameOrId("rappels");
    app.delete(collection);
  },
);
