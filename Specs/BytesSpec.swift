import XCTest
import Quick
import Nimble
import Numeric

class BytesSpec: QuickSpec {
  override func spec() {
    it("knows values in bytes") {
      expect(1.byte) == 1
      expect(1.kilobyte) == 1024
      expect(1.megabyte) == 1048576
      expect(1.gigabyte) == 1073741824
      expect(1.terabyte) == 1099511627776
      expect(1.petabyte) == 1125899906842624
      expect(1.exabyte) == 1152921504606846976
    }

    it("can calculate with bytes") {
      expect(1.megabyte) == 1024.kilobyte
      expect(2048.kilobytes + 2.megabytes) == 4.megabytes
      expect(256.megabytes * 20 + 5.gigabytes) == 10.gigabytes
    }

    it("supports double types") {
      expect(5.4.gigabytes) == 5798205849.6
    }

    it("supports float types") {
      expect(Float(2.2).terabyte) == 2418925581107.2
    }
  }
}