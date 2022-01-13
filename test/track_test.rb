require "test_helper"
require "track_timings"

class TrackTest < Minitest::Test

    def setup
        @trak = TrackTimings::Track.new(1, "Brian Eno", "Another Green World", \
            "Sky Saw", "03:27")
        $stdout.puts name
    end

    def test_instance
        assert_instance_of(TrackTimings::Track, @trak)
    end

    def test_members
        assert_equal("01", @trak.num)
        assert_equal(1, @trak.number)
        assert_equal("Brian Eno", @trak.artist)
        assert_equal("Another Green World", @trak.album)
        assert_equal("Sky Saw", @trak.title)
        assert_equal("00:03:27", @trak.duration.to_s)
        assert_equal("FLAC", @trak.format)
        assert_equal(".flac", @trak.ext)
    end

    def test_duration
        assert_instance_of(TrackTimings::Timing, @trak.duration)
        assert_kind_of(Time, @trak.duration)
    end
    
    def test_change_duration
        assert_equal(0, @trak.duration.hour)
        assert_equal(3, @trak.duration.min)
        assert_equal(27, @trak.duration.sec)

        @trak.duration = TrackTimings::Timing.parse("05:43.045")
        assert_equal(0, @trak.duration.hour)
        assert_equal(5, @trak.duration.min)
        assert_equal(43, @trak.duration.sec)

        @trak.duration = "02:34:03"
        assert_equal(2, @trak.duration.hour)
        assert_equal(34, @trak.duration.min)
        assert_equal(3, @trak.duration.sec)
    end
    
    def test_to_s
        skip
    end

end
