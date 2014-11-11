class PokemonsController < UIViewController
  attr_accessor :pokemons

  def initWithPokemons(pokemons)
    initWithNibName(nil, bundle:nil)
    self.pokemons = pokemons
    self
  end

  def viewDidLoad
    super
    self.title = "Index"
    self.view.backgroundColor = UIColor.whiteColor

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    @table.dataSource = self
    @table.delegate = self
  end

  def tableView(tableView, numberOfRowsInSection: section)
    self.pokemons.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(
        UITableViewCellStyleDefault,
        reuseIdentifier:@reuseIdentifier)

    cell.textLabel.text = self.pokemons[indexPath.row].name
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    controller = PokemonDetailsController.alloc.initWithPokemon(self.pokemons[indexPath.row])
    self.navigationController.pushViewController(controller, animated:true)
  end
end