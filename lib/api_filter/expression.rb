module ApiFilter
  class Expression
    def accept(visitor)
      visitor.visit(self)
    end
  end

  class BinaryExpression < Expression
    attr_reader :left_expression, :operator, :right_expression

    def initialize(left_expression, operator, right_expression)
      @left_expression = left_expression
      @operator = operator
      @right_expression = right_expression
    end
  end

  class LiteralExpression < Expression
    attr_reader :value

    def initialize(value)
      @value = value
    end
  end

  class UnaryExpression < Expression
    attr_reader :operator, :right_expression

    def initialize(operator, right_expression)
      @operator = operator
      @right_expression = right_expression
    end
  end

  class GroupingExpression < Expression
    attr_reader :expression

    def initialize(expression)
      @expression
    end
  end
end
