# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-notice
# about: plugin to disable annoying new features notice in admin dashboard
# version: 0.138
# date: 5 March 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-notice.git

PLUGIN_NAME = "discourse-disable-annoying-new-features-notice"

enabled_site_setting :enable_disable_annoying_new_features_notice

after_initialize do
  Admin::DashboardController.class_eval do
    before_action :mark_annoying_new_features_as_seen

    def new_features
      new_features = DiscourseUpdates.new_features
      has_unseen_features = DiscourseUpdates.has_unseen_features?(current_user.id)
      if SiteSetting.enable_disable_annoying_new_features_notice? && SiteSetting.disable_new_features_fixed_notice?
          new_features = nil
          has_unseen_features = false
      end
      data = {
        new_features: new_features,
        has_unseen_features: has_unseen_features,
        release_notes_link: AdminDashboardGeneralData.fetch_cached_stats["release_notes_link"]
      }   
      render json: data
    end

    private 
    def mark_annoying_new_features_as_seen
      if SiteSetting.enable_disable_annoying_new_features_notice? && SiteSetting.disable_new_features_dismissable_notice?
        DiscourseUpdates.mark_new_features_as_seen(current_user.id)
      end
    end
  end
end

