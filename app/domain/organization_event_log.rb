class OrganizationEventLog
  attr_reader :defaults
  def initialize (attrs)
    @defaults = attrs
  end

  def debug (attrs)
    log({:level => 'debug'}.merge(attrs))
  end

  def info (attrs)
    log({:level => 'info'}.merge(attrs))
  end

  def warn (attrs)
    log({:level => 'warn'}.merge(attrs))
  end

  def error (attrs)
    log({:level => 'debug'}.merge(attrs))
  end

  private

  def log (attrs)
    Event.create(defaults.merge(attrs))
  end
end
