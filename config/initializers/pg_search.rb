# frozen_string_literal: true

PgSearch.multisearch_options = {
  using: {
    tsearch: {
      any_word: true,
      prefix: true
    },
    trigram: {
      word_similarity: true
    }
  },
  ignoring: :accents
}
