class EventLogPresenter
  def self.events (org, params)
    data = org.events
    {
      :data => page(data, params),
      :total => data.count
    }
  end

  private

  def self.page (data, params)
    data.paginate(:page => params["page"], :limit => params["take"])
  end
end
