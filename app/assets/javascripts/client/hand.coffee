class Hand extends CardCollection

  add: (card, opts) =>
    super(card, opts)
    card.toggle_covered(false)

window.Hand = Hand