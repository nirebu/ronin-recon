# frozen_string_literal: true
#
# ronin-recon - A micro-framework and tool for performing reconnaissance.
#
# Copyright (c) 2023 Hal Brodigan (postmodern.mod3@gmail.com)
#
# ronin-recon is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-recon is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-recon.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/recon/value'

require 'uri'

module Ronin
  module Recon
    module Values
      #
      # Represents a discovered URL.
      #
      # @api public
      #
      class URL < Value

        # The parsed URI.
        #
        # @return [URI::HTTP, URI::HTTPS]
        attr_reader :uri

        # The HTTP status of the URI.
        #
        # @return [Integer, nil]
        attr_reader :status

        # The HTTP response headers for the URI.
        #
        # @return [Hash{String => String}, nil]
        attr_reader :headers

        # The HTTP response body for the URI.
        #
        # @return [String, nil]
        attr_reader :body

        #
        # Initializes the URL object.
        #
        # @param [URI::HTTP, URI::HTTPS, String] url
        #
        # @param [Integer, nil] status
        #   The optional HTTP status of the URI.
        #
        # @param [Hash{String => String}, nil] headers
        #   The optional HTTP response headers for the URI.
        #
        # @param [String, nil] body
        #   The optional HTTP response body for the URI.
        #
        def initialize(url, status: nil, headers: nil, body: nil)
          @uri = URI(url)

          @status  = status
          @headers = headers
          @body    = body
        end

        #
        # Compares the value to another value.
        #
        # @param [Values::Value] other
        #
        # @return [Boolean]
        #
        def eql?(other)
          other.kind_of?(self.class) && @uri == other.uri
        end

        #
        # The "hash" value of the URL.
        #
        # @return [Integer]
        #   The hash value of {#uri}.
        #
        def hash
          [self.class, @uri].hash
        end

        alias to_uri uri

        #
        # Converts the URL object to a String.
        #
        # @return [String]
        #   The URL string.
        #
        def to_s
          @uri.to_s
        end

        alias to_str to_s

        #
        # Coerces the URL value into JSON.
        #
        # @return [Hash{Symbol => Object}]
        #   The Ruby Hash that will be converted into JSON.
        #
        def as_json
          hash = {type: :url, url: @uri.to_s}

          hash[:status]  = @status  if @status
          hash[:headers] = @headers if @headers
          hash[:body]    = @body    if @body

          return hash
        end

        #
        # Returns the type or kind of recon value.
        #
        # @return [:url]
        #
        # @note
        #   This is used internally to map a recon value class to a printable
        #   type.
        #
        # @api private
        #
        def self.value_type
          :url
        end

      end
    end
  end
end
