require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    table = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      LIMIT
        0
    SQL

    table.first.map(&:to_sym)
  end

  def self.finalize!
    #todo: move this to ::inherited
    columns.each do |variable|
      define_method(variable) { attributes[variable] }
      define_method("#{variable.to_s}=") do |value|
         attributes[variable] = value
      end
    end
  end

  def self.table_name=(name)
    @table_name = name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    query = <<-SQL
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(DBConnection.execute(query))
  end

  def self.parse_all(results)
    results.map{ |result| self.new(result) }
  end

  def self.find(id)
    query = <<-SQL
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    parse_all(DBConnection.execute(query, id)).first
  end

  def initialize(params = {})
    params.each do |column, value|
      unless self.class.columns.include?(column.to_sym)
        raise Exception.new("unknown attribute '#{column}'")
      end
      send("#{column}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values #why does this method exist?
    attributes.values
  end

  def insert
    question_marks_arr = ['?'] * attributes.length
    question_marks = question_marks_arr.join(", ")
    cols = attributes.keys.map(&:to_s).join(", ")

    query = <<-SQL
      INSERT INTO
        #{self.class.table_name} (#{cols})
      VALUES
        (#{question_marks})
    SQL

    DBConnection.execute(query, attribute_values)

    self.id = DBConnection.last_insert_row_id
  end

  def update
    cols = attributes.keys.map { |col| col.to_s + " = ?" }.join(", ")

    query = <<-SQL
      UPDATE
        #{self.class.table_name}
      SET
        #{cols}
      WHERE
        id = ?
    SQL

    DBConnection.execute(query, attribute_values, id)
  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end
end
