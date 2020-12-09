class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status, default: 'guest'

      t.timestamps
    end
  end
end
