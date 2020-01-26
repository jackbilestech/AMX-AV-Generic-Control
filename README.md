# AMX AV Generic Control
 
# How It Works

## TP_Event_Listeners.AXI

This file is intended to be included and to operate with `./Interface/AV Generic Control.tpX`. Using any other `.tp5` or `.tp4` file will create undesired effects on the processor code and will not work as intended.

- This file conatins a collection of constants that relate to every button on the `Touch Panel File` and invokes functions depedant on the event called from the TP.

- The supplied `.tpX` files have no restrictions to design, go crazy! 

- It is to note that the only things that *CANNOT* change are the programming Ports. Avoid changing these values unless you intende to do something completly diffrent with the widget.

- *ALL COMPILER DIRECTIVE(S) MUST BE GIVEN BEFORE `#INLUCDE 'TP_Event_Listeners.axi'`*

- As of current there is no implemntation to breakup Default Feedback from indivudal components. It's either all or nothing.

- The maximum allowed numebr of panels is    set to `10`, this is the absolute maximum allowed for this design. Allocating anymore panels to the system will cause the entire system to lag and slow down, afecting UX.

# How To Get Started

The below snippet must be included in the `mainline`. 

Asssign your panel(s) `D:P:S` to this include file altering the values in `dvTP`. The first `DEV` in this array will be panel `TouchPaenl[1]`, the second panel `TouchPanel[2]` and so forth. The include will not compile without the `dvTP` dveice array or the `fnTouchPanelInit` function declaration.

```c#
DEFINE_CONSTANT
DEV dvTP[] = {
    10001:1:0,
    10002:1:0,
    10003:1:0,
    10004:1:0
}
```
This function is called once the program starts using `DEFINE_START`.
```c#
DEFINE_FUNCTION fnTouchPanelInit(){
    //Apply Config to Panels
    TouchPanel[1].MicMuteOption = FALSE
}

```

In here is where you can assign your config per panel using the variable `TouchPanel`. Each panel is treated as an index in an array defined by the `dvTP` constant. for `TouchPanel` config, see (Touch Panel Config)[#Config]

# Config
```c#
STRUCT uTP{
	DEV Device
	INTEGER MicMuteOption // Enables / Disables the Mic Mute Widget. Widget is hidden when disbaled
	INTEGER MasterVolumeOption // Enables / Disables the Master Volume Slider Widget. Widget is hidden when disbaled
	INTEGER SystemShutDownOption // Enables / Disables the System Shut Down Widget. Widget is hidden when disbaled
	INTEGER MenuOption // Enables / Disables the Mic Mute Widget. Widget is hidden when disbaled
	INTEGER Video // Not Implemented yet
	CHAR RoomName[50] // Room Name to be displayed on screen
}
```


# List of Event Handlers / Alerts

## Default Feedback
```c#
#DEFINE TOUCH_PANEL_DEFAULT_FEEDBACK
```

This compiler directive will force the buttons to act as default, i.e Buttons will flash on and off, Bargraphs will increment min - max in their default colours as created in the `.tpX` file.

If you wish to override the feedback, simply add the commands into the `Event Listener` functions called to alter their feedback and remove the compiler directive.

## fnPanelOnline

An event listener invoked when a panel is detected to be Online. The panels `DEV` is presented as an argument.

```c#
#DEFINE TOUCH_PANEL_ONLINE_EVENT

DEFINE_FUNCTION fnPanelOnline(DEV panel){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is now ONLINE'"
}
```

## fnPanelOffline

An event listener invoked when a panel is detected to be Offilne. The panel `DEV` is presented as an argument.

```c#
#DEFINE TOUCH_PANEL_OFFLINE_EVENT

DEFINE_FUNCTION fnPanelOnline(DEV panel){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is now OFFLINE'"
}
```

## fnTouchToStart

An event listener invoked when this particular button is pushed. The panel `DEV` is presented as an argument and the Button as a `DEVCHAN`.

`note: This page is intended to the be the landing page to avoid screen burn and to allow for the panel UI to be chnaged in the back-end utilised for UX.`

```c#
#DEFINE TOUCH_PANEL_TOUCH_TO_START_EVENT

DEFINE_FUNCTION fnTouchToStart(DEV panel, DEVCHAN button){
	SEND_COMMAND panel, 'PAGE-Control'
}
```

## fnSystemShutDown

An event listener invoked when this particular button is pushed. The panel `DEV` is presented as an argument and the Button as a `DEVCHAN`.

```c#
#DEFINE TOUCH_PANEL_SYSTEM_SHUT_DOWN_EVENT

DEFINE_FUNCTION fnSystemShutdown(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is requesting SHUTDOWN'"
}
```

## fnMicMute

An event listener invoked when this particular button is pushed. The panel `DEV` is presented as an argument and the Button as a `DEVCHAN`.

```c#
#DEFINE TOUCH_PANEL_MIC_MUTE_EVENT

DEFINE_FUNCTION fnMicMute(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} is requesting MICMUTE'"
}
```

## fnMasterVolume

An event listener invoked when this particular button is pushed. The panel `DEV` is presented as an argument and the value as an `INTEGER`.

```c#
#DEFINE TOUCH_PANEL_MASTER_VOLUME_EVENT

DEFINE_FUNCTION fnMasterVolume(DEV panel, INTEGER value){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested MasterVolume of : ', value"
}
```
## fnMenuSelect
```c#
#DEFINE TOUCH_PANEL_MENU_SELECT_EVENT

DEFINE_FUNCTION fnMenuSelect(DEV panel, DEVCHAN button){
	SEND_STRING 0, "'Panel {',panel.NUMBER,'} requested MenudSelect of Channel: ', ITOA(button.input.channel)"
}
```