-- mpa.lua -- Desktop notifications for mpv.
--
-- Copyright (c) 2019 Vitaly Kovalyshyn
-- Copyright (c) 2014 Roland Hieber
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-------------------------------------------------------------------------------
-- helper functions
-------------------------------------------------------------------------------

function print_debug(s)
	--print("DEBUG: " .. s) -- comment out for no debug info
	return true
end

-- url-escape a string, per RFC 2396, Section 2
function string.urlescape(str)
	local s, c = string.gsub(str, "([^A-Za-z0-9_.!~*'()/-])",
		function(c)
			return ("%%%02x"):format(c:byte())
		end)
	return s;
end

-- escape string for html
function string.htmlescape(str)
	local str = string.gsub(str, "<", "&lt;")
	str = string.gsub(str, ">", "&gt;")
	str = string.gsub(str, "&", "&amp;")
	str = string.gsub(str, "\"", "&quot;")
	str = string.gsub(str, "'", "&apos;")
	return str
end

-- escape string for shell inclusion
function string.shellescape(str)
	return "'"..string.gsub(str, "'", "'\"'\"'").."'"
end

-- converts string to a valid filename on most (modern) filesystems
function string.safe_filename(str)
	local s, _ = string.gsub(str, "([^A-Za-z0-9_.-])",
		function(c)
			return ("%02x"):format(c:byte())
		end)
	return s;
end

-------------------------------------------------------------------------------
-- here we go.
-------------------------------------------------------------------------------

function notify_current_track()
	local data = mp.get_property_native("metadata")
	if not data then
		return
	end

	function get_metadata(data, keys)
		for _,v in pairs(keys) do
			if data[v] and string.len(data[v]) > 0 then
				return data[v]
			end
		end
		return ""
	end
	-- srsly MPV, why do we have to do this? :-(
	local artist = get_metadata(data, {"artist", "ARTIST"})
	local album = get_metadata(data, {"album", "ALBUM"})
	local title = get_metadata(data, {"title", "TITLE", "icy-title"})

	print_debug("notify_current_track: relevant metadata:")
	print_debug("artist: " .. artist)
	print_debug("album: " .. album)

	local summary = ""
	local body = ""
	local params = ""

	if(artist == "") then
		summary = string.shellescape("Now playing:")
	else
		summary = string.shellescape(string.htmlescape(artist))
	end
	if title == "" then
		body = string.shellescape(mp.get_property_native("filename"))
	else
		if album == "" then
			body = string.shellescape(string.htmlescape(title))
		else
			body = string.shellescape(("%s<br /><i>%s</i>"):format(
				string.htmlescape(title), string.htmlescape(album)))
		end
	end

	local command = ("notify-send -i media-tape %s -- %s %s"):format(params, summary, body)
	print_debug("command: " .. command)
	os.execute(command)

end

function notify_metadata_updated(name, data)
	notify_current_track()
end


-- insert main() here

mp.register_event("file-loaded", notify_current_track)
mp.observe_property("metadata", nil, notify_metadata_updated)
