import Foundation

func AnalyticsJSON(test: NSData) -> (json: NSDictionary) {
    var json = NSJSONSerialization.JSONObjectWithData(test, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    return json
}