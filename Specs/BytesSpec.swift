import XCTest
import Quick
import Nimble
import Numeric

class BytesSpec: QuickSpec {
  override func spec() {
    it("knows values in bytes") {
      expect(1.byte).to(equal(1))
      expect(1.kilobyte).to(equal(1024))
      expect(1.megabyte).to(equal(1048576))
      expect(1.gigabyte).to(equal(1073741824))
      expect(1.terabyte).to(equal(1099511627776))
      expect(1.petabyte).to(equal(1125899906842624))
      expect(1.exabyte).to(equal(1152921504606846976))
    }

    it("can calculate with bytes") {
      expect(1.megabyte).to(equal(1024.kilobyte))
      expect(2048.kilobytes + 2.megabytes).to(equal(4.megabytes))
      expect(256.megabytes * 20 + 5.gigabytes).to(equal(10.gigabytes))
    }
  }
}