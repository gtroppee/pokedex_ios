class Pokemon
  PROPERTIES = [:name, :pkdx_id, :avatar, :reports]
  API = 'http://localhost:3000/api/v1'
  attr_accessor *PROPERTIES
  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def self.find_all(&block)
    BubbleWrap::HTTP.get("#{API}/pokemons") do |response|
      result_data = BubbleWrap::JSON.parse(response.body.to_str)
      pokemons = result_data.map{|data|Pokemon.new(data)}
      block.call(pokemons)
    end
  end

  def reports
    @reports.map{|data| Report.new(data)}
  end

  def add_report(report, &block)
    BubbleWrap::HTTP.post("#{API}/reports", payload:{report: report}) do |response|
      if response.ok?
        block.call(tag)
      else
        block.call(nil)
      end
    end
  end
end

class BubbleWrap::Device::Camera
  class KUTTypeMovie
  end
  class KUTTypeImage
  end
end

class Symbol
  class KCAMediaTimingFunctionLinear
  end
  class KCAMediaTimingFunctionEaseIn
  end
  class KCAMediaTimingFunctionEaseOut
  end
  class KCAMediaTimingFunctionEaseInEaseOut
  end
  class KCAMediaTimingFunctionEaseInEaseOut
  end
  class KCAMediaTimingFunctionDefault
  end
end