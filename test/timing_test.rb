require "test_helper"
require "track_timings"

class TimingTest < Minitest::Test

    def setup
        @tyming = TrackTimings::Timing.new(300)
        $stdout.puts name
    end

    def test_instance
        assert_instance_of(TrackTimings::Timing, @tyming)
        assert_kind_of(Time, @tyming)
    end

    def test_members
        assert_equal(1970, @tyming.year)
        assert_equal(1, @tyming.month)
        assert_equal(1, @tyming.day)
        assert_equal(0, @tyming.hour)
        assert_equal(5, @tyming.min)
        assert_equal(0, @tyming.sec)
        assert_equal(300, @tyming.total_seconds)
    end
    
    def test_parse
        parse_tyming1 = TrackTimings::Timing.parse("05:00")
        assert_equal(@tyming, parse_tyming1)

        parse_tyming2 = TrackTimings::Timing.parse("28:22")
        refute_equal(@tyming, parse_tyming2)
        
        parse_tyming3 = TrackTimings::Timing.parse("01:28:22")
        refute_equal(parse_tyming2, parse_tyming3)
        assert_equal(1, parse_tyming3.hour)
        assert_equal(28, parse_tyming3.min)
        assert_equal(22, parse_tyming3.sec)
        assert_equal(5302, parse_tyming3.total_seconds)

        #assert_raises(ArgumentError) {TrackTimings::Timing.parse("AA:BB.CCCC")}
        assert_raises(ArgumentError) {TrackTimings::Timing.parse("foo")}
    end
    
    def test_to_s
        assert_equal("00:05:00", @tyming.to_s)
    end

    def test_add
        skip
        assert_equal()
    end

end
