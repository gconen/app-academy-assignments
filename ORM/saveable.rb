module Saveable
  def row_hash
    hash = {}
    instance_variables.each do |variable_name| # TA: map?????
      next if variable_name == :@id
      key = variable_name.to_s[1..-1]
      value = self.instance_variable_get(variable_name)
      hash[key] = value
    end

    hash
  end

  def table_name
    self.class.to_s.tableize
  end

  def create
    raise 'already saved!' unless self.id.nil?

    # row = row_hash
    # row.delete('id')
    column_names = row_hash.keys.join(', ')
    column_values = row_hash.values.join(', ')

    QuestionsDatabase(<<-SQL, column_values)
      INSERT INTO
        #{table_name} (#{column_names})
      VALUES
        (?)
    SQL
  end

  def save
    if @id.nil?
      create
      return
    end
    # TA: add symmetry via helper method
    # row = row_hash
    set_string = ""
    row_hash.each do |column_name, value| # TA: Array#zip
        set_string << column_name + " = " + value + ", "
    end

    QuestionsDatabase.execute(<<-SQL, set_string[0..-3], @id)
      UPDATE
        #{table_name}
      SET
        ?
      WHERE
        id = ?
    SQL
  end
end
