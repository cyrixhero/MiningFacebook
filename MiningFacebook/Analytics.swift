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

func AnalyticsJSON_Likes(getURLPath_Likes: String) -> (JSONData_Likes: NSDictionary) {
    var url_Likes: NSURL = NSURL(string: getURLPath_Likes)
    var URLRequest: NSURLRequest = NSURLRequest(URL: url_Likes)
    var DataResponse: NSData = NSURLConnection.sendSynchronousRequest(URLRequest, returningResponse: nil, error: nil)
    var JSONData_Likes = NSJSONSerialization.JSONObjectWithData(DataResponse, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

    return JSONData_Likes
}

func AnalyticsJSON_SharedPosts(getURLPath_SharedPosts: String) -> (JSONData_SharedPosts: NSDictionary) {
    var url_SharedPosts: NSURL = NSURL(string: getURLPath_SharedPosts)
    var URLRequest: NSURLRequest = NSURLRequest(URL: url_SharedPosts)
    var DataResponse: NSData = NSURLConnection.sendSynchronousRequest(URLRequest, returningResponse: nil, error: nil)
    var JSONData_SharedPosts = NSJSONSerialization.JSONObjectWithData(DataResponse, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    
    return JSONData_SharedPosts
}
