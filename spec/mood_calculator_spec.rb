require 'spec_helper'
require 'mood_calculator'
require 'active_support/time'

# Refactored code according to www.betterspecs.or


describe MoodCalculator do 
  describe "run method behaviour" do 
    before(:each){ 
      @calc = MoodCalculator.new(MoodUser.new)
      @stamp = Time.new 2012,10,06, 13,33,45
      @midway = @stamp - 1.hours
      @limit = @stamp - 2.hours
    }
      
    def track id, stamp, name = "Dummy Song / Dummy"
      { music_id:id, timestamp:stamp, name: "m#{id}", artist:"a#{id}"}
    end

    def commit id, stamp
      { commit_id:id, timestamp:stamp}
    end

    def count music_id, count
      { music_id:music_id, count:count, name: "m#{music_id}", artist:"a#{music_id}"}
    end

    context "Empty entry data" do 
      it "[],[] must respond with: []" do
        expect(@calc.run [],[] ).to eq []
      end
      it "[],* must respond with: []" do
        expect(@calc.run [],[commit(1,Time.now)]).to eq []
      end
      it "*,[] must respond with: []" do
        expect(@calc.run [track(1,Time.now)],[]).to eq []
      end
    end

    # Description:
    # the track stack is backwards. The first element being the submit stamp
    # the second element should have an ealier chronological time.
    # this test should return only two tracks , since the third track is before 2 hours
    # from commit stamp

    context "One commit in a time.delta >= 2 hours" do 
      it "must respond with: count(1,1),count(2,1)" do
        expect(
          @calc.run [ 
                      track(1,@stamp),
                      track(2,@limit+1.minutes),
                      track(3,@limit-1.minutes),
                    ],
                    [commit(1,@stamp)]
        ).to eq [count(1,1), count(2,1)]
      end
      it "[Edge Case] must respond with: count(1,1), count(1,2)" do
        expect(
          @calc.run [ 
                      track(1,@stamp),
                      track(2,@limit+1.minutes),
                      track(3,@limit),
                      track(4,@limit-1.minutes),
                    ],
                    [commit(1,@stamp)]
        ).to eq [count(1,1), count(2,1)]
      end
    end
  
    context "Multiple commits" do 
      it "must respond with: count(1,1), count(2,1), count(3,1)" do
        expect(
          @calc.run [
                      track(1,@stamp),
                      track(2,@limit+1.minutes),
                      track(3,@limit-1.minutes),
                    ],
                    [ 
                      commit(1,@stamp),
                      commit(2,@limit)
                    ]
        ).to eq [ count(1,1), count(2,1), count(3,1)]
      end
      # # included this one:  
      # It should be able to get the track 2 hours+1 minute before the earliest commit at @limit
      it "must respond with: count(1,1), count(2,1), count(3,1), count(4,1)" do
        expect(
          @calc.run [ 
                      track(1,@stamp),
                      track(2,@limit+1.minutes),
                      track(3,@limit-1.minutes),
                      track(4,@limit-2.hours+1.minutes)
                    ],
                    [ 
                      commit(1,@stamp),
                      commit(2,@limit)
                    ]
        ).to eq [ count(1,1), count(2,1), count(3,1), count(4,1)]
      end
    end

  context "Track handling" do
    # description: it must not count the same track twice
    it "must respond with: count(1,1),count(2,1),count(3,1)" do
      expect(
        @calc.run [ 
                    track(1,@stamp),
                    track(2,@limit+1.minutes),
                    track(3,@limit-1.minutes),
                  ],
                [ 
                  commit(1,@stamp),
                  commit(2,@midway)
                ]
      ).to eq [count(1,1), count(2,1), count(3,1)]
    end
    # description check if the function counts the tracks
    it "must respond with: count(1,3)" do
      expect(
        @calc.run [ 
                    track(1,@stamp),
                    track(1,@stamp-5.minutes),
                    track(1,@stamp-10.minutes),
                ],
                [commit(1,@stamp)]
      ).to eq [count(1,3)]
    end
    # description order results
    it "must respond with: sorted list of track counts (1,3),(2,2),(3,1)" do
      expect(
        @calc.run [ 
                    track(2,@stamp),
                    track(1,@stamp),
                    track(3,@stamp),
                    track(1,@stamp),
                    track(2,@stamp),
                    track(1,@stamp),
                  ],
                  [ commit(1,@stamp)]
      ).to eq [count(1,3),count(2,2),count(3,1)]
    end
  end
  end #describe run method
end # describe MoodCalculator


  
















#end