$:.unshift File.dirname(__FILE__)

require 'reek/smells/smell_detector'

module Reek
  module Smells

    #
    # A Long Method is any method that has a large number of lines.
    #
    # Currently +LongMethod+ reports any method with more than
    # +MAX_ALLOWED+ statements.
    #
    class LongMethod < SmellDetector

      def initialize(config = {})
        super
        @max_statements = config.fetch('max_calls', 5)
      end

      #
      # Checks the length of the given +method+.
      # Any smells found are added to the +report+; returns true in that case,
      # and false otherwise.
      #
      def examine_context(method, report)
        num = method.num_statements
        return false if method.constructor? or num <= @max_statements
        report << LongMethodReport.new(method, num)
      end
    end

    class LongMethodReport < SmellReport

      def initialize(context, num)
        super(context)
        @num_stmts = num
      end

      def warning
        "has approx #{@num_stmts} statements"
      end
    end
  end
end