import Foundation

func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    return NSString(data: inputData, encoding:NSUTF8StringEncoding).stringByReplacingOccurrencesOfString("\n", withString:"")
}

func get_urlPath(PostID: String, AccessToken: String
    ) -> (urlPath_Likes: String, urlPath_SharedPosts: String) {
    var urlPath_Likes = "https://graph.facebook.com/" + PostID + "/likes?limit=1000&access_token=" + AccessToken
    var urlPath_SharedPosts = "https://graph.facebook.com/" + PostID + "/sharedposts?limit=500&access_token=" + AccessToken
    return (urlPath_Likes, urlPath_SharedPosts)
}

func AnalyticsJSON_Likes(URLPath_Likes: String) -> (storeUID_Likes: NSMutableString, FacebookUID_Flag: Int, nextFlag: NSArray, NextURLPath_Likes: String) {
    var url_Likes: NSURL = NSURL(string: URLPath_Likes)
    var URLRequest: NSURLRequest = NSURLRequest(URL: url_Likes)
    var DataResponse: NSData = NSURLConnection.sendSynchronousRequest(URLRequest, returningResponse: nil, error: nil)
    var JSONData_Likes = NSJSONSerialization.JSONObjectWithData(DataResponse, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    var FacebookUID_Likes = JSONData_Likes["data"].valueForKey("id") as NSArray
    var storeUID_Likes: NSMutableString = ""
    var FacebookUID_Flag = FacebookUID_Likes.count
    var getNextFlag: NSDictionary
    var nextFlag: NSArray = []
    var NextURLPath_Likes: String = ""

    for var i = 0; i < FacebookUID_Likes.count; ++i {
        storeUID_Likes.appendFormat("%@\n", FacebookUID_Likes.objectAtIndex(i).stringByStandardizingPath)
    }

    if FacebookUID_Likes.count == 1000 {
        getNextFlag = JSONData_Likes["paging"] as NSDictionary
        nextFlag = getNextFlag.allKeys
        if nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next" {
            NextURLPath_Likes = JSONData_Likes["paging"].valueForKey("next").stringByStandardizingPath
        }
    }

    return (storeUID_Likes, FacebookUID_Flag, nextFlag, NextURLPath_Likes)
}

func AnalyticsJSON_SharedPosts(URLPath_SharedPosts: String) -> (storeUID_SharedPosts: NSMutableString, FacebookUID_Flag: Int, nextFlag: NSArray, NextURLPath_SharedPosts: String) {
    var url_SharedPosts: NSURL = NSURL(string: URLPath_SharedPosts)
    var URLRequest: NSURLRequest = NSURLRequest(URL: url_SharedPosts)
    var DataResponse: NSData = NSURLConnection.sendSynchronousRequest(URLRequest, returningResponse: nil, error: nil)
    var JSONData_SharedPosts = NSJSONSerialization.JSONObjectWithData(DataResponse, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    var FacebookUID_SharedPosts = JSONData_SharedPosts["data"].valueForKey("from") as NSArray
    var storeUID_SharedPosts: NSMutableString = ""
    var FacebookUID_Flag = FacebookUID_SharedPosts.count
    var getNextFlag: NSDictionary
    var nextFlag: NSArray = []
    var NextURLPath_SharedPosts: String = ""
    var flag = 0
    
    for var i = 0; i < FacebookUID_SharedPosts.count; ++i {
        storeUID_SharedPosts.appendFormat("%@\n", FacebookUID_SharedPosts.objectAtIndex(i).valueForKey("id").stringByStandardizingPath)
    }
    
    getNextFlag = JSONData_SharedPosts["paging"] as NSDictionary
    nextFlag = getNextFlag.allKeys
    if nextFlag.count == 1 {
        flag = 4
    }else if nextFlag[0] as NSString == "cursors" && nextFlag[1] as NSString == "next" {
        flag = 1
    }else if nextFlag.count == 3 {
        flag = 2
    }else if nextFlag[0] as NSString == "cursors" && nextFlag[1] as NSString == "previous" {
        flag = 3
    }

    switch flag {
    case 1:
        NextURLPath_SharedPosts = JSONData_SharedPosts["paging"].valueForKey("next").stringByStandardizingPath
    case 2:
        NextURLPath_SharedPosts = JSONData_SharedPosts["paging"].valueForKey("next").stringByStandardizingPath
    case 3:
        break
    case 4:
        break
    default:
        break
    }
    
    return (storeUID_SharedPosts, FacebookUID_Flag, nextFlag, NextURLPath_SharedPosts)
}

func SaveToFile(outputFile: NSMutableString) {
    println(outputFile)
    outputFile.writeToFile("/Users/cyrix/Desktop/uid.csv", atomically: true, encoding: NSUTF8StringEncoding, error: nil)
    println("Enjoy!")
}
