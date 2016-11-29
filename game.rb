class Person
  attr_accessor :name, :life_points, :alive

  def initialize(name)
    @name = name
    @life_points = 100
    @alive = true
  end

  def info
    # - Return the name and the life points if the person is still alive 
    # - Return the name and "defeated" if the personne was defeated 
    var = "#{@name}"
    if @alive
      var += " #{@life_points}/100 lf (life_points)"
    else
      var += "defeated"
    end
    var
  end

  def attack(person)
    # - Give damages to the personne passed as parameter 
    # - Display what happened
    puts "#{@name} attack #{person.name}"
    person.undergone_attack(damages)
    sleep 0.3
  end

  def undergone_attack(received_damages)
    
    puts"#{@name} undergone #{received_damages}hp de degats!"
    @life_points -= received_damages

    if @life_points <= 0 && @alive
      @alive = false
      puts "#{@name} has been defeated"
    end
    sleep 0.3
   end
end

class Player < Person
  attr_accessor :damages_bonus

  def initialize(name)
    @damages_bonus = 0

    # Call the "initialize" of the mother class(Personne)
    super(name)
  end

  def damages
    # Estimate damages
    puts "#{@name} takes advantage of #{@damages_bonus} points of damages bonus"
    sleep 0.3
    rand(50) + @damages_bonus + 10
  end

  def care
    # Gain life 
    @life_points += rand(30) + 10
    puts "#{@name} regained life."
    sleep 0.3
  end

  def improve_damages
    # Increase damages_bonus
    @damages_bonus += rand(15) + 20
    puts "#{@name} gained in power!"
    sleep 0.3
  end
end

class Ennemi < Person
  def damages
    rand(10) + 1
  end
end

class Game
  def self.possible_actions(world)
    puts " POSSIBLE ACTIONS: "

    puts "0 - Treatment"
    puts "1 - Improve your attack "

    i = 2
    world.enemies.each do |enemy|
      puts "#{i} - Attack #{enemy.info}"
      i = i + 1
    end
    puts "99 - Leave"
  end

  def self.is_over(player, world)
    if !player.alive || world.enemies_alive.size == 0
      return true
    else
      return false
    end
  end
end

class World
  attr_accessor :enemies

  def enemies_alive
    # Returns only alive enemies
    @enemies.select do |enemi|
      enemy.alive
    end
  end
end

##############


world = World.new


world.enemies = [
  Enemy.new("Balrog"),
  Enemy.new("Goblin"),
  Enemy.new("Squelette")
]


player = Player.new("Jean-Michel Paladin")

puts "\n\nThus begins the adventure of #{joueur.nom}\n\n"

100.times do |tour|
  puts "\n------------------ Tour number #{tour} ------------------"

  # Display different possible actions
  Game.possible_actions(world)

  puts "\nWHICH ACTION TO DO ?"
  
  choice = gets.chomp.to_i

  if choice == 0
    player.care
  elsif choice == 1
    player.improve_damages
  elsif choice == 99
    break
  else
    enemy_to_attack = world.enemies[choice - 2]
    player.attack(enemy_to_attack)
  end

  puts "\nENEMIES COUNTERATTACK!"
  
  world.enemies_alive.each do |enemy|
    enemy.attack(player)
  end

  puts "\nCondition of the hero: #{player.info}\n"

  break if Game.is_over(player, world)
end

puts "\nGame Over!\n"

if player.alive
  puts "You won!"
else
  puts "You lost!"
end
