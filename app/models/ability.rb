class Ability
  include Hydra::Ability
  include Hyrax::Ability

  self.ability_logic += [
    :everyone_can_create_curation_concerns,
    :group_permissions,
    :superadmin_permissions
  ]

  # Define any customized permissions here.
  def custom_permissions
    can [:create], Account
  end

  def admin_permissions
    return unless admin?
    super
    can [:manage], [Site, Role, User]

    restrict_site_admin_permissions unless current_user.has_role? :superadmin
  end

  def group_permissions
    return unless admin?

    can :manage, Hyku::Group
  end

  def superadmin_permissions
    return unless current_user.has_role? :superadmin

    can :manage, :all
    can :peek, Hyku::Application
  end

  def restrict_site_admin_permissions
    # override curation_concerns admin roles to disable admin privileges on global models
    cannot [:manage, :create, :discover, :show, :read, :edit, :update, :destroy], global_models

    can [:read, :update], Account do |account|
      account == Site.account
    end
  end

  private

    def global_models
      [Account]
    end
end
