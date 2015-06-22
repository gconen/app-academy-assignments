require_relative 'questions_database'
require 'active_support/inflector'

module DBInterfaceable
  def find_by_id(id)
    t = table_name
    hash = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{t}
      WHERE
        id = ?
    SQL
    
    self.new(hash.first)
  end

  def table_name
    self.to_s.tableize
  end
end
