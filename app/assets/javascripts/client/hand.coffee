class Hand extends CardCollection

  mulligan: =>
    if @size() > 1
      lib = User.local.library
      future_count = @size() - 1

      Message.action "mulligans to #{future_count}."

      while not @isEmpty()
        card = @last()
        card.toggle_covered(true)
        @remove(card)
        lib.add(card)
        card.save()

      lib.shuffle_cards()

      for i in [1..future_count]
        card = lib.first()
        lib.remove(card)
        @add(card)
        card.toggle_covered(false)
        card.save()


window.Hand = Hand