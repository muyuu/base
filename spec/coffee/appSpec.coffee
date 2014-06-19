describe "function add", ()->
  it "1 + 1 は 2", ()->
    expect( app.add(1, 1) ).toEqual(2)

