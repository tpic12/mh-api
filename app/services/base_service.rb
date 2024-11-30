require 'dry-initializer'
require 'dry-types'

class BaseService
  extend Dry::Initializer

  module Types
    include Dry.Types()
  end

  def initialize(**kwargs)
    recognized_keys = self.class.dry_initializer.definitions.keys
    filtered_kwargs = kwargs.slice(*recognized_keys)
    super(**filtered_kwargs) # Pass only recognized keys to dry-initializer
  end
end
