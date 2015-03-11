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

public func +(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let leftValue = lhs.valueForComponent(unit)
    let rightValue = rhs.valueForComponent(unit)
    var value: Int

    if leftValue != Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = leftValue + rightValue
    } else if leftValue == Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = rightValue
    } else {
      value = leftValue
    }

    lhs.setValue(value, forComponent: unit)
  }
  return lhs
}

public func +(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(components, toDate: date, options: .allZeros) ?? date
}

public prefix func +(components: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let value = components.valueForComponent(unit)
    if value != Int(NSDateComponentUndefined) {
      components.setValue(abs(value), forComponent:unit)
    }
  }
  return components
}

public func -(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let leftValue = lhs.valueForComponent(unit)
    let rightValue = rhs.valueForComponent(unit)
    var value: Int

    if leftValue != Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = leftValue - rightValue
    } else if leftValue == Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = -rightValue
    } else {
      value = leftValue
    }

    lhs.setValue(value, forComponent: unit)
  }
  return lhs
}

public func-(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(-components, toDate: date, options: .allZeros) ?? date
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

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedAscending
}
extension NSDate: Comparable { }
