class User < ApplicationRecord
    has_secure_password validations: false
    has_many :summary_translations, dependent: :destroy
    validates :phone_number, presence: true, uniqueness: true
    validates :verified, inclusion: { in: [true, false] }
    validates :password_digest, presence: true, length: { minimum: 6 }, if: -> { password_digest.present? }

    def reset_failed_attempts
        update(failed_attempts: 0, locked_at: nil)
    end
    
    def lock_account
        update(locked_at: Time.current)
    end
end
