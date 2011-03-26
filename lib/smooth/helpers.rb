require 'smooth/helpers/content_store'
require 'fileutils'

module Smooth
  module Helpers

    require 'smooth/helpers/about'
    ContentStore.register_helpers About

    require 'smooth/helpers/slides'
    ContentStore.register_helpers Slides

    require 'smooth/helpers/components'
    ContentStore.register_helpers Components

    require 'smooth/helpers/assets'
    ContentStore.register_helpers Assets

  end
end
