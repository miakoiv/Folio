module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    scope :deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
  end

  def delete
    touch(:deleted_at) if has_attribute?(:deleted_at)
  end

  def destroy
    callbacks_result = transaction do
      run_callbacks :destroy do
        delete
      end
    end
    callbacks_result ? self : false
  end
end
