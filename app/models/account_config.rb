# frozen_string_literal: true

# == Schema Information
#
# Table name: account_configs
#
#  id         :bigint           not null, primary key
#  key        :string           not null
#  value      :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_account_configs_on_account_id          (account_id)
#  index_account_configs_on_account_id_and_key  (account_id,key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class AccountConfig < ApplicationRecord
  SUBMITTER_INVITATION_EMAIL_KEY = 'submitter_invitation_email'
  SUBMITTER_COMPLETED_EMAIL_KEY = 'submitter_completed_email'
  SUBMITTER_DOCUMENTS_COPY_EMAIL_KEY = 'submitter_documents_copy_email'
  BCC_EMAILS = 'bcc_emails'
  SUBMITTER_REMAILERS = 'submitter_reminders'

  DEFAULT_VALUES = {
    SUBMITTER_INVITATION_EMAIL_KEY => {
      'subject' => 'You have been invited to submit a form',
      'body' => "Hi there,\n\n" \
                "You have been invited to submit the \"{{template.name}}\" form:\n\n" \
                "{{submitter.link}}\n\n" \
                "Please contact us by replying to this email if you didn't request this.\n\n" \
                "Thanks,\n" \
                '{{account.name}}'
    },
    SUBMITTER_COMPLETED_EMAIL_KEY => {
      'subject' => '{{template.name}} has been completed by {{submission.submitters}}',
      'body' => "Hi,\n\n" \
                "\"{{template.name}}\" form has been completed by {{submission.submitters}}\n\n" \
                '{{submission.link}}'
    },
    SUBMITTER_DOCUMENTS_COPY_EMAIL_KEY => {
      'subject' => 'Your copy of documents',
      'body' => "Hi there,\n\n" \
                "Please check the copy of your \"{{template.name}}\" submission in the email attachments.\n" \
                "Alternatively, you can download the copy using:\n\n" \
                "{{documents.links}}\n\n" \
                "Thanks,\n" \
                '{{account.name}}'
    }
  }.freeze

  belongs_to :account

  serialize :value, JSON
end
