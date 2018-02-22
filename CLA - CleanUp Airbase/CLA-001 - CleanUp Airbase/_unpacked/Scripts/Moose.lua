
local base = _G

env.info("Loading MOOSE" .. base.timer.getAbsTime())



Include = {}

Include.LoadPath = ''
Include.Files = {}

Include.File = function( IncludeFile )
	if not Include.Files[ IncludeFile ] then
		Include.Files[IncludeFile] = IncludeFile
		local chunk, errMsg = base.loadfile( IncludeFile .. ".lua" )
		env.info( "Include:" .. IncludeFile .. " loaded " .. chunk )
	end
end

Include.File( "Database" )

env.info("Loaded MOOSE")