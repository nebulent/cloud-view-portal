class OrganizationEventLog
  attr_reader :id
  def initialize (id)
    @id = id
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
    Event.create({:organization_id => id}.merge(attrs))
  end
end
