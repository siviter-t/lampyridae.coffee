describe("Lampyridae Tests", function () {

  it("A DOM should exist", function () {
    expect(document).to.not.equal(null);
  });

  it("and it should have a body tag", function () {
    expect(document.body).to.not.equal(null);
  });
});

$(document).ready(function() {

describe("Canvas Tests", function () {

  var existingCanvas = $('#world');
  
  it("A premade canvas tag should already exist", function () {
    expect(existingCanvas).to.not.equal(null);
  });

  it("and it should be a child of the body", function () {
    expect(existingCanvas.parent()[0]).to.equal(document.body);
  });

});

});