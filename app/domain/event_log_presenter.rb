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
      case params["filter"]["logic"]
      when "and"  then filter_criteria(first, filters["1"])
      when "or"   then first & filter_criteria(data, filters["1"])
      end
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

  def self.filter_criteria (arel, filter)
    return arel unless filter
    query = query_method(filter["field"], filter["value"], filter["operator"])
    arel.where query
  end

  def self.sort (arel, params)
    return arel unless params["sort"]
    arel.order("#{params["sort"]["0"]["field"]} #{params["sort"]["0"]["dir"]}")
  end

  def self.page (data, params)
    data.paginate(:page => params["page"], :per_page => params["take"])
  end
end
