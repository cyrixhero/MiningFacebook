import Foundation

func MiningPost() {
    println("AccessToken: ")
    var AccessToken = input()

    var FacebookUID: Int
    var outputFile: NSMutableString = ""
    var nextFlag: NSArray
    var terminate: String

    do {
        println("{Post-ID}: ")
        var PostID = input()
        var AccessType = get_urlPath(PostID, AccessToken)
        var urlPath_Likes = AccessType.urlPath_Likes
        var urlPath_SharedPosts = AccessType.urlPath_SharedPosts

        do {
            var AnalyticsData = AnalyticsJSON_Likes(urlPath_Likes)
            outputFile.appendFormat(AnalyticsData.storeUID_Likes)
            FacebookUID = AnalyticsData.FacebookUID_Flag
    
            if FacebookUID < 1000 {
                break
            }else {
                nextFlag = AnalyticsData.nextFlag
                urlPath_Likes = AnalyticsData.NextURLPath_Likes
            }
        } while nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next"

        do {
            var AnalyticsData = AnalyticsJSON_SharedPosts(urlPath_SharedPosts)
            outputFile.appendFormat(AnalyticsData.storeUID_SharedPosts)
            FacebookUID = AnalyticsData.FacebookUID_Flag
            
            if FacebookUID < 1000 {
                break
            }else {
                nextFlag = AnalyticsData.nextFlag
                urlPath_SharedPosts = AnalyticsData.NextURLPath_SharedPosts
            }
        } while nextFlag[1] as NSString == "next" || nextFlag[2] as NSString == "next"
        
        println("Exit?")
        terminate = input()
    } while terminate == "n"

    SaveToFile(outputFile)
}