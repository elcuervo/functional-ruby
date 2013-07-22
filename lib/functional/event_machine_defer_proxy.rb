require 'functional/global_thread_pool'

module Functional

  class EventMachineDeferProxy
    behavior(:global_thread_pool)

    def post(*args, &block)
      if args.empty?
        EventMachine.defer(block)
      else
        new_block = proc{ block.call(*args) }
        EventMachine.defer(new_block)
      end
      return true
    end

    def <<(block)
      EventMachine.defer(block)
      return self
    end
  end
end
