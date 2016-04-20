# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160419212717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amino_acids", force: :cascade do |t|
    t.string "name"
  end

  add_index "amino_acids", ["name"], name: "index_amino_acids_on_name", using: :btree

  create_table "batches", force: :cascade do |t|
    t.text     "name"
    t.text     "submitter_name"
    t.text     "submitter_email"
    t.text     "submitter_affiliation"
    t.text     "reason_for_inclusion"
    t.text     "file"
    t.text     "url_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batches", ["name"], name: "index_batches_on_name", using: :btree

  create_table "data_versions", force: :cascade do |t|
    t.integer "version", default: 0
  end

  create_table "disease_source_variants", force: :cascade do |t|
    t.integer "disease_id"
    t.integer "source_id"
    t.integer "variant_id"
    t.text    "my_cancer_genome_url"
    t.text    "civic_url"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.string "doid"
  end

  add_index "diseases", ["doid"], name: "index_diseases_on_doid", using: :btree
  add_index "diseases", ["name"], name: "index_diseases_on_name", using: :btree

  create_table "drug_interactions", force: :cascade do |t|
    t.string  "effect"
    t.string  "pathway"
    t.string  "therapeutic_context"
    t.string  "status"
    t.string  "evidence"
    t.integer "variant_id"
    t.integer "source_id"
    t.text    "clinical_association"
  end

  create_table "genes", force: :cascade do |t|
    t.string  "name"
    t.string  "ensembl_id"
    t.integer "entrez_id"
  end

  add_index "genes", ["name"], name: "index_genes_on_name", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string  "chromosome"
    t.string  "reference_build"
    t.string  "reference_read"
    t.integer "start",                      limit: 8
    t.integer "stop",                       limit: 8
    t.string  "previous_reference_base"
    t.string  "reference_sequence_version",           default: "GRCh37"
  end

  add_index "locations", ["chromosome"], name: "index_locations_on_chromosome", using: :btree
  add_index "locations", ["reference_read"], name: "index_locations_on_reference_read", using: :btree
  add_index "locations", ["start"], name: "index_locations_on_start", using: :btree
  add_index "locations", ["stop"], name: "index_locations_on_stop", using: :btree

  create_table "mutation_types", force: :cascade do |t|
    t.string "name"
  end

  add_index "mutation_types", ["name"], name: "index_mutation_types_on_name", using: :btree

  create_table "sources", force: :cascade do |t|
    t.string  "name"
    t.integer "pubmed_id"
    t.text    "citation"
  end

  add_index "sources", ["pubmed_id"], name: "index_sources_on_pubmed_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "tags_variants", id: false, force: :cascade do |t|
    t.integer "tag_id",     null: false
    t.integer "variant_id", null: false
  end

  add_index "tags_variants", ["tag_id", "variant_id"], name: "index_tags_variants_on_tag_id_and_variant_id", using: :btree

  create_table "transcripts", force: :cascade do |t|
    t.string "name"
    t.string "source"
    t.string "version"
  end

  create_table "variant_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "variants", force: :cascade do |t|
    t.string  "cdna_change"
    t.string  "variant"
    t.string  "strand"
    t.integer "location_id"
    t.integer "variant_type_id"
    t.integer "amino_acid_id"
    t.integer "gene_id"
    t.integer "mutation_type_id"
    t.integer "primary_variant_id"
    t.string  "hgvs"
    t.string  "tim_ley_annotation"
    t.integer "transcript_id"
    t.integer "version_id"
    t.text    "meta"
    t.integer "batch_id"
  end

  add_index "variants", ["batch_id"], name: "index_variants_on_batch_id", using: :btree
  add_index "variants", ["hgvs"], name: "index_variants_on_hgvs", using: :btree
  add_index "variants", ["variant"], name: "index_variants_on_variant", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string  "name"
    t.string  "sort_order"
    t.boolean "is_current",  default: false
    t.string  "import_date"
  end

  add_foreign_key "disease_source_variants", "diseases"
  add_foreign_key "disease_source_variants", "sources"
  add_foreign_key "disease_source_variants", "variants"
  add_foreign_key "drug_interactions", "sources"
  add_foreign_key "drug_interactions", "variants"
  add_foreign_key "tags_variants", "tags"
  add_foreign_key "tags_variants", "variants"
  add_foreign_key "variants", "amino_acids"
  add_foreign_key "variants", "batches"
  add_foreign_key "variants", "genes"
  add_foreign_key "variants", "locations"
  add_foreign_key "variants", "mutation_types"
  add_foreign_key "variants", "transcripts"
  add_foreign_key "variants", "variant_types"
  add_foreign_key "variants", "variants", column: "primary_variant_id"
  add_foreign_key "variants", "versions"
end
