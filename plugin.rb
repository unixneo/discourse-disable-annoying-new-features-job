# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-notice
# about: plugin to disable annoying new features notice in admin dashboard
# version: 0.137
# date: 5 March 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-notice.git

PLUGIN_NAME = "discourse-disable-annoying-new-features-notice"

enabled_site_setting :enable_disable_annoying_new_features_notice

after_initialize do
  Admin::DashboardController.class_eval do
    before_action :mark_annoying_new_features_as_seen

    def new_features
      if SiteSetting.enable_disable_annoying_new_features_notice? && SiteSetting.disable_new_features_fixed_notice?
          data = {
            new_features: nil,
            has_unseen_features: false,
            release_notes_link: AdminDashboardGeneralData.fetch_cached_stats["release_notes_link"]
          }
          render json: data
      else
        data = {
          new_features: DiscourseUpdates.new_features,
          has_unseen_features: DiscourseUpdates.has_unseen_features?(current_user.id),
          release_notes_link: AdminDashboardGeneralData.fetch_cached_stats["release_notes_link"]
        }
        render json: data
      end
    end

    private 
    def mark_annoying_new_features_as_seen
      if SiteSetting.enable_disable_annoying_new_features_notice? && SiteSetting.disable_new_features_dismissable_notice?
        DiscourseUpdates.mark_new_features_as_seen(current_user.id)
      end
    end
  end
end

