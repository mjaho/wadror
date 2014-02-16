class RemoveAttributesFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :beer_id_id, :integer
    remove_column :beers, :beer_id_type, :string
  end
end
