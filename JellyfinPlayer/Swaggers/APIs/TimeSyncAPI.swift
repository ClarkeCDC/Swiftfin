//
// TimeSyncAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class TimeSyncAPI {
    /**
     Gets the current UTC time.

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUtcTime(completion: @escaping ((_ data: UtcTimeResponse?,_ error: Error?) -> Void)) {
        getUtcTimeWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Gets the current UTC time.
     - GET /GetUtcTime
     - 

     - examples: [{contentType=application/json, example={
  "ResponseTransmissionTime" : "2000-01-23T04:56:07.000+00:00",
  "RequestReceptionTime" : "2000-01-23T04:56:07.000+00:00"
}}]

     - returns: RequestBuilder<UtcTimeResponse> 
     */
    open class func getUtcTimeWithRequestBuilder() -> RequestBuilder<UtcTimeResponse> {
        let path = "/GetUtcTime"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<UtcTimeResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}