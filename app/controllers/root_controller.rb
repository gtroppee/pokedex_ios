class RootController < UIViewController
  def viewDidLoad
    super
    self.title = "Home"
    self.view.backgroundColor = UIColor.whiteColor

    @list = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @list.setTitle("Pokemons list", forState:UIControlStateNormal)
    @list.setTitleColor(UIColor.lightGrayColor, forState:UIControlStateDisabled)
    @list.sizeToFit
    @list.center = [self.view.bounds.size.width/2, self.view.bounds.size.height/2]
    @list.addTarget(self, action:"pokemons_list", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@list)

    @map = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @map.setTitle("Reports Map", forState:UIControlStateNormal)
    @map.setTitleColor(UIColor.lightGrayColor, forState:UIControlStateDisabled)
    @map.sizeToFit
    @map.center = [self.view.bounds.size.width/2, self.view.bounds.size.height/2 + 100]
    @map.addTarget(self, action:"reports_map", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@map)
  end

  def pokemons_list
    Pokemon.find_all do |pokemons| 
      controller = PokemonsController.alloc.initWithPokemons(pokemons)
      self.navigationController.pushViewController(controller, animated: true)
    end
  end

  def reports_map
    Report.find_all do |reports|
      controller = ReportsController.alloc.initWithReports(reports)
      self.navigationController.pushViewController(controller, animated: true)
    end
  end
end