class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :description
      t.string :priority
      t.string :status
      t.string :requester

      t.timestamps
    end
  end
end
