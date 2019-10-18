-- ***************************************************************************
-- **         WIDGET RDT FOR JETCAT ECU WITH FRSKY SPORT               	  	**
-- **                       by Thierry 					  					**
-- **									  									**
-- ** Tankcap = Capacity of the tank (ml)				  					**
-- ***************************************************************************

local options = {
  	{"LowLvl", VALUE, 1000, 100, 5000 },
  	{"Color", COLOR, BLACK },
--	{"Shadow", COLOR, BLACK },
  	}

-- There are the sensors detected by the Horus from the RDT module
-- Check them after detected if the name are the same as below

local rpm    = "RPM"
local egt    = "Tmp1"
local fuel   = "Fuel"
local status = "Tmp2"
local batecu = "A3"
local pump = "A4"
-- local thr   = "----"
local rssi = "RSSI"
local batrx = "RxBt"
local name  = "RDT Jetcat"

-- Path to pictures on SD-CARD
local imagePath = "/WIDGETS/RDT_Jetcat/img/"

-- Path for language sounds on SD-CARD
local lang = "en"

local function create(zone, options)
	local thisWidget = { zone=zone, options=options, param={} }
-- Define how many times the alarm Low Level will be annouced
    	thisWidget.param.counter = 3
    thisWidget.param.alarm = thisWidget.options.LowLvl
	return thisWidget
end

local function update(thisWidget, options)
  	thisWidget.options = options
  	thisWidget.param.alarm = thisWidget.options.LowLvl
end

local msg_table = {
	[0] = "OFF",
	[1] = "Wait for RPM",
	[2] = "Ignition",
	[3] = "Accelerate",
	[4] = "Stabilize",
	[5] = "Learn High!",
	[6] = "Learn Low",
	[7] = "-----",
	[8] = "Slow Down",
	[9] = "Not Used",
	[10] = "Auto Off",
	[11] = "Running",
	[12] = "Accel Delay",
	[13] = "Speed Reg",
	[14] = "2 Shaft Reg",
	[15] = "Preheat 1",
	[16] = "Preheat 2",
	[17] = "Main FStrt",
	[18] = "Not Used",
	[19] = "Kero Full",
   }

local function draw_status(x,y,src)
  local status = getValue(src)
  local status_str = msg_table[status] 
  lcd.drawText(x+5,y+3,status_str,DBLSIZE+CUSTOM_COLOR)
end

local Img_rssi = Bitmap.open(imagePath.."rssi.png")
local function draw_rssi(x,y,src)
	local rssi = getValue(src)
	lcd.drawBitmap(Img_rssi,x,y+7,100)
	lcd.drawText(x+31,y+15,"RSSI",SMLSIZE+CUSTOM_COLOR)
	lcd.drawNumber(x+100,y+10,rssi,RIGHT+MIDSIZE+CUSTOM_COLOR)
	lcd.drawText(x+100,y+20,"db",SMLSIZE+CUSTOM_COLOR)
end

local Img_rpm = Bitmap.open(imagePath.."rpm.png")
local function draw_rpm(x,y,src)
  local rpm = getValue(src)*100
  lcd.drawBitmap(Img_rpm,x+1,y+1,100)
  lcd.drawText(x+40,y+5,"Rpm",0+CUSTOM_COLOR)
  lcd.drawNumber(x+98,y+45,rpm,RIGHT+MIDSIZE+CUSTOM_COLOR)
end

local Img_egt = Bitmap.open(imagePath.."tmp.png")
local function draw_egt(x,y,src)
  local egt = getValue(src)
  lcd.drawBitmap(Img_egt,x,y+1,100)
  lcd.drawText(x+32,y+5,"Egt",0+CUSTOM_COLOR)
  lcd.drawNumber(x+60,y+45,egt,RIGHT+MIDSIZE+CUSTOM_COLOR)
  lcd.drawText(x+59,y+54,"C",SMLSIZE+CUSTOM_COLOR)
end

--local Img_spd = Bitmap.open(imagePath.."speed.bmp")
--local function draw_thr(x,y,src)
-- local thr = getValue(src)
--  lcd.drawBitmap(Img_spd,x+7,y+10,70)
--  lcd.drawText(x+31,y+15,"Thro",SMLSIZE+CUSTOM_COLOR)
--  lcd.drawNumber(x+110,y+10,thr,RIGHT+MIDSIZE+CUSTOM_COLOR)
--  lcd.drawText(x+110,y+20,"%",SMLSIZE+CUSTOM_COLOR)
--end

local Img_bat = Bitmap.open(imagePath.."batt.png")
local function draw_batecu(x,y,src)
 	local ecu_v = getValue(src)*10
 	lcd.drawBitmap(Img_bat,x,y+5,100)
	lcd.drawText(x+25,y+15,"Ecu",SMLSIZE+CUSTOM_COLOR)
 	lcd.drawNumber(x+110,y+4,ecu_v,RIGHT+PREC1+DBLSIZE+CUSTOM_COLOR)
 	lcd.drawText(x+110,y+18,"v",0+CUSTOM_COLOR)
end

