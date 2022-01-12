#!/usr/bin/env ruby

require 'time'

module TrackTimings

    # YACRMT: Yet Another Class Representing Music Track info... 
    # N.B. @duration is stored as a UTC time n number of seconds from the epoch
    # so that we can use Time#+ and #- to adjust durations and calculate 
    # cumulative time of multiple tracks. 
    # TODO: @num is variously an int or a zero-filled string; clean this up.
    class Track

        FILE_EXTENSIONS = {"FLAC" => ".flac", "MP3" => ".mp3"}

        attr_accessor :artist, :album, :title, :duration, :format

        def initialize(num, artist, album, title, duration, format="FLAC")
            @num = num.to_i
            @artist = artist
            @album = album
            @title = title
            @duration = duration
            unless @duration.instance_of?(Time)
                #TODO: fix this for durations > 60 minutes
                @duration = Time.parse(sprintf("1970-01-01 00:0%s -0000", duration))
            end
            @format = format
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
