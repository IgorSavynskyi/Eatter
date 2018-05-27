import XCTest
@testable import Eatter

class EatterTests: XCTestCase {
    func testNilPostcodeValidation() {
        XCTAssertEqual(Validator.isValidPostCode(nil), false, "Postcode shouldn't be validated")
    }
    
    func testTooShortPostcodeValidation() {
        XCTAssertEqual(Validator.isValidPostCode("a"), false, "Postcode shouldn't be validated")
    }
    
    func testTooLongPostcodeValidation() {
        XCTAssertEqual(Validator.isValidPostCode("abcdefg1234abcd 1234rf"), false, "Postcode shouldn't be validated")
    }
    
    func testDefaultPostcodeValidation() {
        XCTAssertEqual(Validator.isValidPostCode("se19"), true, "Postcode should be validated")
    }
    
}
