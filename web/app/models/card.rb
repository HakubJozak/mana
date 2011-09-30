class Card

  TOKENS =  {  'Soldier 1/1' => 'http://magiccards.info/extras/token/duel-decks-elspeth-vs-tezzeret/soldier.jpg' ,
    'Cat 2/2' => 'http://magiccards.info/extras/token/scars-of-mirrodin/cat.jpg' ,
    'Soldier 1/1' => 'http://magiccards.info/extras/token/scars-of-mirrodin/soldier.jpg' ,
    'Goblin 1/1' => 'http://magiccards.info/extras/token/scars-of-mirrodin/goblin.jpg' ,
    'Insect 1/1' => 'http://magiccards.info/extras/token/scars-of-mirrodin/insect.jpg' ,
    'Wolf 2/2' => 'http://magiccards.info/extras/token/scars-of-mirrodin/wolf.jpg' ,
    'Golem 3/3' => 'http://magiccards.info/extras/token/scars-of-mirrodin/golem.jpg' ,
    'Myr 1/1' => 'http://magiccards.info/extras/token/scars-of-mirrodin/myr.jpg' ,
    'Wurm 1 3/3' => 'http://magiccards.info/extras/token/scars-of-mirrodin/wurm-1.jpg' ,
    'Wurm 2 3/3' => 'http://magiccards.info/extras/token/scars-of-mirrodin/wurm-2.jpg' ,
    'Poison Counter' => 'http://magiccards.info/extras/token/scars-of-mirrodin/poison-counter.jpg' ,
    'Avatar */*' => 'http://magiccards.info/extras/token/magic-2011/avatar.jpg' ,
    'Bird 3/3' => 'http://magiccards.info/extras/token/magic-2011/bird.jpg' ,
    'Zombie 2/2' => 'http://magiccards.info/extras/token/magic-2011/zombie.jpg' ,
    'Beast 3/3' => 'http://magiccards.info/extras/token/magic-2011/beast.jpg' ,
    'Ooze 1 2/2' => 'http://magiccards.info/extras/token/magic-2011/ooze-1.jpg' ,
    'Ooze 2 1/1' => 'http://magiccards.info/extras/token/magic-2011/ooze-2.jpg' ,
    'Eldrazi Spawn (1) 0/1' => 'http://magiccards.info/extras/token/rise-of-the-eldrazi/eldrazi-spawn-1.jpg' ,
    'Eldrazi Spawn (2) 0/1' => 'http://magiccards.info/extras/token/rise-of-the-eldrazi/eldrazi-spawn-2.jpg' ,
    'Eldrazi Spawn (3) 0/1' => 'http://magiccards.info/extras/token/rise-of-the-eldrazi/eldrazi-spawn-3.jpg' ,
    'Elemental */*' => 'http://magiccards.info/extras/token/rise-of-the-eldrazi/elemental.jpg' ,
    'Hellion 4/4' => 'http://magiccards.info/extras/token/rise-of-the-eldrazi/hellion.jpg' ,
    'Ooze */*' => 'http://magiccards.info/extras/token/rise-of-the-eldrazi/ooze.jpg' ,
    'Tuktuk the Returned 5/5' => 'http://magiccards.info/extras/token/rise-of-the-eldrazi/tuktuk-the-returned.jpg' ,
    'Hornet 1/1' => 'http://magiccards.info/extras/token/duel-decks-phyrexia-vs-the-coalition/hornet.jpg' ,
    'Minion */*' => 'http://magiccards.info/extras/token/duel-decks-phyrexia-vs-the-coalition/minion.jpg' ,
    'Saproling 1/1' => 'http://magiccards.info/extras/token/duel-decks-phyrexia-vs-the-coalition/saproling.jpg' ,
    'Soldier Ally 1/1' => 'http://magiccards.info/extras/token/worldwake/soldier-ally.jpg' ,
    'Dragon 5/5' => 'http://magiccards.info/extras/token/worldwake/dragon.jpg' ,
    'Ogre 3/3' => 'http://magiccards.info/extras/token/worldwake/ogre.jpg' ,
    'Elephant 3/3' => 'http://magiccards.info/extras/token/worldwake/elephant.jpg' ,
    'Plant 0/1' => 'http://magiccards.info/extras/token/worldwake/plant.jpg' ,
    'Construct 6/12' => 'http://magiccards.info/extras/token/worldwake/construct.jpg' ,
    'Angel 4/4' => 'http://magiccards.info/extras/token/zendikar/angel.jpg' ,
    'Bird 1/1' => 'http://magiccards.info/extras/token/zendikar/bird.jpg' ,
    'Kor Soldier 1/1' => 'http://magiccards.info/extras/token/zendikar/kor-soldier.jpg' ,
    'Illusion 2/2' => 'http://magiccards.info/extras/token/zendikar/illusion.jpg' ,
    'Merfolk 1/1' => 'http://magiccards.info/extras/token/zendikar/merfolk.jpg' ,
    'Vampire */*' => 'http://magiccards.info/extras/token/zendikar/vampire.jpg' ,
    'Zombie Giant 5/5' => 'http://magiccards.info/extras/token/zendikar/zombie-giant.jpg' ,
    'Elemental 7/1' => 'http://magiccards.info/extras/token/zendikar/elemental.jpg' ,
    'Beast 4/4' => 'http://magiccards.info/extras/token/zendikar/beast.jpg' ,
    'Snake 1/1' => 'http://magiccards.info/extras/token/zendikar/snake.jpg' ,
    'Wolf 2/2' => 'http://magiccards.info/extras/token/zendikar/wolf.jpg' ,
    'Avatar */*' => 'http://magiccards.info/extras/token/magic-2010/avatar.jpg' ,
    'Beast 3/3' => 'http://magiccards.info/extras/token/magic-2010/beast.jpg' ,
    'Gargoyle 3/4' => 'http://magiccards.info/extras/token/magic-2010/gargoyle.jpg' ,
    'Goblin 1/1' => 'http://magiccards.info/extras/token/magic-2010/goblin.jpg' ,
    'Insect 1/1' => 'http://magiccards.info/extras/token/magic-2010/insect.jpg' ,
    'Soldier 1/1' => 'http://magiccards.info/extras/token/magic-2010/soldier.jpg' ,
    'Wolf 2/2' => 'http://magiccards.info/extras/token/magic-2010/wolf.jpg' ,
    'Zombie 2/2' => 'http://magiccards.info/extras/token/magic-2010/zombie.jpg' ,
    'Beast (1) 3/3' => 'http://magiccards.info/extras/token/duel-decks-garruk-vs-liliana/beast-1.jpg' ,
    'Beast (2) 4/4' => 'http://magiccards.info/extras/token/duel-decks-garruk-vs-liliana/beast-2.jpg' ,
    'Elephant 3/3' => 'http://magiccards.info/extras/token/duel-decks-garruk-vs-liliana/elephant.jpg' ,
    'Bird Soldier 1/1' => 'http://magiccards.info/extras/token/alara-reborn/bird-soldier.jpg' ,
    'Lizard 2/2' => 'http://magiccards.info/extras/token/alara-reborn/lizard.jpg' ,
    'Dragon 1/1' => 'http://magiccards.info/extras/token/alara-reborn/dragon.jpg' ,
    'Zombie Wizard 1/1' => 'http://magiccards.info/extras/token/alara-reborn/zombie-wizard.jpg' ,
    'Spirit 1/1' => 'http://magiccards.info/extras/token/duel-decks-divine-vs-demonic/spirit.jpg' ,
    'Demon */*' => 'http://magiccards.info/extras/token/duel-decks-divine-vs-demonic/demon.jpg' ,
    'Thrull 0/1' => 'http://magiccards.info/extras/token/duel-decks-divine-vs-demonic/thrull.jpg' ,
    'Angel 4/4' => 'http://magiccards.info/extras/token/conflux/angel.jpg' ,
    'Elemental 3/1' => 'http://magiccards.info/extras/token/conflux/elemental.jpg' ,
    'Elemental Shaman 3/1' => 'http://magiccards.info/extras/token/duel-decks-jace-vs-chandra/elemental-shaman.jpg' ,
    'Soldier 1/1' => 'http://magiccards.info/extras/token/shards-of-alara/soldier.jpg' ,
    'Beast 8/8' => 'http://magiccards.info/extras/token/shards-of-alara/beast.jpg' ,
    'Homunculus 0/1' => 'http://magiccards.info/extras/token/shards-of-alara/homunculus.jpg' ,
    'Thopter 1/1' => 'http://magiccards.info/extras/token/shards-of-alara/thopter.jpg' ,
    'Skeleton 1/1' => 'http://magiccards.info/extras/token/shards-of-alara/skeleton.jpg' ,
    'Zombie 2/2' => 'http://magiccards.info/extras/token/shards-of-alara/zombie.jpg' ,
    'Dragon 4/4' => 'http://magiccards.info/extras/token/shards-of-alara/dragon.jpg' ,
    'Goblin 1/1' => 'http://magiccards.info/extras/token/shards-of-alara/goblin.jpg' ,
    'Ooze */*' => 'http://magiccards.info/extras/token/shards-of-alara/ooze.jpg' ,
    'Saproling 1/1' => 'http://magiccards.info/extras/token/shards-of-alara/saproling.jpg' ,
    'Goat 0/1' => 'http://magiccards.info/extras/token/eventide/goat.jpg' ,
    'Bird 1/1' => 'http://magiccards.info/extras/token/eventide/bird.jpg' ,
    'Beast 3/3' => 'http://magiccards.info/extras/token/eventide/beast.jpg' ,
    'Spirit 1/1' => 'http://magiccards.info/extras/token/eventide/spirit.jpg' ,
    'Elemental 5/5' => 'http://magiccards.info/extras/token/eventide/elemental.jpg' ,
    'Worm 1/1' => 'http://magiccards.info/extras/token/eventide/worm.jpg' ,
    'Goblin Soldier 1/1' => 'http://magiccards.info/extras/token/eventide/goblin-soldier.jpg' ,
    'Kithkin Soldier 1/1' => 'http://magiccards.info/extras/token/shadowmoor/kithkin-soldier.jpg' ,
    'Spirit 1/1' => 'http://magiccards.info/extras/token/shadowmoor/spirit.jpg' ,
    'Rat 1/1' => 'http://magiccards.info/extras/token/shadowmoor/rat.jpg' ,
    'Elemental (1) 1/1' => 'http://magiccards.info/extras/token/shadowmoor/elemental-1.jpg' ,
    'Elf Warrior (1) 1/1' => 'http://magiccards.info/extras/token/shadowmoor/elf-warrior-1.jpg' ,
    'Spider 1/2' => 'http://magiccards.info/extras/token/shadowmoor/spider.jpg' ,
    'Wolf 2/2' => 'http://magiccards.info/extras/token/shadowmoor/wolf.jpg' ,
    'Faerie Rogue 1/1' => 'http://magiccards.info/extras/token/shadowmoor/faerie-rogue.jpg' ,
    'Elemental (2) 5/5' => 'http://magiccards.info/extras/token/shadowmoor/elemental-2.jpg' ,
    'Giant Warrior 4/4' => 'http://magiccards.info/extras/token/shadowmoor/giant-warrior.jpg' ,
    'Goblin Warrior 1/1' => 'http://magiccards.info/extras/token/shadowmoor/goblin-warrior.jpg' ,
    'Elf Warrior (2) 1/1' => 'http://magiccards.info/extras/token/shadowmoor/elf-warrior-2.jpg' ,
    'Elemental 7/7' => 'http://magiccards.info/extras/token/duel-decks-elves-vs-goblins/elemental.jpg' ,
    'Elf Warrior 1/1' => 'http://magiccards.info/extras/token/duel-decks-elves-vs-goblins/elf-warrior.jpg' ,
    'Goblin 1/1' => 'http://magiccards.info/extras/token/duel-decks-elves-vs-goblins/goblin.jpg' ,
    'Giant Warrior 5/5' => 'http://magiccards.info/extras/token/morningtide/giant-warrior.jpg' ,
    'Faerie Rogue 1/1' => 'http://magiccards.info/extras/token/morningtide/faerie-rogue.jpg' ,
    'Treefolk Shaman 2/5' => 'http://magiccards.info/extras/token/morningtide/treefolk-shaman.jpg' ,
    'Avatar */*' => 'http://magiccards.info/extras/token/lorwyn/avatar.jpg' ,
    'Elemental (1) 4/4' => 'http://magiccards.info/extras/token/lorwyn/elemental-1.jpg' ,
    'Kithkin Soldier 1/1' => 'http://magiccards.info/extras/token/lorwyn/kithkin-soldier.jpg' ,
    'Merfolk Wizard 1/1' => 'http://magiccards.info/extras/token/lorwyn/merfolk-wizard.jpg' ,
    'Goblin Rogue 1/1' => 'http://magiccards.info/extras/token/lorwyn/goblin-rogue.jpg' ,
    'Elemental Shaman 3/1' => 'http://magiccards.info/extras/token/lorwyn/elemental-shaman.jpg' ,
    'Beast 3/3' => 'http://magiccards.info/extras/token/lorwyn/beast.jpg' ,
    'Elemental (2) 4/4' => 'http://magiccards.info/extras/token/lorwyn/elemental-2.jpg' ,
    'Elf Warrior 1/1' => 'http://magiccards.info/extras/token/lorwyn/elf-warrior.jpg' ,
    'Wolf 2/2' => 'http://magiccards.info/extras/token/lorwyn/wolf.jpg' ,
    'Shapeshifter 1/1' => 'http://magiccards.info/extras/token/lorwyn/shapeshifter.jpg' ,
    'Soldier 1/1' => 'http://magiccards.info/extras/token/tenth-edition/soldier.jpg' ,
    'Zombie 2/2' => 'http://magiccards.info/extras/token/tenth-edition/zombie.jpg' ,
    'Dragon 5/5' => 'http://magiccards.info/extras/token/tenth-edition/dragon.jpg' ,
    'Goblin 1/1' => 'http://magiccards.info/extras/token/tenth-edition/goblin.jpg' ,
    'Saproling 1/1' => 'http://magiccards.info/extras/token/tenth-edition/saproling.jpg' ,
    'Wasp 1/1' => 'http://magiccards.info/extras/token/tenth-edition/wasp.jpg' ,
    'Marit Lage 20/20' => 'http://magiccards.info/extras/token/coldsnap/marit-lage.jpg' ,
    'Angel 4/4' => 'http://magiccards.info/extras/token/player-rewards-2004/angel.jpg' ,
    'Pentavite 1/1' => 'http://magiccards.info/extras/token/player-rewards-2004/pentavite.jpg' ,
    'Beast 3/3' => 'http://magiccards.info/extras/token/player-rewards-2004/beast.jpg' ,
    'Myr 1/1' => 'http://magiccards.info/extras/token/player-rewards-2004/myr.jpg' ,
    'Spirit 1/1' => 'http://magiccards.info/extras/token/player-rewards-2004/spirit.jpg' ,
    'Insect 1/1' => 'http://magiccards.info/extras/token/player-rewards-2003/insect.jpg' ,
    'Sliver 1/1' => 'http://magiccards.info/extras/token/player-rewards-2003/sliver.jpg' ,
    'Bear 2/2' => 'http://magiccards.info/extras/token/player-rewards-2003/bear.jpg' ,
    'Goblin 1/1' => 'http://magiccards.info/extras/token/player-rewards-2003/goblin.jpg' ,
    'Demon */*' => 'http://magiccards.info/extras/token/player-rewards-2003/demon.jpg' ,
    'Rukh 4/4' => 'http://magiccards.info/extras/token/player-rewards-2003/rukh.jpg' ,
    'Elephant 3/3' => 'http://magiccards.info/extras/token/player-rewards-2002/elephant.jpg' ,
    'Squirrel 1/1' => 'http://magiccards.info/extras/token/player-rewards-2002/squirrel.jpg' ,
    'Wurm 6/6' => 'http://magiccards.info/extras/token/player-rewards-2002/wurm.jpg' ,
    'Zombie 2/2' => 'http://magiccards.info/extras/token/player-rewards-2002/zombie.jpg' ,
    'Dragon 5/5' => 'http://magiccards.info/extras/token/player-rewards-2002/dragon.jpg' ,
    'Soldier 1/1' => 'http://magiccards.info/extras/token/player-rewards-2002/soldier.jpg' ,
    'Bird 1/1' => 'http://magiccards.info/extras/token/player-rewards-2001/bird.jpg' ,
    'Elephant 3/3' => 'http://magiccards.info/extras/token/player-rewards-2001/elephant.jpg' ,
    'Goblin Soldier 1/1' => 'http://magiccards.info/extras/token/player-rewards-2001/goblin-soldier.jpg' ,
    'Saproling 1/1' => 'http://magiccards.info/extras/token/player-rewards-2001/saproling.jpg' ,
    'Spirit 1/1' => 'http://magiccards.info/extras/token/player-rewards-2001/spirit.jpg' ,
    'Bear 2/2' => 'http://magiccards.info/extras/token/player-rewards-2001/bear.jpg' ,
    'Beast 4/4' => 'http://magiccards.info/extras/token/player-rewards-2001/beast.jpg' ,
    'Pegasus 1/1' => 'http://magiccards.info/extras/token/unglued/pegasus.jpg' ,
    'Soldier 1/1' => 'http://magiccards.info/extras/token/unglued/soldier.jpg' ,
    'Zombie 1/1' => 'http://magiccards.info/extras/token/unglued/zombie.jpg' ,
    'Goblin 1/1' => 'http://magiccards.info/extras/token/unglued/goblin.jpg' ,
    'Sheep 1/1' => 'http://magiccards.info/extras/token/unglued/sheep.jpg' ,
    'Squirrel 1/1' => 'http://magiccards.info/extras/token/unglued/squirrel.jpg'  }
end
