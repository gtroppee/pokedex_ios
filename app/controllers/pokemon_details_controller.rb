class PokemonDetailsController < UIViewController
  attr_accessor :pokemon

  def initWithPokemon(pokemon)
    initWithNibName(nil, bundle:nil)
    self.pokemon = pokemon
    self
  end

  def viewDidLoad
    super
    self.title = "#{pokemon.name}"
    self.view.backgroundColor = UIColor.whiteColor

    data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(self.pokemon.avatar))
    image = UIImage.alloc.initWithData(data)
    @image_view = UIImageView.alloc.initWithFrame([[210, 10],[200, 200]])
    @image_view.image = image
    @image_view.center = [self.view.bounds.size.width/2, self.view.bounds.size.height/2]
    view.addSubview(@image_view)

    @reports_map = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @reports_map.setTitle("#{pokemon.name}'s reports", forState:UIControlStateNormal)
    @reports_map.setTitleColor(UIColor.lightGrayColor, forState:UIControlStateDisabled)
    @reports_map.sizeToFit
    @reports_map.center = [self.view.bounds.size.width/2, self.view.bounds.size.height/2 + 100]
    @reports_map.addTarget(self, action:"reports_map", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@reports_map)

    @new_report = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @new_report.setTitle("Report #{pokemon.name}", forState:UIControlStateNormal)
    @new_report.setTitleColor(UIColor.lightGrayColor, forState:UIControlStateDisabled)
    @new_report.sizeToFit
    @new_report.center = [self.view.bounds.size.width/2, self.view.bounds.size.height/2 + 200]
    @new_report.addTarget(self, action:"create_report", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@new_report)

    @new_report.when(UIControlEventTouchUpInside) do
      # @new_report.enabled = false
      report = Report.new(latitude: 0, longitude: 0, pokemon_id: self.pokemon.pkdx_id)
      self.pokemon.add_report(report.to_hash) do |report|
        if report
          self.title = "ok"
        else
          self.title = "nok"
        end
      end
    end
  end

  def reports_map
    puts "reports ------- #{self.pokemon.reports}"
    controller = ReportsController.alloc.initWithReports(self.pokemon.reports)
    self.navigationController.pushViewController(controller, animated: true)
  end
end