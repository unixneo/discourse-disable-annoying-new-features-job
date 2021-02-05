# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-job
# about: plugin to disable annoying job
# version: 0.0.63
# date: 4 January 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-job

PLUGIN_NAME = "discourse-disable-annoying-new-features-job"

after_initialize do
  DiscourseUpdates.mark_new_features_as_seen(current_user.id)
  module Jobs

    class CheckNewFeatures < ::Jobs::Scheduled
      class_eval do
        every 1.year

        def execute(args)
          puts "Annoying CheckNewFeatures Job disabled by plugin"
        end
      end
    end

  end

  module DiscourseUpdates
    class_eval do
      def perform_new_feature_check
        puts "Annoying CheckNewFeatures perform_new_feature_check method disabled by plugin"
      end  

      def unseen_new_features(user_id)
        DiscourseUpdates.mark_new_features_as_seen(user_id)
        return nil
      end
    end
  end
end

