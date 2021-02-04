# frozen_string_literal: true

# name: discourse-disable-annoying-new-features-job
# about: plugin to disable annoying job
# version: 0.0.4
# date: 4 January 2020
# authors: Neo
# url: https://github.com/unixneo/discourse-disable-annoying-new-features-job

PLUGIN_NAME = "discourse-disable-annoying-new-features-job"

after_initialize do
  module Jobs

    CheckNewFeatures.class_eval do
      every 1.year

      def execute(args)
        puts "Annoying CheckNewFeatures Job disabled by plugin"
      end
    end

  end
end

