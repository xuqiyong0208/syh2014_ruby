
require 'settingslogic'

class Settings < Settingslogic
  
  source "#{Sinarey.root}/config/settings.yml"

  namespace Sinarey.env
  load!
end