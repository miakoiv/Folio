class TwoFactorAuthenticationAddToUsers < ActiveRecord::Migration
  def change
    add_column :users, :two_factor_enabled, :boolean, null: false, default: false, after: :expires_at
    add_column :users, :unconfirmed_two_factor, :boolean, null: false, default: false, after: :two_factor_enabled
    add_column :users, :second_factor_attempts_count, :integer, default: 0, after: :unconfirmed_two_factor
    add_column :users, :encrypted_otp_secret_key, :string, after: :second_factor_attempts_count
    add_column :users, :encrypted_otp_secret_key_iv, :string, after: :encrypted_otp_secret_key
    add_column :users, :encrypted_otp_secret_key_salt, :string, after: :encrypted_otp_secret_key_iv
    add_column :users, :direct_otp, :string, after: :encrypted_otp_secret_key_salt
    add_column :users, :direct_otp_sent_at, :datetime, after: :direct_otp
    add_column :users, :totp_timestamp, :timestamp, after: :direct_otp_sent_at

    add_index :users, :encrypted_otp_secret_key, unique: true
  end
end
