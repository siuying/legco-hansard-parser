# encoding: utf-8
require 'json'

module Legco
  module Hansard
    class Document
      attr_accessor :text
      attr_accessor :date      
      attr_accessor :data

      def initialize(text)
        @text = text
        @data = {}
      end

      def to_json
        JSON.pretty_generate(@data.merge({:date => date}))
      end
    end
  end
end