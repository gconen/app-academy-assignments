require_relative '01_sql_object.rb'

module AutomaticallyFinalizable
  def inherited(subclass)
    subclass.finalize!
  end
end

class SQLObject
  extend AutomaticallyFinalizable
end
