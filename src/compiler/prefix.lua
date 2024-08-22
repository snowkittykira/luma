local ops = {}
local function get_ops (self)
  return ops [type(self)] or error ("tried to apply unknown value " .. tostring (self))
end

local function invoke (self, num, ...)
  if type (self) == "function" then
    return self (...)
  elseif self.functions then
    if self.functions [num] then
      return self.functions [num] (...)
    elseif self.functions [".."] then
      return self.functions [".."] (...)
    end
    error "cant invoke this value with this number of arguments"
  else
    error "cant invoke this value"
  end
end

local function invoke_method (tbl, self, sym, ...)
  if tbl.methods and tbl.methods[sym] then
    return tbl.methods[sym](self, ...)
  elseif tbl.index then
    return invoke_method (tbl.index, self, sym, ...)
  else
    error ("symbol not found in table: " .. sym)
  end
end

local function invoke_symbol (self, sym, num, ...)
  if type (self) == "table" then
    if self[sym] ~= nil then
      if num == 0 then
        return self[sym]
      else
        return invoke (self[sym], num, ...)
      end
    elseif self.functions and self.functions[sym] then
      return invoke (self.functions[sym], num, ...)
    elseif self.index then
      return (invoke_method (self.index, self, sym, ...))
    else
      error ("symbol not found in table: " .. sym)
    end
  else
    local ops = get_ops (self)
    return invoke_method (ops, self, sym, ...)
  end
end

local function read_module_src (path)
  if rawget (_G, 'love') then
    return love.filesystem.read (path)
  else
    local file = assert (io.open (path, 'r'))
    local src = file:read '*a'
    file:close ()
    return src
  end
end

local function get_source_map (src)
  local path = src:match ('@(.*)')
  if path then
    src = read_module_src (path)
  end
  local source_map = {}
  local current_index = 1
  local current_line = 1
  local last_location
  while current_index < #src do
    local line = src:match ('([^\n]*)\n?', current_index)
    if line:match ('^%-%-@ ') then
      last_location = line:match ('^%-%-@ (.*)')
    end
    source_map [current_line] = last_location
    current_line = current_line + 1
    current_index = current_index + #line + 1
  end
  return source_map
end

local function error_handler (msg)
  local trace = { msg, '\n' }

  local level = 3
  while true do
    local raw = debug.getinfo (level)
    if not raw then
      break
    end
    local line = raw.currentline
    local source_map = get_source_map (raw.source)
    if raw.short_src:sub(1, 1) ~= '[' then
      table.insert (trace, '\t')
      table.insert (trace, raw.short_src .. ':' .. raw.currentline)
      if source_map [line] then
        table.insert (trace, '\t(' .. tostring (source_map [line]) .. ')')
      end
      table.insert (trace, '\n')
    end
    level = level + 1
  end

  return table.concat (trace)
end

local function run_with_error_handler (fn)
  local success, return_value = xpcall (fn, error_handler)
  if not success then
    error (return_value)
  end
  return return_value
end

