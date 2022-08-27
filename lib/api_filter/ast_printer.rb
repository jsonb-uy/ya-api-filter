module ApiFilter
  class AstPrinter
    def print(expression)
      expression.accept(self)
    end

    def visit_binary_expression(expr)
      parenthesize(expr.operator.lexeme, 
        expr.left_expression, 
        expr.right_expression)
    end

    def visit_unary_expression(expr)
      parenthesize(expr.operator.lexeme, 
                   expr.right_expression)
    end

    def visit_grouping_expression(expr)
      parenthesize('group', expr.expression)
    end

    def visit_literal_expression(expr)
      return 'null' if expr.nil?

      expr.value.to_s
    end

    private
    def parenthesize(name, *expressions)
      merged = expressions.each_with_object("") do |expr, merged|
                 merged << " #{print(expr)}"
               end
      "(#{name}#{merged})"
    end
  end
end