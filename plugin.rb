# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-notice
# about: plugin to disable annoying new features notice in admin dashboard
# version: 0.1.1
# date: 5 January 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-notice.git

PLUGIN_NAME = "discourse-disable-annoying-new-features-notice"

after_initialize do
  Admin::DashboardController.class_eval do
    before_action :mark_annoying_new_features_as_seen
    private 
    def mark_annoying_new_features_as_seen
      DiscourseUpdates.mark_new_features_as_seen(current_user.id)
    end
  end
end

