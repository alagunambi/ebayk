class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :contact
      t.string :ad_id
      t.string :link

      t.timestamps null: false
    end
  end
end
