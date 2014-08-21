class Enceladus::ApiPaginatedCollection

  RESOURCE_CLASS = nil

  attr_reader :total_pages, :total_results, :path, :params, :results_per_page

  def initialize(path, params={})
    self.path = path
    self.params = params
    self.params[:page] = 1
    self.results_per_page = []
    get_results_per_page
  end

  def all
    get_results_per_page
  end

  def next_page
    self.params[:page] += 1
    get_results_per_page
  end

  def previous_page
    raise ArgumentError.new("current_page must be greater than 0") if self.params[:page] == 1
    self.params[:page] -= 1
    get_results_per_page
  end

  def current_page
    self.params[:page]
  end

  def current_page=(page)
    self.params[:page] = page
    get_results_per_page
  end

  def first
    get_results_per_page.first
  end

  def last
    get_results_per_page.last
  end

private
  attr_writer :total_pages, :total_results, :path, :params, :results_per_page

  def fetch_colletion
    raise NotImplementedError.new("RESOURCE_CLASS must be defined") if self.class::RESOURCE_CLASS.nil?

    response = Enceladus::Requester.get(path, params)
    self.total_pages = response.total_pages
    self.total_results = response.total_results
    self.class::RESOURCE_CLASS.build_collection(response.results)
  end

  def get_results_per_page
    self.results_per_page[current_page - 1] ||= fetch_colletion
  end
end
