# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Template, account_id: user.account_id
    can :manage, Submission, template: { account_id: user.account_id }
    can :manage, Submitter, template: { account_id: user.account_id }
    can :manage, User, account_id: user.account_id
    can :manage, EncryptedConfig, account_id: user.account_id
    can :manage, AccountConfig, account_id: user.account_id
    can :manage, Account, id: user.account_id
    can :manage, AccessToken, user_id: user.id
  end
end
