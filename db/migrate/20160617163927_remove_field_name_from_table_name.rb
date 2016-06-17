class RemoveFieldNameFromTableName < ActiveRecord::Migration
  def change
    remove_column :books, :book_img_file_name
    remove_column :books, :book_img_content_type
    remove_column :books, :book_img_file_size
    remove_column :books, :book_img_updated_at
  end
end
