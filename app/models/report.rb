class Report
  PROPERTIES = [:latitude, :longitude, :title, :subtitle, :pokemon_id]
  attr_accessor *PROPERTIES
  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def coordinate
    CLLocationCoordinate2DMake(latitude, longitude)
  end

  def to_hash
    hash = {}
    PROPERTIES.each do |p| hash[p] = send(p) end
    hash
  end

  def self.find_all(&block)
    BubbleWrap::HTTP.get("http://localhost:3000/api/v1/reports") do |response|
      result_data = BubbleWrap::JSON.parse(response.body.to_str)
      reports = result_data.map{|data|Report.new(data)}
      block.call(reports)
    end
  end
end
