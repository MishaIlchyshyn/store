module Store
  class BaseController < ApplicationController
    admin_access_only
    layout "settings"
  end
end
