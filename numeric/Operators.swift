import Foundation

let calendarUnits: [NSCalendarUnit] = [
  NSCalendarUnit.CalendarUnitEra,
  NSCalendarUnit.CalendarUnitYear,
  NSCalendarUnit.CalendarUnitMonth,
  NSCalendarUnit.CalendarUnitDay,
  NSCalendarUnit.CalendarUnitHour,
  NSCalendarUnit.CalendarUnitMinute,
  NSCalendarUnit.CalendarUnitSecond,
  NSCalendarUnit.CalendarUnitNanosecond,
  NSCalendarUnit.CalendarUnitWeekday,
  NSCalendarUnit.CalendarUnitWeekdayOrdinal,
  NSCalendarUnit.CalendarUnitQuarter,
  NSCalendarUnit.CalendarUnitWeekOfMonth,
  NSCalendarUnit.CalendarUnitWeekOfYear,
  NSCalendarUnit.CalendarUnitYearForWeekOfYear
]

public func apply(lhs: NSDateComponents, rhs: NSDateComponents, f: ((Int, Int) -> Int)) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let leftValue = lhs.valueForComponent(unit)
    let rightValue = rhs.valueForComponent(unit)
    var value: Int

    if leftValue != Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = f(leftValue, rightValue)
    } else if leftValue == Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = f(0, rightValue)
    } else {
      value = leftValue
    }

    lhs.setValue(value, forComponent: unit)
  }
  return lhs
}

// NSDateComponents
public func +(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
  return apply(lhs, rhs, +)
}

public func -(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
  return apply(lhs, rhs, -)
}

// Prefix operators
public prefix func +(components: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let value = components.valueForComponent(unit)
    if value != Int(NSDateComponentUndefined) {
      components.setValue(abs(value), forComponent:unit)
    }
  }
  return components
}

public prefix func -(components: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let value = components.valueForComponent(unit)
    if value != Int(NSDateComponentUndefined) {
      components.setValue(abs(value) * -1, forComponent:unit)
    }
  }
  return components
}

// NSDate and NSDateComponents
public func +(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(components, toDate: date, options: .allZeros) ?? date
}

public func-(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(-components, toDate: date, options: .allZeros) ?? date
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedAscending
}
extension NSDate: Comparable { }
