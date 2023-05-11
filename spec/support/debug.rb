# frozen_string_literal: true

module Debug
  class << self
    def debug?
      @debug
    end

    def debug!
      @debug = true
      return unless block_given?
      yield
      @debug = false
    end
  end
end
