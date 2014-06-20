import Foundation

func AccessToken() {
//    println("AccessToken: ")
    var AccessToken = "AccessToken"

//    println("{Post-ID}: ")
    var PostID = "PostID"

    var FileName: String
    var urlPath = "https://graph.facebook.com/" + PostID + "/sharedposts?limit=1000&access_token=" + AccessToken
    var outputFile: NSMutableString = ""
    var url: NSURL
    var request: NSURLRequest
    var response: NSData
    var JSONData: NSDictionary
    var FacebookUID: NSArray
    var getNextFlag: NSDictionary
    var nextFlag: NSArray
    
    do {
        url = NSURL(string: urlPath)
        request = NSURLRequest(URL: url)
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
                urlPath = JSONData["paging"].valueForKey("next").stringByStandardizingPath
            }
        }
    } while nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next"
    
    println(outputFile)
    println("Output file name: ")
    FileName = input()
    outputFile.writeToFile("/Users/cyrix/Desktop/" + FileName + ".csv", atomically:true)
}