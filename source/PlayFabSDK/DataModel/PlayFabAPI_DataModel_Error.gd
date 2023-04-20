extends Object
# class_name PFErrorDataModels


class PFApiErrorWrapper:
    var code: int
    var status: String
    var error: String
    var errorCode: int
    var errorMessage: String
    var errorDetail: Dictionary

    func _init(_dict_param: Dictionary = {}):
        
        self.errorDetail = {}
        self.set_dict(_dict_param);

    func set_dict(_dict_param: Dictionary):
        
        if "code" in _dict_param:
            self.code = _dict_param["code"]
        if "status" in _dict_param:
            self.status = _dict_param["status"]
        if "error" in _dict_param:
            self.error = _dict_param["error"]
        if "errorCode" in _dict_param:
            self.errorCode = _dict_param["errorCode"]
        if "errorMessage" in _dict_param:
            self.errorMessage = _dict_param["errorMessage"]
        if "errorDetail" in _dict_param:
            self.errorDetail = _dict_param["errorDetail"]

    func get_dict() -> Dictionary:
        
        var dict_result: Dictionary = {}
        
        if self.code != null:
            dict_result["code"] = self.code
        if self.status != null:
            if self.status.is_empty() != true:
                dict_result["status"] = self.status
        if self.error != null:
            if self.error.is_empty() != true:
                dict_result["error"] = self.error
        if self.errorCode != null:
            dict_result["errorCode"] = self.errorCode
        if self.errorMessage != null:
            if self.errorMessage.is_empty() != true:
                dict_result["errorMessage"] = self.errorMessage
        if self.errorDetail != null:
            dict_result["errorDetail"] = self.errorDetail
        
        return dict_result
