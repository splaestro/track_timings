#!/usr/bin/env ruby

module TrackTimings

    # YACRMT: Yet Another Class Representing Music Track info... 
    # N.B. @duration is stored as a Timing (UTC time n number of seconds from the epoch)
    # so that we can use Time#+ and #- to adjust durations and calculate 
    # cumulative time of multiple tracks. 
    # TODO: @num is variously an int or a zero-filled string; clean this up.
    class Track

        FILE_EXTENSIONS = {"FLAC" => ".flac", "MP3" => ".mp3"}

        attr_reader :duration
        attr_accessor :artist, :album, :title, :format

        def initialize(num, artist, album, title, duration, format="FLAC")
            @num = num.to_i
            @artist = artist
            @album = album
            @title = title
            @duration = duration
            @duration = Timing.parse(duration) unless @duration.instance_of?(Timing)
            @format = format
        end

        def duration=(dur)
            @duration = dur
            @duration = Timing.parse(dur) unless dur.instance_of?(Timing)
        end

        def num=(numm)
            @num = numm.to_i
        end

        def num
            sprintf("%0*d", (@num < 10 ? 2 : @num.to_s.length), @num)
        end

        def number
            @num
        end

        def ext
            FILE_EXTENSIONS[@format]
        end

    end
    
end
