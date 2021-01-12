

local time_menager = {}

function time_menager.from_minutes_to_sec(min)
	return min * 60
end

function time_menager.from_sec_to_minutes(second)
	local min, sec = math.modf(second / 60)
	return min, sec * 60
end

return time_menager