require './lib/station.rb'

class Journey
attr_reader :starting_journey

  def initialize
    @starting_journey = nil
    @finish_station = nil
    @fare = 1
    @journey_log = JourneyLog.new
  end

  def start_journey(station)
    @fare = 6 if in_journey?
    @starting_journey = @journey_log.log_entry(station)
  end

  def finish_journey(station)
    @fare = 6 unless in_journey?
    @finish_station = @journey_log.log_exit(station)
    do_finish
  end

  def fare
    @fare
  end

  private

  def zoneprice(station)
    return @fare if station == nil
    case station.zone
      when 1
        @fare = 2 if @finish_station.zone == 2
        far_away

      when 2
        @fare = 2 if @finish_station.zone == 1
        far_away
      else
        @fare = 3
    end
  end

  def far_away
    @fare = 3 if @finish_station.zone > 2
  end

  def do_finish
    zoneprice(@starting_journey)
    @starting_journey = nil
    @finish_station
  end

  def in_journey?
    !!@starting_journey
  end

end
