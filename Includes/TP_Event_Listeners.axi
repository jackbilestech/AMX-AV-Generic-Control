PROGRAM_NAME='TP_Event_Listeners'

DEFINE_CONSTANT
REFRESH_RATE = 100 //ms

DEFINE_TYPE
STRUCT uTP{
	DEV Device
	INTEGER MicMuteOption
	INTEGER MasterVolumeOption
	INTEGER SystemShutDownOption
	INTEGER MenuOption
	INTEGER Video
	CHAR RoomName[50]
}

DEFINE_VARIABLE
uTP TouchPanel[10]

DEFINE_CONSTANT
TouchToStart = 100
SystemShutDown = 101
OfflinePrompt = 102
RoomLabel = 105
MasterVolume = 200
MicMute = 201

menuOption1  = 106
menuOption2 = 107
menuOption3 = 108
menuOption4 = 109
menuOption5 = 109

menuOptions[] = {menuOption1,menuOption2,menuOption3,menuOption4,menuOption5}

#IF_DEFINED TOUCH_PANEL_DEFAULT_FEEDBACK
DEFINE_CONSTANT
touchPanelFB = TRUE
#ELSE
DEFINE_CONSTANT
touchPanelFB = FALSE
#END_IF

#IF_NOT_DEFINED TOUCH_PANEL_OFFLINE_EVENT
DEFINE_FUNCTION fnPanelOffline(DEV panel){
	SEND_STRING 0,("'Panel {',panel.NUMBER,'} is now OFFLINE'")
}
#END_IF

#IF_NOT_DEFINED TOUCH_PANEL_ONLINE_EVENT
DEFINE_FUNCTION fnPanelOnline(DEV panel){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is now ONLINE'"
	
}
#END_IF

DEFINE_EVENT DATA_EVENT [dvTP] { // Track which panel(s) is online

	ONLINE:{
		STACK_VAR i
		FOR(i = 1; i < LENGTH_ARRAY(dvTP); i++){
			IF(DATA.DEVICE.NUMBER == dvTP[i].NUMBER){
				//Match Found
				ON[dvTp[i],OfflinePrompt]
				fnPanelOnline(dvTP[i])
			}
		}
	}
	OFFLINE:{
		STACK_VAR i
		FOR(i = 1; i < LENGTH_ARRAY(dvTP); i++){
			IF(DATA.DEVICE.NUMBER == dvTP[i].NUMBER){
				//Match Found
				fnPanelOffline(dvTP[i])
			}
		}
	}
}



#IF_NOT_DEFINED TOUCH_PANEL_TOUCH_TO_START_EVENT
DEFINE_FUNCTION fnTouchToStart(DEV panel, DEVCHAN button) {
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested TouchToStart '"
}
#END_IF

DEFINE_EVENT BUTTON_EVENT [dvTP,TouchToStart]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
	STACK_VAR INTEGER i
		IF(touchPanelFB){
			OFF[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
		fnTouchToStart(BUTTON.INPUT.DEVICE, BUTTON.INPUT)
	}
}


#IF_NOT_DEFINED TOUCH_PANEL_SYSTEM_SHUT_DOWN_EVENT
DEFINE_FUNCTION fnSystemShutdown(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested SystemShutDown '"
}
#END_IF

DEFINE_EVENT BUTTON_EVENT [dvTP,SystemShutDown]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
		IF(touchPanelFB){
			OFF[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
		fnSystemShutdown(BUTTON.INPUT.DEVICE, BUTTON.INPUT)
	}
}




#IF_NOT_DEFINED TOUCH_PANEL_MIC_MUTE_EVENT
DEFINE_FUNCTION fnMicMute(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested MicMute '"
}
#END_IF

DEFINE_EVENT BUTTON_EVENT [dvTP,MicMute]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
		IF(touchPanelFB){
		SEND_STRING 0,"BUTTON.INPUT.DEVICE"
			OFF[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
		fnMicMute(BUTTON.INPUT.DEVICE, BUTTON.INPUT)
	}
}




#IF_NOT_DEFINED TOUCH_PANEL_MASTER_VOLUME_EVENT
DEFINE_FUNCTION fnMasterVolume(DEV panel, INTEGER value){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested MasterVolume of : ', value"
}
#END_IF


DEFINE_EVENT LEVEL_EVENT [dvTP, MasterVolume]{
	IF(touchPanelFB){
		SEND_LEVEL LEVEL.INPUT.DEVICE,LEVEL.INPUT.LEVEL,LEVEL.VALUE
		fnMasterVolume(LEVEL.INPUT.DEVICE,LEVEL.VALUE)
	}
}



#IF_NOT_DEFINED TOUCH_PANEL_MENU_SELECT_EVENT
DEFINE_FUNCTION fnMenuSelect(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested MenudSelect of Channel: ', ITOA(button.channel)"
}
#END_IF

