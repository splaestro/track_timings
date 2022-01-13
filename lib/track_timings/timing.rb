#!/usr/bin/env ruby

require 'time'

module TrackTimings

    # A convenience subclass of Time to use for timings; instantiates a 
    # UTC time n number of seconds from the epoch. Use Time#+ and #- 
    # to adjust durations and calculate track start and end points
    class Timing < Time

        BASE_TIME = Time.parse("1970-01-01 00:00:00 -0000")

        attr_reader :total_seconds

        # both ::at and ::parse should call this function
        def initialize(hours, minutes, seconds)
            @total_seconds = (hours * 3600) + (minutes * 60) + seconds
            super(1970, 1, 1, hours, minutes, seconds, "+00:00")
        end
        
        def Timing.at(seconds)
            hours = seconds/3600
            minutes = (seconds%3600)/60
            seconds = (seconds%3600)%60
            Timing.new(hours, minutes, seconds)
            # super(seconds, millisecs, :millisecond, in:"+00:00")
        end

        def Timing.parse(time_string)
            #                   012         34        5      6 7 
            parser = Regexp.new(/((\d{2}):)*((\d{2}):)(\d{2})(.(\d+))*/)
            unless (parse_match = parser.match(time_string)) then
                raise ArgumentError, "Timing.parse expects a time spec like 'hh:MM:SS.nnn'"
            end
            hours, mins, secs = parse_match[2].to_i, parse_match[4].to_i, parse_match[5].to_i
            # millisecs = parse_match[7].to_i
            #TODO: also allow fractions of seconds--at present, any fractions are discarded
            Timing.new(hours, mins, secs)
        end
        
        def to_s
            self.strftime("%H:%M:%S")
        end
    end

end
