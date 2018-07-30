ActiveRecord::Schema.define(version: 2018_07_29_045102) do

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id"
    t.boolean "truth", default: false
    t.integer "user_track_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "exams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "topic_id"
    t.index ["topic_id"], name: "index_exams_on_topic_id"
  end

  create_table "question_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "topic_id"
    t.bigint "exam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_question_types_on_exam_id"
    t.index ["topic_id"], name: "index_question_types_on_topic_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "question_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_type_id"], name: "index_questions_on_question_type_id"
  end

  create_table "topics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_exams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "user_id"
    t.integer "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_user_exams_on_exam_id"
    t.index ["user_id"], name: "index_user_exams_on_user_id"
  end

  create_table "user_tracks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_exam_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_user_tracks_on_question_id"
    t.index ["user_exam_id"], name: "index_user_tracks_on_user_exam_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.string "reset_digest"
    t.boolean "active_status"
    t.datetime "activated_at"
    t.datetime "reset_sent_at"
    t.boolean "admin"
    t.integer "total_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "exams", "topics"
  add_foreign_key "question_types", "exams"
  add_foreign_key "question_types", "topics"
  add_foreign_key "questions", "question_types"
  add_foreign_key "user_exams", "exams"
  add_foreign_key "user_exams", "users"
  add_foreign_key "user_tracks", "questions"
  add_foreign_key "user_tracks", "user_exams"
end
