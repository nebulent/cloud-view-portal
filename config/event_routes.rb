WebsocketRails::EventMap.describe do
  namespace :sshSessions do
    subscribe :create,  :to => SshSessionsController, :with_method => :create
    subscribe :execute, :to => SshSessionsController, :with_method => :execute
    subscribe :destroy, :to => SshSessionsController, :with_method => :destroy
  end
end
