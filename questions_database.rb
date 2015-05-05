require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("questions.db")
    self.type_translation = true
    self.results_as_hash = true
  end

  def self.execute(*args, &blck)
    instance.execute(*args, &blck)
  end
end
