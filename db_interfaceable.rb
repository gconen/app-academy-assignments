require_relative 'questions_database'
require 'active_support/inflector'

module DBInterfaceable
  def self.find_by_id(id)
    hash = QuestionsDatabase.execute(<<-SQL, table_name, id)
      SELECT
        *
      FROM
        ?
      WHERE
        id = ?
    SQL
    self.new(hash)
  end

  def table_name
    self.class.to_s.tableize
  end
end
