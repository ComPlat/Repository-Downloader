# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_27_152849) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "toap_attachments", force: :cascade do |t|
    t.string "name"
    t.string "ds_desc"
    t.string "filesize"
    t.integer "ana_id"
    t.integer "ds_id"
    # noinspection RubyResolve
    t.hstore "extended_metadata"
    t.integer "att_id"
    t.string "filename"
    t.uuid "identifier"
    t.string "storage", limit: 20
    t.string "content_type"
    t.string "bucket"
    t.string "akey", limit: 500
  end

  create_table "toap_publications", force: :cascade do |t|
    # noinspection RubyResolve
    t.jsonb "taggable_data"
    t.string "element_type"
    t.integer "element_id"
    t.string "ancestry"
    t.text "metadata_xml"
    t.datetime "published_at", precision: nil
    t.string "doi_suffix"
    # noinspection RubyResolve
    t.hstore "extended_metadata"
    t.string "reaction_svg_file"
    # noinspection RubyResolve
    t.jsonb "reaction_temperature"
    t.text "reaction_description"
    t.text "reaction_observation"
    t.string "reaction_duration"
    t.string "reaction_purification", array: true
    t.string "tlc_solvents"
    t.text "tlc_description"
    t.string "reaction_status"
    t.text "rinchi_string"
    t.text "rinchi_long_key"
    t.string "rinchi_short_key"
    t.string "rinchi_web_key"
    t.string "rxno"
    t.string "sample_svg_file"
    t.binary "molfile"
    t.text "sample_desc"
    # noinspection RubyResolve
    t.numrange "sample_melting_point"
    # noinspection RubyResolve
    t.numrange "sample_boiling_point"
    t.float "target_amount_value"
    t.string "target_amount_unit"
    t.string "rs_type"
    t.float "yield"
    t.string "iupac_name"
    t.string "cano_smiles"
    t.string "sum_formular"
    t.string "inchikey"
    t.string "inchistring"
    t.float "molecular_weight"
  end # create_table "toap_publications"
end # ActiveRecord::Schema
