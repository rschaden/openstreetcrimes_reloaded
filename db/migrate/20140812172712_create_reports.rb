class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :title
      t.text :link
      t.text :content
      t.datetime :pub_date
      t.point :location, geographic: true

      t.timestamps
    end
  end
end
