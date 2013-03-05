class EventLogPresenter
  def self.events (org, params)
    data      = org.events
    paged     = page(data, params)
    filtered  = filter(paged, params)
    sorted    = sort(filtered, params)

    {
      :data => sorted,
      :total => sorted.count
    }
  end

  private

  def self.filter (data, params)
    return data unless params["filter"]

    filters = params["filter"]["filters"]
    first = filter_criteria(data, filters["0"])

    if filters.size == 1
      first
    else
      logic = params["filter"]["logic"].to_sym
      filter_criteria(first.send(logic), filters["1"])
    end
  end

  def self.query_method (key, value, operator)
    case operator
    when "neq"            then "#{key} != #{value}"
    when "eq"             then "#{key} = #{value}"
    when "startswith"     then "#{key} LIKE '#{value}%'"
    when "endswith"       then "#{key} LIKE '%#{value}'"
    when "contains"       then "#{key} LIKE '%#{value}%'"
    when "doesnotcontain" then "#{key} NOT LIKE '%#{value}%'"
    end
  end

  def self.filter_criteria (data, filter)
    return data unless filter

    query = query_method(filter["field"], filter["value"], filter["operator"]) 
    puts "filtering: #{query} "
    data.where query
  end

  def self.sort (collection, params)
    return collection unless params["sort"]
    field = params["sort"]["0"]["field"].to_sym
    direction = params["sort"]["0"]["dir"]
    collection.order("#{field} #{direction}")
  end

  def self.page (data, params)
    data.paginate(:page => params["page"], :limit => params["take"])
  end
end
