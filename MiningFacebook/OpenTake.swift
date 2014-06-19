import Foundation

func OpenTake() {
    println("{Post-ID}: ")
    
    var PostID = input()
    var FileName: String
    var urlPath = "https://graph.facebook.com/" + PostID + "/likes?limit=1000"
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
                urlPath = JSONData["paging"].valueForKey("next").stringByStandardizingPath
            }
        }
    } while nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next"
    
    println(outputFile)
    println("Output file name: ")
    FileName = input()
    outputFile.writeToFile("/Users/cyrix/Desktop/" + FileName + ".csv", atomically:true)
}