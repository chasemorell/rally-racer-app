deltaX =  event.x - joystick.x
	deltaY = joystick.y - event.y 

	tDeltaY = event.y - joystick.y
	tDeltaX = event.x - joystick.x
	print("DELTA X = "..tDeltaX.." , DELTA Y = "..tDeltaY)
	--car.x = car.x + (tDeltaX/rate)
	--car.y = car.y + (tDeltaY/rate)

	angle = math.atan(deltaX/deltaY)
	angle = math.deg( angle )

	
			car.rotation = angle

	
	
	print(angle)


	