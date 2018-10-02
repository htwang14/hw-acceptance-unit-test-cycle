# To make changes to the schema, we need to write a new migrate file, 
# since only new migration are considered.
class AddDirector < ActiveRecord::Migration
    # the change caused by a 'add_column' function is good for both migrate and rollback
    # changes caused by other functions may need to def up and down.
    # see https://codequizzes.wordpress.com/2013/06/06/rails-migrations-to-add-a-column-and-change-column-type/ for details.
    def change
        # add_column:
        # first para->table name, second para->column name, third para->column type
        add_column :movies, :director, :string
    end
end
# This only changes the database schema.
# To show the director colunm on the webpage, we need to add that in the view too.