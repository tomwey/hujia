class AddFeeIntroAndNoteToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :fee_intro, :string
    add_column :coaches, :note, :string
  end
end