local Img_bat = Bitmap.open(imagePath.."batt.png")
local function draw_batrx(x,y,src)
 	local rx_v = getValue(src)*10
 	lcd.drawBitmap(Img_bat,x,y+5,100)
  	lcd.drawText(x+25,y+15,"Rx",SMLSIZE+CUSTOM_COLOR)
 	lcd.drawNumber(x+100,y+4,rx_v,RIGHT+PREC1+DBLSIZE+CUSTOM_COLOR)
 	lcd.drawText(x+100,y+18,"v",0+CUSTOM_COLOR)
end

local Img_pump = Bitmap.open(imagePath.."pump.png")
local function draw_pump(x,y,src)
 	local pump = getValue(src)*100
	lcd.drawBitmap(Img_pump,x,y,50)
 	lcd.drawText(x+20,y+5,"Pump",0+CUSTOM_COLOR)
 	lcd.drawNumber(x+60,y+45,pump,RIGHT+PREC2+MIDSIZE+CUSTOM_COLOR)
end

local Img_jmun = Bitmap.open(imagePath.."jetcat.png")
local function draw_name(x,y,src)
	lcd.drawBitmap(Img_jmun,x+3,y+13,100)
 	lcd.drawText(x+60,y+10,src,MIDSIZE+CUSTOM_COLOR)
end

local Img_tnk = Bitmap.open(imagePath.."gasoline.png")
local function draw_tank(x,y,src,alarm)
	lcd.drawBitmap(Img_tnk,x+2,y,100)
	local fuel = getValue(src)
	lcd.drawNumber(x+200,y+25,fuel,RIGHT+XXLSIZE+CUSTOM_COLOR)
 	lcd.drawText(x+200,y+70,"ml",0+CUSTOM_COLOR)
	lcd.drawText(x+90,y+110,"LowLvl:",SMLSIZE+CUSTOM_COLOR)
	lcd.drawText(x+150,y+110,alarm.."ml",SMLSIZE+CUSTOM_COLOR)

end

local Img_chr = Bitmap.open(imagePath.."chrono.png")
local function draw_timer(x,y)
	local timer = model.getTimer(0)
	lcd.drawBitmap(Img_chr,x,y,100)
	lcd.drawTimer(x+30,y+25,timer.value, XXLSIZE+CUSTOM_COLOR)
end

local function level_chk(src1,src2,param)
	local status = getValue(src1)
	local fuel = getValue(src2)
	if fuel < param.alarm and param.counter > 0 and status == 11 then
		playFile("/SOUNDS/"..lang.."/fuelvl.wav")
		param.counter = param.counter - 1	
	end
end


local function buildgrid()
	lcd.drawRectangle(0,0,241,45,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(241,0,120,45,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(359,0,121,45,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(241,45,120,45,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(359,45,121,45,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(241,90,239,45,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(0,45,70,90,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(70,45,100,90,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(170,45,71,90,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(0,135,241,137,SOLID+CUSTOM_COLOR)
	lcd.drawRectangle(241,135,239,137,SOLID+CUSTOM_COLOR)
--	lcd.drawLine(240,0,240,272,SOLID,BLACK)
--	lcd.drawLine(239,0,239,272,SOLID,BLACK)
--	lcd.drawLine(0,45,480,45,SOLID,BLACK)
--	lcd.drawLine(0,44,480,44,SOLID,BLACK)
--	lcd.drawLine(0,136,480,136,SOLID,BLACK)
--	lcd.drawLine(0,135,480,135,SOLID,BLACK)
--	lcd.drawLine(240,90,480,90,SOLID,BLACK)
--	lcd.drawLine(240,89,480,89,SOLID,BLACK)
--	lcd.drawLine(70,45,70,136,SOLID,BLACK)
--	lcd.drawLine(69,45,69,136,SOLID,BLACK)
--	lcd.drawLine(170,45,170,136,SOLID,BLACK)
--	lcd.drawLine(169,45,169,136,SOLID,BLACK)
--	lcd.drawLine(355,0,355,90,SOLID,BLACK)
--	lcd.drawLine(354,0,354,90,SOLID,BLACK)
--	lcd.drawLine(0,80,240,80,DOTTED,BLACK)
end

local function refresh(thisWidget)
	local Current_CUSTOM_COLOR = CUSTOM_COLOR
	lcd.setColor(CUSTOM_COLOR,thisWidget.options.Color)
  
	buildgrid()
	draw_timer(0,136)
	draw_rssi(240,45,rssi)
 	draw_rpm(70,45,rpm)
 	draw_egt(0,45,egt)
 	draw_status(0,0,status)
-- 	draw_thr(355,45,thr)
 	draw_batecu(355,0,batecu)
	draw_batrx(240,0,batrx)
	draw_pump(170,45,pump)
 	draw_name(240,90,name)
	draw_tank(240,136,fuel,thisWidget.param.alarm)
	level_chk(status,fuel,thisWidget.param)
	  
	lcd.setColor(CUSTOM_COLOR,Current_CUSTOM_COLOR)
end

local function background(thisWidget)
  	
end

return { name="RDTJET", options=options, create=create, update=update, background=background, refresh=refresh }