require 'spec_helper'

describe Beer do
  #pending "add some examples to (or delete) #{__FILE__}"

  it "is saved if style and name are set" do
    #user = User.create username:"Pekka", password:"asd", password_confirmation:"asd"
    beer = Beer.create style:"IPA", name:"Testibishe"

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq (1)
  end

  it "is not saved if name is not set" do
    beer = Beer.create style:"IPA"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq (0)

  end

  it "is not saved if style is not set" do
    beer = Beer.create name:"Testibishe"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq (0)

  end
end
