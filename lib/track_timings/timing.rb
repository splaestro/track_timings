#!/usr/bin/env ruby

require 'time'

module TrackTimings

    # A convenience subclass of Time to use for timings; instantiates a 
    # UTC time n number of seconds from the epoch. Use Time#+ and #- 
    # to adjust durations and calculate track start and end points
    class Timing < Time

        BASE_TIME = Time.parse("1970-01-01 00:00:00 -0000")

        attr_reader :total_seconds

        def initialize(seconds)
            @total_seconds = seconds
            temp_time = Timing.at(@total_seconds)
            super(1970, 1, 1, temp_time.hour, temp_time.min, temp_time.sec, "+00:00")
            #super(BASE_TIME.year, BASE_TIME.month, BASE_TIME.day)
        end
        
        def Timing.at(seconds)
            super(seconds, in:"+00:00")
        end
        
        def Timing.parse(time_string)
            #TODO: also allow fractions of seconds--at present, any fractions will be discarded
            time_parts = time_string.split(/\:/)
            case time_parts.length
                when 2
                    hours, mins, secs = 0, time_parts[0].to_i, time_parts[1].to_i
                when 3
                    hours, mins, secs = time_parts[0].to_i, time_parts[1].to_i, time_parts[2].to_i
                else
                    raise ArgumentError, "Timing.parse expects a time spec like 'hh:MM:SS'"
            end
            Timing.new((hours * 3600) + (mins * 60) + secs)
        end
        
        def to_s
            self.strftime("%H:%M:%S")
        end
    end

end
