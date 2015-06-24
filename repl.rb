
require "./mini_games.rb"
include MiniGames

require "./formating.rb"
include Formatting



#Variables********************************************************************************************

health = 10
player_attack_power = rand(2..3)

basic_enemy_list_left = [{name:"cow", enemy_power: 3}, {name:"Librarian", enemy_power: 4},
                        {name:"squirrel", enemy_power: 2},{name: "Squire", enemy_power: 6},
                        {name: "grasshopper", enemy_power: 1}, {name:"fiend", enemy_power: 5},
                        {name:"demon", enemy_power: 7},{name:"Broken Laptop", enemy_power: 1},
                        {name:"Fire Fly", enemy_power: 2} ]
basic_enemy_list_right = [{name:"rat", enemy_power: 2}, {name: "imp", enemy_power: 5}, {name: "goblin", enemy_power: 6},
                         {name: "ladybug", enemy_power: 1}, {name: "golem", enemy_power: 4}, {name:"fiend", enemy_power: 5},
                         {name:"cockroach", enemy_power: 1},{name:"Bear", enemy_power: 7},{name:"Bandit", enemy_power: 2}
]
boss_list = [{name: "Succubus",enemy_power: 10},{name:"Bug-in-Code", enemy_power: 12},{name: "Computer Thief", enemy_power: 15 },
             {name: "El Diable", enemy_power: 20}]
chest_list = [{name: "rock", item_power: 1, item_type: "weapon"}, {name: "stick", item_power: 2, item_type: "weapon"},
              {name:"first aid kit", item_power: 4, item_type: "health"}, {name: "apple", item_power: 2, item_type: "health"},
              {name:"banana", item_power: 1, item_type: "health"}, {name:"knife", item_power: 5, item_type: "weapon"}]
number_of_fights = 0
direction_answer = ""
#Intro and Character Info Scene ************************************************************************
clear_screen
text_flasher("game loading")
sleep(0.5)
print ""
clear_screen
put_a_line
say(nil, "What is your name?")
player_name = gets.chomp.capitalize
puts "You wake up in pitch darkness."
sleep(0.5)
puts "You smell mold and rotting flesh"
sleep(0.5)
puts "As your eyes get accustomed to the darkness you spot a doorway looming over you"
puts "Before you set out to escape this place you start hearing a disembodied voice"
puts "'You will need to survive the next 5 fights, #{player_name}, and have over 10 attack power to face me'"
puts "'If you are not strong enough or you lose all your health you will die'"
puts "Press enter to continue"
any_key = gets.chomp
if any_key.respond_to? :to_s
clear_screen
title

sleep(2)
clear_screen
puts "You make your way to the doorway"
#begin game
until number_of_fights == 5 do
  if health <= 0
    break
    else

  clear_screen
  put_a_line
  stat_box(health, player_attack_power, number_of_fights )
  direction_answer = ask_question("You have four options:","1-Go left, 2-Go Right, 3-Go Forward, 4- Go back to the room")
    case direction_answer
      when "1"  #Go Left
        clear_screen
        put_a_line
        number_of_fights += 1
        stat_box(health, player_attack_power, number_of_fights )
        current_left_enemy = basic_enemy_list_left.sample
        puts "You go left"
        sleep(1)

        puts "You see a #{current_left_enemy[:name]} with #{current_left_enemy[:enemy_power]} attack power"
        sleep(3)

        begin
          hr = Thread.new {puts `afplay ./swordraw.mp3 -t 90 -v +2`}
          fight_screen
          fight_outcome = fight_basic(current_left_enemy[:enemy_power], player_attack_power)
          if fight_outcome
            player_attack_power += rand(1..3)
            puts "You won the Fight!"
            puts "You now have #{player_attack_power} attack power"
            sleep(3)
          else
            puts "sorry you lost"
            health -= current_left_enemy[:enemy_power]
            player_attack_power += 1
            sleep(3)
          end

        end
      when "2" #Go Right
        clear_screen
        put_a_line
        number_of_fights += 1
        stat_box(health, player_attack_power, number_of_fights )
        current_right_enemy = basic_enemy_list_right.sample
        puts "You go Right"
        sleep(1)

        puts "You see a #{current_right_enemy[:name]} with #{current_right_enemy[:enemy_power]} attack power"
        sleep(3)

        begin
          hr = Thread.new {puts `afplay ./swordraw.mp3 -t 90 -v +2`}
          fight_screen
          fight_outcome = fight_game_basic(current_right_enemy[:enemy_power], player_attack_power)
          if fight_outcome
            player_attack_power += rand(1..3)
            puts "You won the Fight!"
            puts "You now have #{player_attack_power} attack power"
            sleep(3)
          else
            puts "sorry you lost"
            health -= current_right_enemy[:enemy_power]
            player_attack_power += 1
            sleep(3)
          end

        end
      when "3" # Go forward
        chest_item_current = chest_list.sample
        clear_screen
        put_a_line
        number_of_fights += 1
        stat_box(health, player_attack_power, number_of_fights )
        puts "You go forward"

        puts "You come across a chest"
        chest = ask_question("Do you want to open the chest?", "1:Yes or 2:No")
          case chest
            when "1"
              puts "You have found a #{chest_item_current[:name]}"
              chest_screen
              if chest_item_current[:item_type] == "weapon"
                  player_attack_power += chest_item_current[:item_power]
                  puts "You now have #{player_attack_power} attack power"
                  sleep(3)
                elsif chest_item_current[:item_type] == "health"
                  health += chest_item_current[:item_power]
                  puts "You now have #{health} health"
                  sleep(3)
                else
                  puts "There was nothinig in the chest"
                end

            else
              puts "You go back to the hallway"
          end

        sleep(1)
      when "4" #Stay in the room
        clear_screen
        put_a_line
        number_of_fights +=1
        stat_box(health, player_attack_power, number_of_fights )
        puts "You return to the room"
        puts "You find a somewhat comfortable part of the floor and sit down"
        sit_screen
        puts "As you are sitting, you feel the health leach out from your body"
        puts "You lose 2 health"
        health -= 2
        sleep(3)
      when "exit"
        break
      else
        puts "That is not an option, try again"
        sleep(3)
    end

end
end
if player_attack_power >= 10
  boss = boss_list.sample
  puts "You have made it through the dungeon!"
  boss_screen
  puts "#{boss[:name]} looms ahead with #{boss[:enemy_power]} attack power"
  puts "If you defeat him you can leave this place"
  puts "If not..."
  sleep(2)
  begin
    fight_outcome = fight_game_basic(boss[:enemy_power], player_attack_power)
    if fight_outcome
      puts "You won the Fight!"
      puts "You leave this cursed place"
      puts "Well done!"
      you_win
      else

      puts "As #{boss[:name]}'s last attack hits its mark, you feel the darkness encroaching"


      puts "The last thing you hear before the darkness takes over completely, is the #{boss[:name]}'s cackle"
      hr = Thread.new {puts `afplay ./Creepy_Laugh.mp3 -t 90 -v +2`}
      game_over

    end
  end
else
    puts "You are not strong enough to take out the final guardian of this place"
    sleep(4)
    clear_screen
    hr = Thread.new {puts `afplay ./Creepy_Laugh.mp3 -t 90 -v +2`}
    game_over
end
end