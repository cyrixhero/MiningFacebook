import Foundation

func MiningPost() {
    println("AccessToken: ")
    var AccessToken = input()
    var terminate: String

    do {
        println("{Post-ID}: ")
        var PostID = input()
        
        var urlPath_Likes = "https://graph.facebook.com/" + PostID + "/likes?limit=1000&access_token=" + AccessToken
        var url_Likes: NSURL
        var urlPath_SharedPosts = "https://graph.facebook.com/" + PostID + "/sharedposts?limit=1000&access_token=" + AccessToken
        var url_SharedPosts: NSURL

        var request: NSURLRequest
        var response: NSData
        var JSONData: NSDictionary
        var FacebookUID: NSArray
        var outputFile: NSMutableString = ""
        var getNextFlag: NSDictionary
        var nextFlag: NSArray
        var FileName: String
        
        do {
            url_Likes = NSURL(string: urlPath_Likes)
            request = NSURLRequest(URL: url_Likes)
            response = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            JSONData = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            FacebookUID = JSONData["data"].valueForKey("id") as NSArray
            
            for var i = 0; i < FacebookUID.count; ++i {
                outputFile.appendFormat("%@\n", FacebookUID.objectAtIndex(i).stringByStandardizingPath)
            }
            if FacebookUID.count < 1000 {
                break
            }else {
                getNextFlag = JSONData["paging"] as NSDictionary
                nextFlag = getNextFlag.allKeys
                if nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next" {
                    urlPath_Likes = JSONData["paging"].valueForKey("next").stringByStandardizingPath
                }
            }
        } while nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next"

        do {
            url_SharedPosts = NSURL(string: urlPath_SharedPosts)
            request = NSURLRequest(URL: url_SharedPosts)
            response = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            JSONData = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            FacebookUID = JSONData["data"].valueForKey("from") as NSArray
        
            for var i = 0; i < FacebookUID.count; ++i {
                outputFile.appendFormat("%@\n", FacebookUID.objectAtIndex(i).valueForKey("id").stringByStandardizingPath)
            }
            if FacebookUID.count < 1000 {
                break
            }else {
                getNextFlag = JSONData["paging"] as NSDictionary
                nextFlag = getNextFlag.allKeys
                if nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next" {
                    urlPath_SharedPosts = JSONData["paging"].valueForKey("next").stringByStandardizingPath
                }
            }
        } while nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next"
        
        println(outputFile)
        println("Output file name: ")
        FileName = input()
        outputFile.writeToFile("/Users/cyrix/Desktop/" + FileName + ".csv", atomically:true)

        println("Exit?")
        terminate = input()
    } while terminate == "n"
}