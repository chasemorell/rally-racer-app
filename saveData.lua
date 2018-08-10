function writeData(name,data,mode,ending)
	local saveData = data
	if(ending == nil)then
		ending = "txt"
end
  	local path = system.pathForFile( name.."."..ending, system.DocumentsDirectory )

  	local file = io.open( path, mode )
  	file:write( saveData )

  	io.close( file )
  	file  = nil
end

function readData(name,getFromResources)

	if(getFromResources == true)then
			 path = system.pathForFile( name..".txt", system.ResourceDirectory )

	else
	 path = system.pathForFile( name..".txt", system.DocumentsDirectory )
end


	local file = io.open( path, "r" )
	if(file)then

		
		local savedData = file:read( "*a" )

		io.close( file )
		file = nil
		--print("Found This : "..savedData)
		return(savedData)

	else	

		return(0)

	end

end