class OrganizationEventLog
  attr_reader :id
  def initialize (id)
    @id = id
  end

  def debug (attrs)
    log {:level => 'debug'}.merge(attrs)
  end

  def info
    log {:level => 'info'}.merge(attrs)
  end

  def warn
    log {:level => 'warn'}.merge(attrs)
  end

  def error
    log {:level => 'debug'}.merge(attrs)
  end

  def log (attrs)
    Event.create {:organization_id => id}.merge(attrs)
  end

end
