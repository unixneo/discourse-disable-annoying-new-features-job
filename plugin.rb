# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-job
# about: plugin to disable annoying job
# version: 0.0.1
# date: 4 January 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-job

PLUGIN_NAME = "discourse-disable-annoying-new-features-job"

after_initialize do
  module Jobs

    class CheckNewFeatures.class_eval do
      every 1.day

      def execute(args)
        puts "CheckNewFeatures Job disabled"
      end
    end

  end
end

