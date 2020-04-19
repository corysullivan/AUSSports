import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        return [
            testCase(AUS_APITests.allTests),
        ]
    }
#endif
