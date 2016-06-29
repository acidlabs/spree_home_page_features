class AddPositionToSpreeBanner < ActiveRecord::Migration
  def change
    add_column :spree_banners, :position, :integer
  end
end
