# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create style:"Sahti", description:"Said to be one of the only primitive beers to survive in Western Europe, Sahti is a farmhouse ale with roots in Finland. First brewed by peasants in the 1500s, mashing (steeping of grains) went down in wooden barrels, and then that mash would be scooped into a hand-carved wooden trough (a kuurna) with a bed of juniper twigs that acted as a filter. The bung at the bottom of the kuurna would be pulled to allow the sweet wort (liquid infusion from the mash) to pass through the twig filter, followed by wort recirculation and a hot water sparge (rinsing of the grains), all of which created a juniper infusion of sorts. Sahti is also referred to as being turbid, because the wort isnt boiled after lautering (separation of spent grain and liquid), leaving loads of proteins behind, thus providing tremendous body. A low-flocculating Finnish bakers yeast creates a cloudy unfiltered beer, with an abundance of sediment. Traditional Sahti is not typically hopped, so the task of balancing is left up to the juniper twigs, which impart an unusual resiny character and also act as a preservative. Some have compared Sahtis to German Hefeweizens, though we find them to be more akin to the Lambics of Belgium due to the exposure to wild yeast and bacteria, and its signature tartness."
s2 = Style.create style:"IPA", description:"First brewed in England and exported for the British troops in India during the late 1700s. To withstand the voyage, IPA's were basically tweaked Pale Ales that were, in comparison, much more malty, boasted a higher alcohol content and were well-hopped, as hops are a natural preservative. Historians believe that an IPA was then watered down for the troops, while officers and the elite would savor the beer at full strength. The English IPA has a lower alcohol due to taxation over the decades. The leaner the brew the less amount of malt there is and less need for a strong hop presence which would easily put the brew out of balance. Some brewers have tried to recreate the origianl IPA with strengths close to 8-9% abv."
s3 = Style.create style:"Lager", description:"The word lager comes from the German word lagern which means, \"to store\". A perfect description as lagers are brewed with bottom fermenting yeast that work slowly at around 34 degrees F, and are often further stored at cool temperature to mature. Lager yeast produce fewer by-product characters than ale yeast which allows for other flavors to pull through, such as hops."

b1.beers.create name:"Iso 3", style_id: s3.id
b1.beers.create name:"Karhu",style_id: s3.id
b1.beers.create name:"Tuplahumala", style_id: s3.id
b2.beers.create name:"Huvila Pale Ale", style_id: s2.id
b2.beers.create name:"X Porter", style_id: s1.id
b3.beers.create name:"Hefezeizen", style_id: s1.id
b3.beers.create name:"Helles", style_id: s3.id
