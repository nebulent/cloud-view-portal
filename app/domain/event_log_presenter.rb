class EventLogPresenter
  def self.events (org, params)
    puts params
    data = org.events
    paged = page(data, params)
    sorted = sort(paged, params)

    {
      :data => sorted,
      :total => sorted.count
    }
  end

  private

  def self.sort (collection, params)
    return collection unless params["sort"]
    puts "sorting..."
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
