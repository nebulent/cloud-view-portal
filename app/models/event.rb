class Event < ActiveRecord::Base
  attr_accessible :level, :name, :entity, :message, :organization_id,
                  :user_email

  def self.starts_with (fields)
    reg_where fields, lambda {|str| /#{str}.*/i}
  end

  def self.ends_with (fields)
    reg_where fields, lambda {|str| /.*#{str}/i}
  end

  def self.contains (fields)
    reg_where fields, lambda {|str| /.*#{str}.*/i}
  end

  def self.does_not_contain (fields)
    params = rehash fields, lambda {|str| /.*#{str}.*/i}
    self.not(params)
  end

  private

  def self.rehash (hash, vproc)
    ary = hash.map {|k,v| [k, vproc.call(v)]}
    Hash[ary]
  end

  def self.reg_where (hash, vproc)
    where rehash(hash, vproc)
  end
end