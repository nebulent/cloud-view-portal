class Users::ApplicationController < ApplicationController
  before_filter :autenticate_user!
end
