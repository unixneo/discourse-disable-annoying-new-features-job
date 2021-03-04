# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-notice
# about: plugin to disable annoying new features notice in admin dashboard
# version: 0.125
# date: 4 March 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-notice.git

PLUGIN_NAME = "discourse-disable-annoying-new-features-notice"

enabled_site_setting :enable_disable_annoying_new_features_notice

after_initialize do
  reloadable_patch do
    if SiteSetting.enable_disable_annoying_new_features_notice?
      Admin::DashboardController.class_eval do
        if SiteSetting.disable_new_features_dismissable_notice?
          before_action :mark_annoying_new_features_as_seen
        end

        if SiteSetting.disable_new_features_fixed_notice?
          def new_features;end
        end

        private 
        def mark_annoying_new_features_as_seen
          DiscourseUpdates.mark_new_features_as_seen(current_user.id)
        end
      end
    end
  end
end

