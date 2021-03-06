# Adapted from https://gist.github.com/jodosha/1560208
MiniTest::Spec.class_eval do
  def self.shared_examples
    @shared_examples ||= {}
  end
end

module MiniTest
  class Spec
    module SharedExamples
      def shared_examples_for(desc, &block)
        MiniTest::Spec.shared_examples[desc] = block
      end

      def it_behaves_like(desc, *args, &block)
        instance_exec(*args, &MiniTest::Spec.shared_examples[desc])
        instance_eval(&block) if block_given?
      end
    end
  end
end

Object.class_eval do
  include(MiniTest::Spec::SharedExamples)
end
