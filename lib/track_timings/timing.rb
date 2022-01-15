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
        # note that seconds can include a decimal portion
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
            #                   012         34        56      7
            parser = Regexp.new(/((\d{2}):)*((\d{2}):)((\d{2})(.(\d+))*)/)
            unless (parse_match = parser.match(time_string)) then
                raise ArgumentError, "Timing.parse expects a time spec like 'hh:MM:SS.nnn'"
            end
            hours, mins, secs = parse_match[2].to_i, parse_match[4].to_i, parse_match[5].to_f.round(3)
            #TODO: test fractional seconds more rigorously
            Timing.new(hours, mins, secs)
        end

        # return milliseconds as a 3-digit integer
        def millisec
            short_usec * 1000
        end

        # return seconds & milliseconds as a float
        def sec_with_frac
            short_usec + sec
        end

        def +(value)
            Timing.at(@total_seconds + value)
        end

        # what should the behavior be if the passed-in value > @total_seconds?
        def -(value)
            Timing.at(@total_seconds - value)
        end

        def to_s
            strftime("%H:%M:%S")
        end

        private

        # return milliseconds as a float (microseconds rounded to 3 digits)
        # this seems a bit tortured, but because of the larger precision of the
        # fractional second, we won't get the original decimal value passed in
        # (so compare `strftime "%3L`)
        def short_usec
            (to_f - tv_sec).round(3)
        end

    end

end
