# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_210_504_152_719) do
  create_table 'challenges', force: :cascade do |t|
    t.text 'title'
    t.text 'description'
    t.string 'tags'
    t.string 'emp_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_challenges_on_user_id'
  end

  create_table 'follows', force: :cascade do |t|
    t.string 'followable_type', null: false
    t.integer 'followable_id', null: false
    t.string 'follower_type', null: false
    t.integer 'follower_id', null: false
    t.boolean 'blocked', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[followable_id followable_type], name: 'fk_followables'
    t.index %w[followable_type followable_id], name: 'index_follows_on_followable_type_and_followable_id'
    t.index %w[follower_id follower_type], name: 'fk_follows'
    t.index %w[follower_type follower_id], name: 'index_follows_on_follower_type_and_follower_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'emp_id'
    t.string 'api_token'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['emp_id'], name: 'index_users_on_emp_id', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'votes', force: :cascade do |t|
    t.string 'votable_type'
    t.integer 'votable_id'
    t.string 'voter_type'
    t.integer 'voter_id'
    t.boolean 'vote_flag'
    t.string 'vote_scope'
    t.integer 'vote_weight'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w[votable_id votable_type vote_scope],
            name: 'index_votes_on_votable_id_and_votable_type_and_vote_scope'
    t.index %w[voter_id voter_type vote_scope], name: 'index_votes_on_voter_id_and_voter_type_and_vote_scope'
  end
end
