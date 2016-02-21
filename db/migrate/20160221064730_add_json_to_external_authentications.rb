class AddJsonToExternalAuthentications < ActiveRecord::Migration
  def change
    add_column :external_authentications, :json, :text
  end
end
