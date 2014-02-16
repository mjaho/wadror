class RemoveStylesIdFromBeers < ActiveRecord::Migration
  def change
      remove_column :beers, :styles_id, :integer
  end
end
