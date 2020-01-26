PROGRAM_NAME='dev'

// Register Event Listeners
#DEFINE TOUCH_PANEL_OFFLINE_EVENT
#DEFINE TOUCH_PANEL_ONLINE_EVENT
#DEFINE TOUCH_PANEL_TOUCH_TO_START_EVENT
#DEFINE TOUCH_PANEL_SYSTEM_SHUT_DOWN_EVENT
#DEFINE TOUCH_PANEL_MIC_MUTE_EVENT
#DEFINE TOUCH_PANEL_MASTER_VOLUME_EVENT
#DEFINE TOUCH_PANEL_MENU_SELECT_EVENT
#DEFINE TOUCH_PANEL_DEFAULT_FEEDBACK


DEFINE_CONSTANT
DEV dvTP[] = {
10001:1:0,
10002:1:0,
10003:1:0,
10004:1:0
}

#INCLUDE 'TP_Event_Listeners'



DEFINE_VARIABLE
isOnline = FALSE

DEFINE_FUNCTION fnTouchPanelInit(){
TouchPanel[1].MicMuteOption = TRUE
TouchPanel[1].SystemShutDownOption = TRUE
TouchPanel[1].MasterVolumeOption = TRUE
TouchPanel[1].MenuOption = TRUE
TouchPanel[1].RoomName = 'A Demo Room'
}

DEFINE_FUNCTION fnPanelOffline(DEV panel){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is now OFFLINE mainline'"
	isOnline = FALSE
}

DEFINE_FUNCTION fnPanelOnline(DEV panel){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is now ONLINE mainline'"
	isOnline = TRUE
}

DEFINE_FUNCTION fnTouchToStart(DEV panel, DEVCHAN button){
	SEND_COMMAND panel, 'PAGE-Control'
}


DEFINE_FUNCTION fnSystemShutdown(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is requesting SHUTDOWN'"
	SEND_COMMAND panel, 'PAGE-TouchToStart'
}

DEFINE_FUNCTION fnMicMute(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is requesting MICMUTE'"
}

DEFINE_FUNCTION fnMasterVolume(DEV panel, INTEGER value){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested MasterVolume of : ', ITOA(value)"
}

DEFINE_FUNCTION fnMenuSelect(DEV panel, DEVCHAN button){

	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested MenudSelect of CHAN: ', ITOA(button.channel)"
}