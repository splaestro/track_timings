require "test_helper"
require "track_timings"

class TimingTest < Minitest::Test

    def setup
        @tyming = TrackTimings::Timing.new(0, 5 ,0)
        #$stdout.puts name
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
        assert_equal(0, @tyming.millisec)
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
        assert_equal(0, parse_tyming3.millisec)
        assert_equal(5302, parse_tyming3.total_seconds)

        parse_tyming4 = TrackTimings::Timing.parse("01:28:22.839")
        # interestingly, when the below is true, "assert_equal(parse_tyming3, parse_tyming4)" is also true!
        refute_equal(parse_tyming3.usec, parse_tyming4.usec)
        assert_equal(1, parse_tyming4.hour)
        assert_equal(28, parse_tyming4.min)
        assert_equal(22, parse_tyming4.sec)
        assert_equal(839, parse_tyming4.millisec)
        assert_equal(22.839, parse_tyming4.sec_with_frac)
        assert_equal(5302.839, parse_tyming4.total_seconds)

        assert_raises(ArgumentError) {TrackTimings::Timing.parse("foo")}
        assert_raises(ArgumentError) {TrackTimings::Timing.parse("AA:BB.CCCC")}
        # note: leading zeroes are required!!
        assert_raises(ArgumentError) {TrackTimings::Timing.parse("5:24")}
    end
    
    def test_to_s
        assert_equal("00:05:00", @tyming.to_s)
        #TODO: fix this!!!!
        #refute_equal("839", TrackTimings::Timing.parse("01:28:22.839").strftime("%3L"))
    end

    def test_at
        at_tyming = TrackTimings::Timing.at(5000)
        assert_instance_of(TrackTimings::Timing, at_tyming)
        assert_kind_of(Time, at_tyming)
        assert_equal(1, at_tyming.hour)
        assert_equal(23, at_tyming.min)
        assert_equal(20, at_tyming.sec)
        assert_equal(5000, at_tyming.total_seconds)
    end

    def test_plus_simple
        plussed = @tyming + 300
        refute_equal(@tyming, plussed)
        assert_instance_of(TrackTimings::Timing, plussed)

        assert_equal(1970, plussed.year)
        assert_equal(1, plussed.month)
        assert_equal(1, plussed.day)
        assert_equal(0, plussed.hour)
        assert_equal(10,plussed.min)
        assert_equal(0, plussed.sec)
        assert_equal(600, plussed.total_seconds)
      
    end

    def test_minus_simple
        minused = @tyming - 60
        refute_equal(@tyming, minused)
        assert_instance_of(TrackTimings::Timing, minused)
        
        assert_equal(1970, minused.year)
        assert_equal(1, minused.month)
        assert_equal(1, minused.day)
        assert_equal(0, minused.hour)
        assert_equal(4, minused.min)
        assert_equal(0,  minused.sec)
        assert_equal(240, minused.total_seconds)

    end

end
