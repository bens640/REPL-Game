module MiniGames
  def dice_game
    player_points = 0
    comp_points = 0

    5.times do
      player = rand(6)
      comp = rand(6)
      if player > comp
        player_points += 1
      elsif comp > player
        comp_points += 1
      end
    end

    puts "player #{player_points}"
    puts "Owner #{comp_points}"

  end


  def fight_game_basic(enemy, strength)
    enemy_s = enemy
    player_s = strength

    pp = 0
    cp = 0


      if enemy_s + rand> player_s +rand(1..2)
        cp += 1
      elsif player_s> enemy_s
        pp += 1
      end


    pp > cp ? true : false

  end

  def fight_basic(enemy, strength)
    5.times do
      fight_game_basic(enemy, strength)

    end
  end




end   #Module Ends here!!!!!!!!!!!!!****************************


