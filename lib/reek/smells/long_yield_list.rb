$:.unshift File.dirname(__FILE__)

require 'reek/smells/smell_detector'

module Reek
  module Smells

    class LongYieldList < LongParameterList

      def self.contexts      # :nodoc:
        [:yield]
      end

      #
      # Checks the arguments to the given call to yield.
      # Any smells found are added to the +report+; returns true in that case,
      # and false otherwise.
      #
      def examine_context(ctx, report)
        args = ctx.args
        return false unless Array === args and args[0] == :array
        num_args = args.length-1
        return false if num_args <= @max_params
        report << LongYieldListReport.new(ctx, num_args)
      end
    end

    class LongYieldListReport < SmellReport
      
      def initialize(context, num_params)
        super(context)
        @num_params = num_params
      end

      def warning
        "yields #{@num_params} parameters"
      end
    end
  end
end