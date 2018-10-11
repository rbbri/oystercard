class Journey

attr_reader :start, :end

def initialize(station)
  @start = station
  @end = nil
end

def finish(station)
  @end = station
end

def complete?
  !!@start && !!@end
end

def fare
  complete? ? 1 : 6
end

end
