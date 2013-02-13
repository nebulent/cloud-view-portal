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

  def self.query_method (operator)
    @query_methods ||= {
      "neq" => :ne,
      "eq" => :where,
      "startswith" => :starts_with,
      "contains" => :contains,
      "doesnotcontain" => :does_not_contain,
      "endswith" => :ends_with
    }
    @query_methods[operator]
  end

  def self.filter_criteria (data, filter)
    key = filter["field"].to_sym
    method = query_method(filter["operator"])
    data.send(method, {key => filter["value"]})
  end

  def self.sort (collection, params)
    return collection unless params["sort"]
    field = params["sort"]["0"]["field"].to_sym
    direction = int(params["sort"]["0"]["dir"])
    collection.sort(field => direction)
  end

  def self.int (sort)
    @sort_table ||= {"desc" => -1, "asc" => 1}
    @sort_table[sort]
  end

  def self.page (data, params)
    data.paginate(:page => params["page"], :limit => params["take"])
  end
end
