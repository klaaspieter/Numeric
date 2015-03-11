import Foundation

extension Double {
  public var byte: Double { return self }
  public var bytes: Double { return self }

  public var kilobyte: Double { return self.kilobytes }
  public var kilobytes: Double { return self.byte * 1024 }

  public var megabyte: Double { return self.megabytes }
  public var megabytes: Double { return self.kilobyte * 1024 }

  public var gigabyte: Double { return self.gigabytes }
  public var gigabytes: Double { return self.megabyte * 1024 }

  public var terabyte: Double { return self.terabytes }
  public var terabytes: Double { return self.gigabyte * 1024 }

  public var petabyte: Double { return self.petabytes }
  public var petabytes: Double { return self.terabyte * 1024 }

  public var exabyte: Double { return self.exabytes }
  public var exabytes: Double { return self.petabyte * 1024 }
}