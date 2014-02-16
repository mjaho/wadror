require 'spec_helper'

describe Beer do

  it "is saved if style and name are set" do
    #user = User.create username:"Pekka", password:"asd", password_confirmation:"asd"
    style = FactoryGirl.create(:style)
    beer = Beer.create style: style, name:"Testibishe"

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq (1)
  end

  it "is not saved if name is not set" do
    style = FactoryGirl.create(:style)
    beer = Beer.create style: style

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq (0)

  end

  it "is not saved if style is not set" do
    beer = Beer.create name:"Testibishe"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq (0)

  end
end
