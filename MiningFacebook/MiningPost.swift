import Foundation

func MiningPost() {
    println("AccessToken: ")
    var AccessToken = input()

    var FacebookUID: Int
    var outputFile: NSMutableString = ""
    var nextFlag: NSArray
    var terminate: String
    
    println("\nWhich mode do you want?")
    println("1.Likes, CommentLike")
    println("2.Shared")
    println("3.LikeShared")
    var mode = input()
    
    switch mode {
    case "1":
        do {
            println("{Post-ID}: ")
            var PostID = input()
            var AccessType = get_urlPath(PostID, AccessToken)
            var urlPath_Likes = AccessType.urlPath_Likes
            
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
            
            println("Exit? (You are in Likes mode now)")
            terminate = input()
        } while terminate == "n"
    case "2":
        do {
            println("{Post-ID}: ")
            var PostID = input()
            var AccessType = get_urlPath(PostID, AccessToken)
            var urlPath_SharedPosts = AccessType.urlPath_SharedPosts
            
            do {
                var AnalyticsData = AnalyticsJSON_SharedPosts(urlPath_SharedPosts)
                outputFile.appendFormat(AnalyticsData.storeUID_SharedPosts)
                FacebookUID = AnalyticsData.FacebookUID_Flag
                nextFlag = AnalyticsData.nextFlag

                if nextFlag.count == 1 {
                    break
                }else {
                    urlPath_SharedPosts = AnalyticsData.NextURLPath_SharedPosts
                }
            } while nextFlag[0] as NSString == "cursors" && nextFlag[1] as NSString == "next" || nextFlag.count == 3
            
            println("Exit? (You are in Shared mode now)")
            terminate = input()
        } while terminate == "n"
    case "3":
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
                nextFlag = AnalyticsData.nextFlag
                
                if nextFlag.count == 1 {
                    break
                }else {
                    urlPath_SharedPosts = AnalyticsData.NextURLPath_SharedPosts
                }
            } while nextFlag[0] as NSString == "cursors" && nextFlag[1] as NSString == "next" || nextFlag.count == 3
            
            println("Exit? (You are in LikeShared mode now)")
            terminate = input()
        } while terminate == "n"
    default:
        break
    }
    SaveToFile(outputFile)
}