import Foundation

func MiningPost() {
    println("AccessToken: ")
    var AccessToken = input()

    var JSONData: NSDictionary
    var FacebookUID: NSArray
    var outputFile: NSMutableString = ""
    var getNextFlag: NSDictionary
    var nextFlag: NSArray
    var FileName: String
    var terminate: String

    do {
        println("{Post-ID}: ")
        var PostID = input()
        var AccessType = get_urlPath(PostID, AccessToken)
        var urlPath_Likes = AccessType.urlPath_Likes
        var urlPath_SharedPosts = AccessType.urlPath_SharedPosts

        do {
            JSONData = AnalyticsJSON_Likes(urlPath_Likes)
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
            JSONData = AnalyticsJSON_SharedPosts(urlPath_SharedPosts)
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
        
        println("Exit?")
        terminate = input()
    } while terminate == "n"

    println(outputFile)
    println("Output file name: ")
    FileName = input()
    outputFile.writeToFile("/Users/cyrix/Desktop/" + FileName + ".csv", atomically:true)
}