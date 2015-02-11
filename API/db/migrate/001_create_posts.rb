Sequel.migration do
  up do
    create_table :posts do
      primary_key :id
      String :title
      Text :content
      DateTime :created_at
      DateTime :updated_at, null:true
    end
  end

  down do
    drop_table :posts
  end
end
