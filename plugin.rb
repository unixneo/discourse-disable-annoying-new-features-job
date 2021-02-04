# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-job
# about: plugin to disable annoying job
# version: 0.0.6
# date: 4 January 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-job

PLUGIN_NAME = "discourse-disable-annoying-new-features-job"

after_initialize do
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
        puts "Annoying CheckNewFeatures Method disabled by plugin"
      end  
    end
  end
end

