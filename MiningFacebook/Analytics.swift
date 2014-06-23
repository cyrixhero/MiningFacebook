import Foundation

func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    return NSString(data: inputData, encoding:NSUTF8StringEncoding).stringByReplacingOccurrencesOfString("\n", withString:"")
}

func get_urlPath(getPostID: String, getAccessToken: String
    ) -> (urlPath_Likes: String, urlPath_SharedPosts: String) {
    var urlPath_Likes = "https://graph.facebook.com/" + getPostID + "/likes?limit=1000&access_token=" + getAccessToken
    var urlPath_SharedPosts = "https://graph.facebook.com/" + getPostID + "/sharedposts?limit=1000&access_token=" + getAccessToken
    return (urlPath_Likes, urlPath_SharedPosts)
}

//func AnalyticsJSON(test: NSData) -> (json: NSDictionary) {
//    var json = NSJSONSerialization.JSONObjectWithData(test, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//    return json
//}

