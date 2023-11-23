class ConvertAllTablesToUuid < ActiveRecord::Migration[7.0]
  def change
    drop_table :roles
    drop_table :companies
    drop_table :team_members
    drop_table :departments
    drop_table :designations
    drop_table :applicants

    create_table :roles, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    create_table :companies, id: :uuid do |t|
      t.string :name
      t.string :location

      t.timestamps
    end

    create_table :team_members, id: :uuid do |t|
      t.string :name
      t.string :employee_id
      t.uuid :role_id
      t.uuid :company_id

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.string :contact_number
      t.string :profile

      t.timestamps
    end

    add_index :team_members, :email,                unique: true
    add_index :team_members, :reset_password_token, unique: true

    create_table :departments, id: :uuid do |t|
      t.string :name
      t.uuid :company_id

      t.timestamps
    end

    create_table :designations, id: :uuid do |t|
      t.string :name
      t.uuid :department_id

      t.timestamps
    end

    create_table :applicants, id: :uuid do |t|
      t.string :designation_name
      t.string :name
      t.string :contact_number
      t.string :email
      t.text   :location
      t.float :last_salary
      t.float :expected_ctc
      t.text   :notice_period
      t.string :open_for
      t.string :source

      t.timestamps
    end
  end
end
