describe("Game", function() {
  var game;

  beforeEach(function() {
    game = new Game('ws://0.0.0.0:3000/connect');
  });

  describe("when connected", function() {
    beforeEach(function() {
      game.connect();
    });
      
    it ("should know it", function() {
      expect(game.connected).toBeTruthy();
    });

    it("should move cards", function() {
//      game.move_card('11',235,42)
    });
  });
});