DEFINE_EVENT BUTTON_EVENT [dvTP,menuOption1]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
	STACK_VAR i
		IF(touchPanelFB){
			FOR(i = 1; i < LENGTH_ARRAY(menuOptions); i++){
				IF(BUTTON.INPUT.CHANNEL == menuOptions[i]){
					//Match found
					ON[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
				ELSE{
					OFF[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
			}
		}
		fnMenuSelect(BUTTON.INPUT.DEVICE,BUTTON.INPUT)
		
	}
}

DEFINE_EVENT BUTTON_EVENT [dvTP,menuOption2]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
	STACK_VAR i
		IF(touchPanelFB){
		SEND_STRING 0 , '2222'
			FOR(i = 1; i < LENGTH_ARRAY(menuOptions); i++){
				IF(BUTTON.INPUT.CHANNEL == menuOptions[i]){
					//Match found
					ON[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
				ELSE{
					OFF[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
			}
		}
		fnMenuSelect(BUTTON.INPUT.DEVICE,BUTTON.INPUT)
		
	}
}

DEFINE_EVENT BUTTON_EVENT [dvTP,menuOption3]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
	STACK_VAR i
		IF(touchPanelFB){
		SEND_STRING 0 , '2222'
			FOR(i = 1; i < LENGTH_ARRAY(menuOptions); i++){
				IF(BUTTON.INPUT.CHANNEL == menuOptions[i]){
					//Match found
					ON[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
				ELSE{
					OFF[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
			}
		}
		fnMenuSelect(BUTTON.INPUT.DEVICE,BUTTON.INPUT)
	}
}

DEFINE_EVENT BUTTON_EVENT [dvTP,menuOption4]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
	STACK_VAR i
		IF(touchPanelFB){
		SEND_STRING 0 , '2222'
			FOR(i = 1; i < LENGTH_ARRAY(menuOptions); i++){
				IF(BUTTON.INPUT.CHANNEL == menuOptions[i]){
					//Match found
					ON[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
				ELSE{
					OFF[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
			}
		}
		fnMenuSelect(BUTTON.INPUT.DEVICE,BUTTON.INPUT)
	}
}

DEFINE_EVENT BUTTON_EVENT [dvTP,menuOption5]{
	PUSH:{
		IF(touchPanelFB){
			ON[BUTTON.INPUT.DEVICE,BUTTON.INPUT.CHANNEL]
		}
	}
	RELEASE:{
	STACK_VAR i
		IF(touchPanelFB){
		SEND_STRING 0 , '2222'
			FOR(i = 1; i < LENGTH_ARRAY(menuOptions); i++){
				IF(BUTTON.INPUT.CHANNEL == menuOptions[i]){
					//Match found
					ON[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
				ELSE{
					OFF[BUTTON.INPUT.DEVICE,menuOptions[i]]
				}
			}
		}
		fnMenuSelect(BUTTON.INPUT.DEVICE,BUTTON.INPUT)
	}
}




DEFINE_CONSTANT
UI_THREAD = 983
LONG refreshRate[1] = {REFRESH_RATE}
LONG len = 1

DEFINE_EVENT TIMELINE_EVENT[UI_THREAD]

{
	STACK_VAR INTEGER i
	switch(Timeline.Sequence)

	{
	CASE 1:
		FOR(i = 1; i < LENGTH_ARRAY(TouchPanel); i++){
			SEND_COMMAND TouchPanel[i].Device, "'^SHO-',ITOA(MicMute),',',ITOA(TouchPanel[i].MicMuteOption)"
			SEND_COMMAND TouchPanel[i].Device, "'^SHO-',ITOA(SystemShutDown),',',ITOA(TouchPanel[i].SystemShutDownOption)"
			SEND_COMMAND TouchPanel[i].Device, "'^SHO-',ITOA(MasterVolume),',',ITOA(TouchPanel[i].MasterVolumeOption)"
			SEND_COMMAND TouchPanel[i].Device, "'^TXT-',ITOA(RoomLabel),',0,',TouchPanel[i].RoomName"
			SEND_COMMAND TouchPanel[i].Device, "'^SHO-',ITOA(menuOptions[1]),'.',ITOA(menuOptions[LENGTH_ARRAY(menuOptions)]),',',ITOA(TouchPanel[i].MenuOption)"
		}
	}

}

DEFINE_FUNCTION __TP__INIT(){

	STACK_VAR INTEGER i
	
	FOR(i = 1; i < LENGTH_ARRAY(dvTP); i++){
		TouchPanel[i].Device = dvTP[i]
	}
	
	SET_LENGTH_ARRAY(TouchPanel,i)
}

DEFINE_START
__TP__INIT() // Populate TouchPanel Array
fnTouchPanelInit() // Exprose Start to Mainline
TIMELINE_CREATE(UI_THREAD, refreshRate, 1, TIMELINE_ABSOLUTE,TIMELINE_REPEAT) // Begin UI Refresh






