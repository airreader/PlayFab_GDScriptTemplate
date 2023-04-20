extends Control


const TESTFILENAME = "TESTFILE.TXT"
const TESTFILEDATA = "0123456789ABDEF"


func reset_ui():
    $BoxContainer/lbl_json_parse_result/value.text = ""


func _ready():
    $HTTPRequest.request_completed.connect(Callable(self, "_on_request_completed"))


func _on_PlayFab_response(h_request: int, response_code: int, headers, json_parse_result: Variant):
#    if json_parse_result.error == OK:
    $BoxContainer/lbl_json_parse_result/value.text = var_to_str(json_parse_result)


func _on_request_completed(result: int, response_code: int, list_header: PackedStringArray, body: PackedByteArray):
    print(result)
    if PlayFabSettings._internalSettings.EntityToken == null: return

    var ETag = ""
    var dict_request = {
        "Entity": {
            "Id": PlayFabSettings._internalSettings.EntityToken["Entity"]["Id"],
            "Type": "title_player_account"
        },
        "Filenames": [
            TESTFILENAME
        ]
    }

    for header in list_header:
        var kv_pair = header.split(":")
        if kv_pair[0] == "ETag":
            ETag = kv_pair[1].strip_edges().to_lower().replace("\"", "")
            break

    if response_code == 200 and ETag == TESTFILEDATA.md5_text().to_lower():
        PlayFab.Data.FinalizeFileUploads(
            dict_request,
            Callable(self, "_on_PlayFab_response")
        )
    else:
        PlayFab.Data.AbortFileUploads(
            dict_request,
            Callable(self, "_on_PlayFab_response")
        )


func _on_PlayFab_initiate_file_uploads(h_request: int, response_code: int, headers, json_parse_result: Variant):
#    if json_parse_result.error == OK:
    $BoxContainer/lbl_json_parse_result/value.text = var_to_str(json_parse_result)

    if json_parse_result["code"] == 200:
        var dict_response = json_parse_result["data"]
        
        for metadata in dict_response["UploadDetails"]:
            var filename = metadata["FileName"]
            var url = metadata["UploadUrl"]

            $HTTPRequest.request(
                url,
                [],
                true,
                HTTPClient.METHOD_PUT,
                TESTFILEDATA
            )


func _on_btn_abort_file_uploads_pressed():

    if PlayFabSettings._internalSettings.EntityToken == null: return

    var dict_request = {
        "Entity": {
            "Id": PlayFabSettings._internalSettings.EntityToken["Entity"]["Id"],
            "Type": "title_player_account"
        },
        "Filenames": [
            TESTFILENAME
        ]
    }
    
    reset_ui()
    PlayFab.Data.AbortFileUploads(
        dict_request,
        Callable(self, "_on_PlayFab_response")
    )


func _on_btn_delete_files_pressed():

    if PlayFabSettings._internalSettings.EntityToken == null: return

    var dict_request = {
        "Entity": {
            "Id": PlayFabSettings._internalSettings.EntityToken["Entity"]["Id"],
            "Type": "title_player_account"
        },
        "Filenames": [
            TESTFILENAME
        ]
    }
    
    reset_ui()
    PlayFab.Data.DeleteFiles(
        dict_request,
        Callable(self, "_on_PlayFab_response")
    )


func _on_btn_finalize_file_uploads_pressed():

    if PlayFabSettings._internalSettings.EntityToken == null: return

    var dict_request = {
        "Entity": {
            "Id": PlayFabSettings._internalSettings.EntityToken["Entity"]["Id"],
            "Type": "title_player_account"
        },
        "Filenames": [
            TESTFILENAME
        ]
    }
    
    reset_ui()
    PlayFab.Data.FinalizeFileUploads(
        dict_request,
        Callable(self, "_on_PlayFab_response")
    )


func _on_btn_get_files_pressed():

    if PlayFabSettings._internalSettings.EntityToken == null: return

    var dict_request = {
        "Entity": {
            "Id": PlayFabSettings._internalSettings.EntityToken["Entity"]["Id"],
            "Type": "title_player_account"
        }
    }
    
    reset_ui()
    PlayFab.Data.GetFiles(
        dict_request,
        Callable(self, "_on_PlayFab_response")
    )


func _on_btn_initiate_file_uploads_pressed():

    if PlayFabSettings._internalSettings.EntityToken == null: return

    var dict_request = {
        "Entity": {
            "Id": PlayFabSettings._internalSettings.EntityToken["Entity"]["Id"],
            "Type": "title_player_account"
        },
        "Filenames": [
            TESTFILENAME
        ]
    }
    
    reset_ui()
    PlayFab.Data.InitiateFileUploads(
        dict_request,
        Callable(self, "_on_PlayFab_response")
    )


func _on_btn_file_upload_test_pressed():

    if PlayFabSettings._internalSettings.EntityToken == null: return

    var dict_request = {
        "Entity": {
            "Id": PlayFabSettings._internalSettings.EntityToken["Entity"]["Id"],
            "Type": "title_player_account"
        },
        "Filenames": [
            TESTFILENAME
        ]
    }
    
    reset_ui()
    PlayFab.Data.InitiateFileUploads(
        dict_request,
        Callable(self, "_on_PlayFab_initiate_file_uploads")
    )

