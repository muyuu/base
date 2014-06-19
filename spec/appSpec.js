describe("function add", function() {
  return it("1 + 1 は 2", function() {
    return expect(app.add(1, 1)).toEqual(2);
  });
});
