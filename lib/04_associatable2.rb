require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
    define_method(name) do
      source_options = through_options.model_class.assoc_options[source_name]

      through_query = <<-SQL
        SELECT
          #{source_options.foreign_key}
        FROM
          #{through_options.table_name}
        WHERE
          #{through_options.primary_key} = ?
      SQL

      query = <<-SQL
        SELECT
          *
        FROM
          #{source_options.table_name}
        WHERE
          #{source_options.primary_key} = (#{through_query})
      SQL

      r = DBConnection.execute(query, self.send(through_options.foreign_key))
      source_options.model_class.parse_all(r).first
    end
  end
end
