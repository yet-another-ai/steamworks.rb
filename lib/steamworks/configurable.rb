# frozen_string_literal: true

module Steamworks
  module Configureable
    def configure
      yield self
    end
  end
end
