// MiningFacebook for command line tool

import Foundation

println("Select: 1.OpenTake 2.AccessToken")
var select = input()

switch select {
case "1":
    OpenTake()
case "2":
    AccessToken()
default:
    println("Nothing!")
}