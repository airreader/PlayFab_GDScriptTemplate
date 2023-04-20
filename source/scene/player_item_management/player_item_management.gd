extends Control


func reset_ui():
    $VBoxContainer/lbl_json_parse_result/value.text = ""


func _on_PlayFab_response(h_request: int, response_code: int, headers, json_parse_result: Variant):
#    if json_parse_result.error == OK:
    $VBoxContainer/lbl_json_parse_result/value.text = var_to_str(json_parse_result)


func _ready():
    pass


func _on_btn_get_user_inventory_pressed():

    var dict_request = {}
    
    reset_ui()
    PlayFab.Client.GetUserInventory(
        dict_request,
        Callable(self, "_on_PlayFab_response")
    )
