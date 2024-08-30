--@ unknown
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

local function assign_values_to_array (array, ...)
  local len = select ('#', ...)
  for i = 1, len do
    array [i-1] = select (i, ...)
  end
  array[".length"] = len
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
      if last_location == 'unknown' then
        last_location = nil
      end
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

local function top_level ()
local list_result__0
(function ()
local _modules_prelude__0, _bool__0, _string__0, _number__0, else__0, not__0, ___0, ___1, ___2, ___3, ___4, ____0, ___5, ___6, ____1, ____2, _collection__0, _list__0, _table__0, _pair__0, read_file__0, write_file__0, quote_string__0, safe_identifier__0, combine_strings__0, command_line_args__0, get_time__0, _modules_compiler_errors__0, error_at__0, assert_at__0, _modules_compiler_ast__0, _location__0, _token_node__0, _number_node__0, _apply_node__0, _list_node__0, _word_node__0, _vararg_node__0, _string_node__0, _binding_node__0, _field_node__0, _function_node__0, _symbol_function_node__0, _symbol_method_node__0, _symbol_node__0, _table_node__0, _primitive_node__0, _pair_node__0, _modules_compiler_read__0, read__0, _modules_compiler_context__0, _context__0, _modules_compiler_parse__0, parse__0, _modules_compiler_resolve__0, resolve__0, _modules_compiler_link__0, link__0, _modules_compiler_value__0, _value__0, _modules_compiler_lua_emitter__0, _lua_emitter__0, _modules_compiler_compile__0, compile__0
local list_result__1
(function ()
local _string__1, _bool__1, _number__1, else__1, not__1, ___7, ___8, ___9, ___10, ___11, ____3, ___12, ___13, ____4, ____5, _collection__1, _iterator__0, _list__1, _list_iterator__0, _table__1, _table_key_iterator__0, _pair__1, read_file__1, write_file__1, quote_string__1, safe_identifier__1, combine_strings__1, get_args__0, get_time__1, command_line_args__1
--@ prelude.luma:1:11
local table__0
local fn__0 = function (param__0, param__1)
--@ prelude.luma:2:19
local op_result__0 = param__0 == param__1
return op_result__0
end
local fn__1 = function (param__2)
--@ prelude.luma:3:23
local _string_result__0 = type (param__2) == "string"
return _string_result__0
end
local fn__2 = function (param__3, param__4)
--@ prelude.luma:5:22
local op_result__1 = param__3 == param__4
return op_result__1
end
local fn__3 = function (param__5, param__6)
--@ prelude.luma:6:22
local op_result__2 = param__5 ~= param__6
return op_result__2
end
local fn__4 = function (param__7, param__8)
--@ prelude.luma:7:22
local op_result__3 = param__7 < param__8
return op_result__3
end
local fn__5 = function (param__9, param__10)
--@ prelude.luma:8:22
local op_result__4 = param__9 > param__10
return op_result__4
end
local fn__6 = function (param__11, param__12)
--@ prelude.luma:9:22
local op_result__5 = param__11 <= param__12
return op_result__5
end
local fn__7 = function (param__13, param__14)
--@ prelude.luma:10:22
local op_result__6 = param__13 >= param__14
return op_result__6
end
local fn__8 = function (param__15)
--@ prelude.luma:12:46
local length_result__0 = #param__15
return length_result__0
end
local fn__9 = function (param__16, param__17, param__18)
--@ prelude.luma:13:53
local substring_result__0 = param__16:sub (param__17 + 1, param__18)
return substring_result__0
end
local fn__10 = function (param__19, param__20)
--@ prelude.luma:14:55
local contains_result__0 = param__19:find (param__20, 1, true) ~= nil
return contains_result__0
end
local fn__11 = function (param__21, param__22)
--@ prelude.luma:15:52
local concat_result__0 = param__21 .. param__22
return concat_result__0
end
local fn__12 = function (param__23, param__24)
--@ prelude.luma:16:47
local char_at_result__0 = param__23:match ("^[%z\01-\127\194-\244][\128-\191]*", param__24 + 1)
assert (char_at_result__0, "couldnt find next utf8 character in string")
return char_at_result__0
end
local fn__13 = function (param__25)
--@ prelude.luma:17:20
local list_result__2
local num__0
--@ prelude.luma:18:32
local _string_to_number_result__0 = tonumber(param__25)
num__0 = _string_to_number_result__0
--@ prelude.luma:19:11
local result__0 = num__0
if not result__0 then
--@ prelude.luma:19:17
result__0 = false
end
list_result__2 = result__0
--@ unknown
return list_result__2
end
local fn__14 = function (param__26)
--@ prelude.luma:20:25
return param__26
end
table__0 = {
functions = {
[".?"] = fn__1,
},
methods = {
[".="] = fn__0,
[".="] = fn__2,
[".~="] = fn__3,
[".<"] = fn__4,
[".>"] = fn__5,
[".<="] = fn__6,
[".>="] = fn__7,
[".length"] = fn__8,
[".substring"] = fn__9,
[".contains?"] = fn__10,
[".concat"] = fn__11,
[".utf8-char-at"] = fn__12,
[".to-number"] = fn__13,
[".to-string"] = fn__14,
},
}
--@ unknown
_string__1 = table__0
ops.string = _string__1
--@ prelude.luma:22:9
local table__1
local fn__15 = function (param__27, param__28)
--@ prelude.luma:23:19
local op_result__7 = param__27 == param__28
return op_result__7
end
local fn__16 = function (param__29)
--@ prelude.luma:24:21
local _bool_result__0 = type (param__29) == "boolean"
return _bool_result__0
end
local fn__17 = function (param__30)
--@ prelude.luma:25:37
local _value_to_string_result__0 = tostring(param__30)
return _value_to_string_result__0
end
table__1 = {
functions = {
[".?"] = fn__16,
},
methods = {
[".="] = fn__15,
[".to-string"] = fn__17,
},
}
--@ unknown
_bool__1 = table__1
ops.boolean = _bool__1
--@ prelude.luma:27:11
local table__2
local fn__18 = function (param__31)
--@ prelude.luma:28:23
local _number_result__0 = type (param__31) == "number"
return _number_result__0
end
local fn__19 = function (param__32)
--@ prelude.luma:30:37
local _value_to_string_result__1 = tostring(param__32)
return _value_to_string_result__1
end
local fn__20 = function (param__33, param__34)
--@ prelude.luma:32:21
local op_result__8 = param__33 + param__34
return op_result__8
end
local fn__21 = function (param__35, param__36)
--@ prelude.luma:33:21
local op_result__9 = param__35 - param__36
return op_result__9
end
local fn__22 = function (param__37, param__38)
--@ prelude.luma:34:21
local op_result__10 = param__37 * param__38
return op_result__10
end
local fn__23 = function (param__39, param__40)
--@ prelude.luma:35:21
local op_result__11 = param__39 / param__40
return op_result__11
end
local fn__24 = function (param__41, param__42)
--@ prelude.luma:36:21
local op_result__12 = param__41 == param__42
return op_result__12
end
local fn__25 = function (param__43, param__44)
--@ prelude.luma:37:21
local op_result__13 = param__43 ~= param__44
return op_result__13
end
local fn__26 = function (param__45, param__46)
--@ prelude.luma:38:21
local op_result__14 = param__45 < param__46
return op_result__14
end
local fn__27 = function (param__47, param__48)
--@ prelude.luma:39:21
local op_result__15 = param__47 > param__48
return op_result__15
end
local fn__28 = function (param__49, param__50)
--@ prelude.luma:40:21
local op_result__16 = param__49 <= param__50
return op_result__16
end
local fn__29 = function (param__51, param__52)
--@ prelude.luma:41:21
local op_result__17 = param__51 >= param__52
return op_result__17
end
local fn__30 = function (param__53)
--@ prelude.luma:42:21
local _sqrt_result__0 = math.sqrt(param__53)
return _sqrt_result__0
end
table__2 = {
functions = {
[".?"] = fn__18,
},
methods = {
[".to-string"] = fn__19,
[".+"] = fn__20,
[".-"] = fn__21,
[".*"] = fn__22,
["./"] = fn__23,
[".="] = fn__24,
[".~="] = fn__25,
[".<"] = fn__26,
[".>"] = fn__27,
[".<="] = fn__28,
[".>="] = fn__29,
[".sqrt"] = fn__30,
},
}
--@ unknown
_number__1 = table__2
ops.number = _number__1
--@ prelude.luma:44:11
else__1 = true
--@ prelude.luma:46:9
local fn__31 = function (param__54)
--@ prelude.luma:46:14
local result__1
if param__54 then
--@ prelude.luma:46:20
result__1 = false
else
--@ prelude.luma:46:25
result__1 = true
end
return result__1
end
not__1 = fn__31
--@ prelude.luma:48:10
local fn__32 = function (param__55, param__56)
--@ prelude.luma:48:18
return invoke_symbol (param__55, ".+", 1, param__56)
end
___7 = fn__32
--@ prelude.luma:49:10
local fn__33 = function (param__57, param__58)
--@ prelude.luma:49:18
return invoke_symbol (param__57, ".-", 1, param__58)
end
___8 = fn__33
--@ prelude.luma:50:10
local fn__34 = function (param__59, param__60)
--@ prelude.luma:50:18
return invoke_symbol (param__59, ".*", 1, param__60)
end
___9 = fn__34
--@ prelude.luma:51:10
local fn__35 = function (param__61, param__62)
--@ prelude.luma:51:18
return invoke_symbol (param__61, "./", 1, param__62)
end
___10 = fn__35
--@ prelude.luma:52:10
local fn__36 = function (param__63, param__64)
--@ prelude.luma:52:18
return invoke_symbol (param__63, ".=", 1, param__64)
end
___11 = fn__36
--@ prelude.luma:53:10
local fn__37 = function (param__65, param__66)
--@ prelude.luma:53:18
return invoke_symbol (param__65, ".~=", 1, param__66)
end
____3 = fn__37
--@ prelude.luma:54:10
local fn__38 = function (param__67, param__68)
--@ prelude.luma:54:18
return invoke_symbol (param__67, ".<", 1, param__68)
end
___12 = fn__38
--@ prelude.luma:55:10
local fn__39 = function (param__69, param__70)
--@ prelude.luma:55:18
return invoke_symbol (param__69, ".>", 1, param__70)
end
___13 = fn__39
--@ prelude.luma:56:10
local fn__40 = function (param__71, param__72)
--@ prelude.luma:56:18
return invoke_symbol (param__71, ".<=", 1, param__72)
end
____4 = fn__40
--@ prelude.luma:57:10
local fn__41 = function (param__73, param__74)
--@ prelude.luma:57:18
return invoke_symbol (param__73, ".>=", 1, param__74)
end
____5 = fn__41
--@ prelude.luma:59:15
local table__3
local fn__42 = function (param__75, param__76)
--@ prelude.luma:60:38
return invoke_symbol (invoke_symbol (param__75, ".iterator", 0), ".each", 1, param__76)
end
local fn__43 = function (param__77, param__78)
--@ prelude.luma:61:38
return invoke_symbol (invoke_symbol (param__77, ".iterator", 0), ".all?", 1, param__78)
end
table__3 = {
methods = {
[".each"] = fn__42,
[".all?"] = fn__43,
},
}
--@ unknown
_collection__1 = table__3
--@ prelude.luma:63:13
local table__4
local fn__44 = function (param__79, param__80)
--@ prelude.luma:64:18
local table__5
--@ prelude.luma:64:28
local fn__45 = function ()
--@ prelude.luma:65:22
return invoke_symbol (param__79, ".empty?", 0)
end
local fn__46 = function ()
--@ prelude.luma:66:22
return invoke (param__80, 1, invoke_symbol (param__79, ".item", 0))
end
local fn__47 = function ()
--@ prelude.luma:67:23
return invoke_symbol (param__79, ".advance", 0)
end
table__5 = {
["index"] = _iterator__0,
functions = {
[".empty?"] = fn__45,
[".item"] = fn__46,
[".advance"] = fn__47,
},
}
--@ unknown
return table__5
end
local fn__48 = function (param__81, param__82)
--@ prelude.luma:70:20
local while_condition__0 = invoke (not__1, 1, invoke_symbol (param__81, ".empty?", 0))
while while_condition__0 do
--@ prelude.luma:70:29
local list_result__3
--@ prelude.luma:71:13
invoke (param__82, 1, invoke_symbol (param__81, ".item", 0))
--@ prelude.luma:72:11
list_result__3 = invoke_symbol (param__81, ".advance", 0)
--@ unknown
local _ = list_result__3
--@ prelude.luma:70:20
while_condition__0 = invoke (not__1, 1, invoke_symbol (param__81, ".empty?", 0))
end
return false
end
local fn__49 = function (param__83)
--@ prelude.luma:74:18
local list_result__4
local list__0
--@ prelude.luma:75:17
list__0 = invoke (_list__1, 0)
--@ prelude.luma:76:20
local while_condition__1 = invoke (not__1, 1, invoke_symbol (param__83, ".empty?", 0))
while while_condition__1 do
--@ prelude.luma:76:29
local list_result__5
--@ prelude.luma:77:21
invoke_symbol (list__0, ".push", 1, invoke_symbol (param__83, ".item", 0))
--@ prelude.luma:78:11
list_result__5 = invoke_symbol (param__83, ".advance", 0)
--@ unknown
local _ = list_result__5
--@ prelude.luma:76:20
while_condition__1 = invoke (not__1, 1, invoke_symbol (param__83, ".empty?", 0))
end
--@ prelude.luma:79:9
list_result__4 = list__0
--@ unknown
return list_result__4
end
local fn__50 = function (param__84, param__85)
--@ prelude.luma:81:17
local list_result__6
--@ prelude.luma:82:18
local while_condition__2 = invoke_symbol (0, ".<", 1, param__85)
while while_condition__2 do
--@ prelude.luma:82:20
local list_result__7
--@ prelude.luma:83:20
param__85 = invoke_symbol (param__85, ".-", 1, 1)
--@ prelude.luma:84:11
list_result__7 = invoke_symbol (param__84, ".advance", 0)
--@ unknown
local _ = list_result__7
--@ prelude.luma:82:18
while_condition__2 = invoke_symbol (0, ".<", 1, param__85)
end
--@ prelude.luma:85:9
list_result__6 = param__84
--@ unknown
return list_result__6
end
local fn__51 = function (param__86, param__87)
--@ prelude.luma:87:17
local list_result__8
local result__2
--@ prelude.luma:88:17
result__2 = true
--@ prelude.luma:89:22
local result__3 = result__2
if result__3 then
--@ prelude.luma:89:32
result__3 = invoke (not__1, 1, invoke_symbol (param__86, ".empty?", 0))
end
local while_condition__3 = result__3
while while_condition__3 do
--@ prelude.luma:89:42
local list_result__9
--@ prelude.luma:90:25
result__2 = invoke (param__87, 1, invoke_symbol (param__86, ".item", 0))
--@ prelude.luma:91:11
list_result__9 = invoke_symbol (param__86, ".advance", 0)
--@ unknown
local _ = list_result__9
--@ prelude.luma:89:22
local result__4 = result__2
if result__4 then
--@ prelude.luma:89:32
result__4 = invoke (not__1, 1, invoke_symbol (param__86, ".empty?", 0))
end
while_condition__3 = result__4
end
--@ prelude.luma:92:11
list_result__8 = result__2
--@ unknown
return list_result__8
end
table__4 = {
methods = {
[".map"] = fn__44,
[".each"] = fn__48,
[".to-list"] = fn__49,
[".skip"] = fn__50,
[".all?"] = fn__51,
},
}
_iterator__0 = table__4
--@ prelude.luma:94:9
local table__6
--@ prelude.luma:94:21
local fn__52 = function (param__88)
--@ prelude.luma:95:25
local result__5 = type (param__88) == "table" and (param__88.index == _list__1 or param__88[_list__1] ~= nil)
return result__5
end
local fn__53 = function ()
--@ prelude.luma:97:9
local table__7
--@ prelude.luma:98:15
table__7 = {
["index"] = _list__1,
[".length"] = 0,
}
--@ unknown
return table__7
end
local fn__54 = function (...)
local param__89 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__89.n >= 0, "not enough arguments to function")
--@ prelude.luma:100:11
local list_result__10
local list__1
--@ prelude.luma:101:17
list__1 = invoke (_list__1, 0)
--@ prelude.luma:102:45
invoke (assign_values_to_array, 1 + param__89.n, list__1, unpack (param__89, 1, param__89.n))
--@ prelude.luma:103:9
list_result__10 = list__1
--@ unknown
return list_result__10
end
local fn__55 = function (...)
local param__90 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__90.n >= 0, "not enough arguments to function")
--@ prelude.luma:105:23
local list_result__11
local result__6
--@ prelude.luma:106:19
result__6 = invoke (_list__1, 0)
--@ prelude.luma:107:32
local fn__56 = function (param__91)
--@ prelude.luma:108:26
return invoke_symbol (result__6, ".push-items", 1, param__91)
end
invoke_symbol (invoke (_list__1, 0 + param__90.n, unpack (param__90, 1, param__90.n)), ".each", 1, fn__56)
--@ prelude.luma:109:11
list_result__11 = result__6
--@ unknown
return list_result__11
end
local fn__57 = function (param__92, param__93)
--@ prelude.luma:112:26
local result__7 = param__92 [param__93]
assert (result__7 ~= nil, "getting invalid index")
return result__7
end
local fn__58 = function (param__94, param__95, param__96)
--@ prelude.luma:114:18
local list_result__12
--@ prelude.luma:115:42
local assert_result__0 = assert(invoke_symbol (0, ".<=", 1, param__95), "index out of range")
--@ prelude.luma:116:51
local assert_result__1 = assert(invoke_symbol (param__95, ".<", 1, invoke_symbol (param__94, ".length", 0)), "index out of range")
--@ prelude.luma:117:28
param__94 [param__95] = param__96
list_result__12 = false
--@ unknown
return list_result__12
end
local fn__59 = function (param__97, param__98)
--@ prelude.luma:119:17
local list_result__13
--@ prelude.luma:120:38
param__97 [invoke_symbol (param__97, ".length", 0)] = param__98
--@ prelude.luma:121:13
param__97 [".length"] = invoke_symbol (invoke_symbol (param__97, ".length", 0), ".+", 1, 1)
list_result__13 = true
--@ unknown
return list_result__13
end
local fn__60 = function (param__99)
--@ prelude.luma:123:14
local list_result__14
local value__0
--@ prelude.luma:124:52
local assert_result__2 = assert(invoke_symbol (0, ".<", 1, invoke_symbol (param__99, ".length", 0)), "cant pop empty list")
--@ prelude.luma:125:13
param__99 [".length"] = invoke_symbol (invoke_symbol (param__99, ".length", 0), ".-", 1, 1)
--@ prelude.luma:126:36
local result__8 = param__99 [invoke_symbol (param__99, ".length", 0)]
assert (result__8 ~= nil, "getting invalid index")
value__0 = result__8
--@ prelude.luma:127:32
param__99 [invoke_symbol (param__99, ".length", 0)] = nil
--@ prelude.luma:128:10
list_result__14 = value__0
--@ unknown
return list_result__14
end
local fn__61 = function (param__100)
--@ prelude.luma:130:15
local list_result__15
--@ prelude.luma:131:53
local assert_result__3 = assert(invoke_symbol (0, ".<", 1, invoke_symbol (param__100, ".length", 0)), "cant peek empty list")
--@ prelude.luma:132:31
list_result__15 = invoke_symbol (param__100, ".get", 1, invoke_symbol (invoke_symbol (param__100, ".length", 0), ".-", 1, 1))
--@ unknown
return list_result__15
end
local fn__62 = function (param__101, param__102)
--@ prelude.luma:135:22
local fn__63 = function (param__103)
--@ prelude.luma:135:35
return invoke_symbol (param__101, ".push", 1, param__103)
end
return invoke_symbol (param__102, ".each", 1, fn__63)
end
local fn__64 = function (param__104)
--@ prelude.luma:138:21
return invoke_symbol (invoke_symbol (param__104, ".length", 0), ".=", 1, 0)
end
local fn__65 = function (param__105)
--@ prelude.luma:140:39
return invoke (_list_iterator__0, 1, param__105)
end
local fn__66 = function (param__106, param__107)
--@ prelude.luma:142:39
return invoke_symbol (invoke_symbol (invoke_symbol (param__106, ".iterator", 0), ".skip", 1, param__107), ".to-list", 0)
end
local fn__67 = function (param__108, param__109)
--@ prelude.luma:144:22
local list_result__16
local result__9, i__0, end__0
--@ prelude.luma:145:19
result__9 = invoke (_list__1, 0)
--@ prelude.luma:146:9
i__0 = 0
--@ prelude.luma:147:26
end__0 = invoke_symbol (invoke_symbol (param__108, ".length", 0), ".-", 1, param__109)
--@ prelude.luma:148:20
local while_condition__4 = invoke_symbol (i__0, ".<", 1, end__0)
while while_condition__4 do
--@ prelude.luma:148:22
local list_result__17
--@ prelude.luma:149:30
invoke_symbol (result__9, ".push", 1, invoke_symbol (param__108, ".get", 1, i__0))
--@ prelude.luma:150:20
i__0 = invoke_symbol (i__0, ".+", 1, 1)
list_result__17 = true
--@ unknown
local _ = list_result__17
--@ prelude.luma:148:20
while_condition__4 = invoke_symbol (i__0, ".<", 1, end__0)
end
--@ prelude.luma:151:11
list_result__16 = result__9
--@ unknown
return list_result__16
end
local fn__68 = function (param__110)
--@ prelude.luma:154:31
return invoke_symbol (param__110, ".get", 1, invoke_symbol (invoke_symbol (param__110, ".length", 0), ".-", 1, 1))
end
local fn__69 = function (param__111, param__112)
--@ prelude.luma:156:16
local list_result__18
local result__10, i__1, len__0
--@ prelude.luma:157:19
result__10 = invoke (_list__1, 0)
--@ prelude.luma:158:9
i__1 = 0
--@ prelude.luma:159:14
len__0 = invoke_symbol (param__111, ".length", 0)
--@ prelude.luma:160:20
local while_condition__5 = invoke_symbol (i__1, ".<", 1, len__0)
while while_condition__5 do
--@ prelude.luma:160:22
local list_result__19
--@ prelude.luma:161:33
invoke_symbol (result__10, ".push", 1, invoke (param__112, 1, invoke_symbol (param__111, ".get", 1, i__1)))
--@ prelude.luma:162:20
i__1 = invoke_symbol (i__1, ".+", 1, 1)
list_result__19 = true
--@ unknown
local _ = list_result__19
--@ prelude.luma:160:20
while_condition__5 = invoke_symbol (i__1, ".<", 1, len__0)
end
--@ prelude.luma:163:11
list_result__18 = result__10
--@ unknown
return list_result__18
end
local fn__70 = function (param__113)
--@ prelude.luma:167:21
local result__11
if param__113[0] == nil then
result__11 = ""
else
result__11 = param__113 [0] .. table.concat (param__113)
end
return result__11
end
local fn__71 = function (param__114, param__115)
--@ prelude.luma:169:21
local list_result__20
local sorted__0
--@ prelude.luma:170:14
sorted__0 = 1
--@ prelude.luma:171:26
local while_condition__6 = invoke_symbol (sorted__0, ".<", 1, invoke_symbol (param__114, ".length", 0))
while while_condition__6 do
--@ prelude.luma:171:35
local list_result__21
local value__1, i__2
--@ prelude.luma:172:29
value__1 = invoke_symbol (param__114, ".get", 1, sorted__0)
--@ prelude.luma:173:16
i__2 = sorted__0
--@ prelude.luma:174:25
local result__12 = invoke_symbol (0, ".<", 1, i__2)
if result__12 then
--@ prelude.luma:174:64
result__12 = invoke (not__1, 1, invoke (param__115, 2, invoke_symbol (param__114, ".get", 1, invoke_symbol (i__2, ".-", 1, 1)), value__1))
end
local while_condition__7 = result__12
while while_condition__7 do
--@ prelude.luma:174:68
local list_result__22
--@ prelude.luma:175:37
invoke_symbol (param__114, ".set", 2, i__2, invoke_symbol (param__114, ".get", 1, invoke_symbol (i__2, ".-", 1, 1)))
--@ prelude.luma:176:22
i__2 = invoke_symbol (i__2, ".-", 1, 1)
list_result__22 = true
--@ unknown
local _ = list_result__22
--@ prelude.luma:174:25
local result__13 = invoke_symbol (0, ".<", 1, i__2)
if result__13 then
--@ prelude.luma:174:64
result__13 = invoke (not__1, 1, invoke (param__115, 2, invoke_symbol (param__114, ".get", 1, invoke_symbol (i__2, ".-", 1, 1)), value__1))
end
while_condition__7 = result__13
end
--@ prelude.luma:177:23
invoke_symbol (param__114, ".set", 2, i__2, value__1)
--@ prelude.luma:178:30
sorted__0 = invoke_symbol (sorted__0, ".+", 1, 1)
list_result__21 = true
--@ unknown
local _ = list_result__21
--@ prelude.luma:171:26
while_condition__6 = invoke_symbol (sorted__0, ".<", 1, invoke_symbol (param__114, ".length", 0))
end
list_result__20 = false
--@ unknown
return list_result__20
end
local fn__72 = function (param__116, param__117)
--@ prelude.luma:181:17
local list_result__23
local i__3, end__1
--@ prelude.luma:182:9
i__3 = 0
--@ prelude.luma:183:14
end__1 = invoke_symbol (param__116, ".length", 0)
--@ prelude.luma:184:20
local while_condition__8 = invoke_symbol (i__3, ".<", 1, end__1)
while while_condition__8 do
--@ prelude.luma:184:22
local list_result__24
--@ prelude.luma:185:20
invoke (param__117, 1, invoke_symbol (param__116, ".get", 1, i__3))
--@ prelude.luma:186:20
i__3 = invoke_symbol (i__3, ".+", 1, 1)
list_result__24 = true
--@ unknown
local _ = list_result__24
--@ prelude.luma:184:20
while_condition__8 = invoke_symbol (i__3, ".<", 1, end__1)
end
list_result__23 = false
--@ unknown
return list_result__23
end
table__6 = {
["index"] = _collection__1,
functions = {
[".?"] = fn__52,
[0] = fn__53,
[".."] = fn__54,
[".append"] = fn__55,
},
methods = {
[".get"] = fn__57,
[".set"] = fn__58,
[".push"] = fn__59,
[".pop"] = fn__60,
[".peek"] = fn__61,
[".push-items"] = fn__62,
[".empty?"] = fn__64,
[".iterator"] = fn__65,
[".drop"] = fn__66,
[".drop-last"] = fn__67,
[".last"] = fn__68,
[".map"] = fn__69,
[".concat"] = fn__70,
[".sort"] = fn__71,
[".each"] = fn__72,
},
}
_list__1 = table__6
--@ prelude.luma:188:18
local table__8
--@ prelude.luma:188:28
local fn__73 = function (param__118)
--@ prelude.luma:189:14
local table__9
--@ prelude.luma:191:14
table__9 = {
["index"] = _list_iterator__0,
[".list"] = param__118,
[".index"] = 0,
}
--@ unknown
return table__9
end
local fn__74 = function (param__119)
--@ prelude.luma:192:44
return invoke_symbol (invoke_symbol (invoke_symbol (param__119, ".list", 0), ".length", 0), ".<=", 1, invoke_symbol (param__119, ".index", 0))
end
local fn__75 = function (param__120)
--@ prelude.luma:193:37
return invoke_symbol (invoke_symbol (param__120, ".list", 0), ".get", 1, invoke_symbol (param__120, ".index", 0))
end
local fn__76 = function (param__121)
--@ prelude.luma:194:18
local list_result__25
--@ prelude.luma:195:21
local assert_result__4 = assert(invoke (not__1, 1, invoke_symbol (param__121, ".empty?", 0)))
--@ prelude.luma:196:13
param__121 [".index"] = invoke_symbol (invoke_symbol (param__121, ".index", 0), ".+", 1, 1)
list_result__25 = true
--@ unknown
return list_result__25
end
table__8 = {
["index"] = _iterator__0,
functions = {
[1] = fn__73,
},
methods = {
[".empty?"] = fn__74,
[".item"] = fn__75,
[".advance"] = fn__76,
},
}
_list_iterator__0 = table__8
--@ prelude.luma:198:10
local table__10
local fn__77 = function (param__122)
--@ prelude.luma:199:26
local result__14 = type (param__122) == "table" and (param__122.index == _table__1 or param__122[_table__1] ~= nil)
return result__14
end
local fn__78 = function ()
--@ prelude.luma:201:9
local table__11
--@ prelude.luma:202:16
local table__12
table__12 = {
}
--@ unknown
table__11 = {
["index"] = _table__1,
[".-index"] = table__12,
}
return table__11
end
local fn__79 = function (...)
local param__123 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__123.n >= 0, "not enough arguments to function")
--@ prelude.luma:204:15
local list_result__26
local table__13, loop__0
--@ prelude.luma:205:19
table__13 = invoke (_table__1, 0)
--@ prelude.luma:206:12
local table__14
local fn__80 = function ()
--@ prelude.luma:207:17
return false
end
local fn__81 = function (...)
local param__124 = ...
local param__125 = { n = select ("#", ...) - 1, select (2, ...) }
assert (param__125.n >= 0, "not enough arguments to function")
--@ prelude.luma:208:24
local list_result__27
--@ prelude.luma:209:32
invoke_symbol (table__13, ".set", 2, invoke_symbol (param__124, ".key", 0), invoke_symbol (param__124, ".value", 0))
--@ prelude.luma:210:13
list_result__27 = invoke (loop__0, 0 + param__125.n, unpack (param__125, 1, param__125.n))
--@ unknown
return list_result__27
end
table__14 = {
functions = {
[0] = fn__80,
[".."] = fn__81,
},
}
loop__0 = table__14
--@ prelude.luma:211:10
invoke (loop__0, 0 + param__123.n, unpack (param__123, 1, param__123.n))
--@ prelude.luma:212:10
list_result__26 = table__13
--@ unknown
return list_result__26
end
local fn__82 = function (param__126, param__127)
--@ prelude.luma:215:36
local result__15 = invoke_symbol (param__126, ".-index", 0) [param__127] ~= nil
return result__15
end
local fn__83 = function (param__128, param__129, param__130)
--@ prelude.luma:218:41
invoke_symbol (param__128, ".-index", 0) [param__129] = param__130
return false
end
local fn__84 = function (param__131, param__132)
--@ prelude.luma:221:35
local result__16 = invoke_symbol (param__131, ".-index", 0) [param__132]
assert (result__16 ~= nil, "getting invalid index")
return result__16
end
local fn__85 = function (param__133, param__134, param__135)
--@ prelude.luma:224:22
local result__17
if invoke_symbol (param__133, ".has?", 1, param__134) then
--@ prelude.luma:225:37
local result__18 = invoke_symbol (param__133, ".-index", 0) [param__134]
assert (result__18 ~= nil, "getting invalid index")
result__17 = result__18
else
--@ prelude.luma:226:14
result__17 = param__135
end
return result__17
end
local fn__86 = function (param__136, param__137)
--@ prelude.luma:229:38
invoke_symbol (param__136, ".-index", 0) [param__137] = nil
return false
end
local fn__87 = function (param__138)
--@ prelude.luma:232:29
return invoke (_table_key_iterator__0, 1, param__138)
end
local fn__88 = function (param__139)
--@ prelude.luma:235:35
local fn__89 = function (param__140)
--@ prelude.luma:236:30
return invoke (_pair__1, 2, param__140, invoke_symbol (param__139, ".get", 1, param__140))
end
return invoke_symbol (invoke_symbol (param__139, ".key-iterator", 0), ".map", 1, fn__89)
end
table__10 = {
functions = {
[".?"] = fn__77,
[0] = fn__78,
[".."] = fn__79,
},
methods = {
[".has?"] = fn__82,
[".set"] = fn__83,
[".get"] = fn__84,
[".get-or"] = fn__85,
[".remove"] = fn__86,
[".key-iterator"] = fn__87,
[".pair-iterator"] = fn__88,
},
}
--@ unknown
_table__1 = table__10
--@ prelude.luma:238:23
local table__15
--@ prelude.luma:238:33
local fn__90 = function (param__141)
--@ prelude.luma:239:15
local table__16
--@ prelude.luma:242:16
table__16 = {
["index"] = _table_key_iterator__0,
[".table"] = param__141,
[".first?"] = true,
[".key"] = false,
}
--@ unknown
return table__16
end
local fn__91 = function (param__142)
--@ prelude.luma:245:25
local result__19
if invoke_symbol (param__142, ".first?", 0) then
--@ prelude.luma:246:35
local result__20 = next (invoke_symbol (invoke_symbol (param__142, ".table", 0), ".-index", 0), nil) ~= nil
result__19 = invoke (not__1, 1, result__20)
else
--@ prelude.luma:247:53
local result__21 = next (invoke_symbol (invoke_symbol (param__142, ".table", 0), ".-index", 0), invoke_symbol (param__142, ".key", 0)) ~= nil
result__19 = invoke (not__1, 1, result__21)
end
return result__19
end
local fn__92 = function (param__143)
--@ prelude.luma:248:23
local result__22
if invoke_symbol (param__143, ".first?", 0) then
--@ prelude.luma:249:25
local result__23 = next (invoke_symbol (invoke_symbol (param__143, ".table", 0), ".-index", 0), nil)
assert (result__23 ~= nil, "no next index")result__22 = result__23
else
--@ prelude.luma:250:43
local result__24 = next (invoke_symbol (invoke_symbol (param__143, ".table", 0), ".-index", 0), invoke_symbol (param__143, ".key", 0))
assert (result__24 ~= nil, "no next index")result__22 = result__24
end
return result__22
end
local fn__93 = function (param__144)
--@ prelude.luma:251:18
local list_result__28
--@ prelude.luma:252:21
local assert_result__5 = assert(invoke (not__1, 1, invoke_symbol (param__144, ".empty?", 0)))
--@ prelude.luma:253:13
param__144 [".key"] = invoke_symbol (param__144, ".item", 0)
--@ prelude.luma:254:13
param__144 [".first?"] = false
list_result__28 = true
--@ unknown
return list_result__28
end
table__15 = {
["index"] = _iterator__0,
functions = {
[1] = fn__90,
},
methods = {
[".empty?"] = fn__91,
[".item"] = fn__92,
[".advance"] = fn__93,
},
}
_table_key_iterator__0 = table__15
--@ prelude.luma:256:9
local table__17
local fn__94 = function (param__145)
--@ prelude.luma:257:25
local result__25 = type (param__145) == "table" and (param__145.index == _pair__1 or param__145[_pair__1] ~= nil)
return result__25
end
local fn__95 = function (param__146, param__147)
--@ prelude.luma:259:19
local table__18
--@ prelude.luma:261:18
table__18 = {
["index"] = _pair__1,
[".key"] = param__146,
[".value"] = param__147,
}
--@ unknown
return table__18
end
table__17 = {
functions = {
[".?"] = fn__94,
[2] = fn__95,
},
}
_pair__1 = table__17
--@ prelude.luma:263:18
local fn__96 = function (param__148)
--@ prelude.luma:264:18
local file__0 = assert (io.open (param__148, "r"))
local read_result__0 = file__0:read ("*a")
file__0:close ()
return read_result__0
end
read_file__1 = fn__96
--@ prelude.luma:266:24
local fn__97 = function (param__149, param__150)
--@ prelude.luma:267:25
local file__1 = assert (io.open (param__149, "w"))
file__1:write (param__150)
file__1:close ()
return true
end
write_file__1 = fn__97
--@ prelude.luma:269:20
local fn__98 = function (param__151)
--@ prelude.luma:270:20
local quote_result__0 = string.format ("%q", param__151)
return quote_result__0
end
quote_string__1 = fn__98
--@ prelude.luma:272:23
local fn__99 = function (param__152)
--@ prelude.luma:273:23
local safe_id_result__0 = string.gsub (param__152, "[^a-zA-Z0-9_]", "_")
if safe_id_result__0:match ("^[0-9]") then safe_id_result__0 = "_" .. safe_id_result__0 end
return safe_id_result__0
end
safe_identifier__1 = fn__99
--@ prelude.luma:275:27
local fn__100 = function (...)
local param__153 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__153.n >= 0, "not enough arguments to function")
local list_result__29
local flatten_to_list__0
--@ prelude.luma:277:26
local fn__101 = function (param__154)
local list_result__30
local flat_list__0, flatten_loop__0
--@ prelude.luma:278:22
flat_list__0 = invoke (_list__1, 0)
--@ prelude.luma:279:26
local fn__102 = function (param__155)
--@ prelude.luma:280:27
local fn__103 = function (param__156)
--@ prelude.luma:281:27
local result__26
if invoke_symbol (_string__1, ".?", 1, param__156) then
--@ prelude.luma:282:30
result__26 = invoke_symbol (flat_list__0, ".push", 1, param__156)
else
--@ prelude.luma:283:28
result__26 = invoke (flatten_loop__0, 1, param__156)
end
return result__26
end
return invoke_symbol (param__155, ".each", 1, fn__103)
end
flatten_loop__0 = fn__102
--@ prelude.luma:284:23
invoke (flatten_loop__0, 1, param__154)
--@ prelude.luma:285:14
list_result__30 = flat_list__0
--@ unknown
return list_result__30
end
flatten_to_list__0 = fn__101
--@ prelude.luma:286:26
list_result__29 = invoke_symbol (invoke (flatten_to_list__0, 1, invoke (_list__1, 0 + param__153.n, unpack (param__153, 1, param__153.n))), ".concat", 0)
--@ unknown
return list_result__29
end
combine_strings__1 = fn__100
--@ prelude.luma:288:14
local fn__104 = function (param__157)
local list_result__31
local result__27, n__0
--@ prelude.luma:289:17
result__27 = invoke (_list__1, 0)
--@ prelude.luma:290:7
n__0 = 1
--@ prelude.luma:291:15
local result__28 = --@ prelude.luma:291:17
arg [n__0] or false
local while_condition__9 = result__28
while while_condition__9 do
--@ prelude.luma:291:19
local list_result__32
--@ prelude.luma:292:23
local result__29 = --@ prelude.luma:292:25
arg [n__0] or false
invoke_symbol (result__27, ".push", 1, result__29)
--@ prelude.luma:293:18
n__0 = invoke_symbol (n__0, ".+", 1, 1)
list_result__32 = true
--@ unknown
local _ = list_result__32
--@ prelude.luma:291:15
local result__30 = --@ prelude.luma:291:17
arg [n__0] or false
while_condition__9 = result__30
end
--@ prelude.luma:294:9
list_result__31 = result__27
--@ unknown
return list_result__31
end
get_args__0 = fn__104
--@ prelude.luma:296:12
local fn__105 = function ()
--@ prelude.luma:297:13
local _get_time_result__0 = love.timer.getTime()
return _get_time_result__0
end
get_time__1 = fn__105
--@ prelude.luma:299:30
command_line_args__1 = invoke (get_args__0, 1, 1)
--@ prelude.luma:301:2
local table__19
--@ prelude.luma:327:22
table__19 = {
[".#bool"] = _bool__1,
[".#string"] = _string__1,
[".#number"] = _number__1,
[".else"] = else__1,
[".not"] = not__1,
[".+"] = ___7,
[".-"] = ___8,
[".*"] = ___9,
["./"] = ___10,
[".="] = ___11,
[".~="] = ____3,
[".<"] = ___12,
[".>"] = ___13,
[".<="] = ____4,
[".>="] = ____5,
[".#collection"] = _collection__1,
[".#list"] = _list__1,
[".#table"] = _table__1,
[".#pair"] = _pair__1,
[".read-file"] = read_file__1,
[".write-file"] = write_file__1,
[".quote-string"] = quote_string__1,
[".safe-identifier"] = safe_identifier__1,
[".combine-strings"] = combine_strings__1,
[".command-line-args"] = command_line_args__1,
[".get-time"] = get_time__1,
}
--@ unknown
list_result__1 = table__19
end)()
_modules_prelude__0 = list_result__1
_bool__0 = invoke_symbol (_modules_prelude__0, ".#bool", 0)
ops.boolean = _bool__0
_string__0 = invoke_symbol (_modules_prelude__0, ".#string", 0)
ops.string = _string__0
_number__0 = invoke_symbol (_modules_prelude__0, ".#number", 0)
ops.number = _number__0
else__0 = invoke_symbol (_modules_prelude__0, ".else", 0)
not__0 = invoke_symbol (_modules_prelude__0, ".not", 0)
___0 = invoke_symbol (_modules_prelude__0, ".+", 0)
___1 = invoke_symbol (_modules_prelude__0, ".-", 0)
___2 = invoke_symbol (_modules_prelude__0, ".*", 0)
___3 = invoke_symbol (_modules_prelude__0, "./", 0)
___4 = invoke_symbol (_modules_prelude__0, ".=", 0)
____0 = invoke_symbol (_modules_prelude__0, ".~=", 0)
___5 = invoke_symbol (_modules_prelude__0, ".<", 0)
___6 = invoke_symbol (_modules_prelude__0, ".>", 0)
____1 = invoke_symbol (_modules_prelude__0, ".<=", 0)
____2 = invoke_symbol (_modules_prelude__0, ".>=", 0)
_collection__0 = invoke_symbol (_modules_prelude__0, ".#collection", 0)
_list__0 = invoke_symbol (_modules_prelude__0, ".#list", 0)
_table__0 = invoke_symbol (_modules_prelude__0, ".#table", 0)
_pair__0 = invoke_symbol (_modules_prelude__0, ".#pair", 0)
read_file__0 = invoke_symbol (_modules_prelude__0, ".read-file", 0)
write_file__0 = invoke_symbol (_modules_prelude__0, ".write-file", 0)
quote_string__0 = invoke_symbol (_modules_prelude__0, ".quote-string", 0)
safe_identifier__0 = invoke_symbol (_modules_prelude__0, ".safe-identifier", 0)
combine_strings__0 = invoke_symbol (_modules_prelude__0, ".combine-strings", 0)
command_line_args__0 = invoke_symbol (_modules_prelude__0, ".command-line-args", 0)
get_time__0 = invoke_symbol (_modules_prelude__0, ".get-time", 0)
local list_result__33
local error_at__1, assert_at__1
--@ compiler/errors.luma:1:37
local fn__106 = function (param__158, param__159)
local list_result__34
local location__0
--@ compiler/errors.luma:2:45
local result__31
if invoke_symbol (_location__0, ".?", 1, param__158) then
--@ compiler/errors.luma:2:63
result__31 = param__158
else
--@ compiler/errors.luma:2:80
result__31 = invoke_symbol (param__158, ".location", 0)
end
location__0 = result__31
--@ compiler/errors.luma:3:56
local assert_result__6 = assert(false, invoke (combine_strings__0, 3, param__159, " at ", invoke_symbol (location__0, ".to-string", 0)))
list_result__34 = assert_result__6
--@ unknown
return list_result__34
end
error_at__1 = fn__106
--@ compiler/errors.luma:5:48
local fn__107 = function (param__160, param__161, param__162)
--@ compiler/errors.luma:6:7
local result__32
--@ compiler/errors.luma:6:22
if invoke (not__0, 1, param__160) then
--@ compiler/errors.luma:6:59
result__32 = invoke (error_at__1, 2, param__161, param__162)
else
result__32 = false
end
return result__32
end
assert_at__1 = fn__107
--@ compiler/errors.luma:8:2
local table__20
--@ compiler/errors.luma:10:24
table__20 = {
[".error-at"] = error_at__1,
[".assert-at"] = assert_at__1,
}
--@ unknown
list_result__33 = table__20
_modules_compiler_errors__0 = list_result__33
error_at__0 = invoke_symbol (_modules_compiler_errors__0, ".error-at", 0)
assert_at__0 = invoke_symbol (_modules_compiler_errors__0, ".assert-at", 0)
local list_result__35
(function ()
local space_separate__0, _location__1, unknown_location__0, _token_node__1, _number_node__1, _apply_node__1, _list_node__1, _word_node__1, _vararg_node__1, _string_node__1, _binding_node__1, _field_node__1, _function_node__1, _symbol_function_node__1, _symbol_method_node__1, _symbol_node__1, _table_node__1, _primitive_node__1, _pair_node__1, key_____0
--@ compiler/ast.luma:1:24
local fn__108 = function (param__163)
local list_result__36
local out__0, iter__0
--@ compiler/ast.luma:2:14
out__0 = invoke (_list__0, 0)
--@ compiler/ast.luma:3:14
iter__0 = invoke_symbol (param__163, ".iterator", 0)
--@ compiler/ast.luma:4:7
local result__33
--@ compiler/ast.luma:4:17
if invoke (not__0, 1, invoke_symbol (iter__0, ".empty?", 0)) then
--@ compiler/ast.luma:4:26
local list_result__37
--@ compiler/ast.luma:5:18
invoke_symbol (out__0, ".push", 1, invoke_symbol (iter__0, ".item", 0))
--@ compiler/ast.luma:6:9
list_result__37 = invoke_symbol (iter__0, ".advance", 0)
--@ unknown
result__33 = list_result__37
else
result__33 = false
end
--@ compiler/ast.luma:7:22
local fn__109 = function (param__164)
local list_result__38
--@ compiler/ast.luma:8:17
invoke_symbol (out__0, ".push", 1, " ")
--@ compiler/ast.luma:9:18
list_result__38 = invoke_symbol (out__0, ".push", 1, param__164)
--@ unknown
return list_result__38
end
invoke_symbol (iter__0, ".each", 1, fn__109)
--@ compiler/ast.luma:10:6
list_result__36 = out__0
--@ unknown
return list_result__36
end
space_separate__0 = fn__108
--@ compiler/ast.luma:12:13
local table__21
local fn__110 = function (param__165)
--@ compiler/ast.luma:13:29
local result__34 = type (param__165) == "table" and (param__165.index == _location__1 or param__165[_location__1] ~= nil)
return result__34
end
local fn__111 = function (param__166, param__167, param__168)
--@ compiler/ast.luma:14:27
local table__22
--@ compiler/ast.luma:18:14
table__22 = {
["index"] = _location__1,
[".filename"] = param__166,
[".line"] = param__167,
[".col"] = param__168,
}
--@ unknown
return table__22
end
local fn__112 = function ()
--@ compiler/ast.luma:19:33
return unknown_location__0
end
local fn__113 = function (param__169, param__170)
--@ compiler/ast.luma:22:23
local result__35 = invoke_symbol (invoke_symbol (param__169, ".filename", 0), ".~=", 1, invoke_symbol (param__170, ".filename", 0))
if not result__35 then
--@ compiler/ast.luma:24:21
local result__36 = invoke_symbol (invoke_symbol (param__169, ".line", 0), ".~=", 1, invoke_symbol (param__170, ".line", 0))
if not result__36 then
--@ compiler/ast.luma:25:20
result__36 = invoke_symbol (invoke_symbol (param__169, ".col", 0), ".~=", 1, invoke_symbol (param__170, ".col", 0))
end
result__35 = result__36
end
return result__35
end
local fn__114 = function (param__171)
--@ compiler/ast.luma:27:23
local result__37
if invoke_symbol (invoke_symbol (param__171, ".line", 0), ".<", 1, 0) then
--@ compiler/ast.luma:28:16
result__37 = "unknown"
else
--@ compiler/ast.luma:29:69
result__37 = invoke (combine_strings__0, 5, invoke_symbol (param__171, ".filename", 0), ":", invoke_symbol (invoke_symbol (param__171, ".line", 0), ".to-string", 0), ":", invoke_symbol (invoke_symbol (param__171, ".col", 0), ".to-string", 0))
end
return result__37
end
table__21 = {
functions = {
[".?"] = fn__110,
[3] = fn__111,
[".unknown"] = fn__112,
},
methods = {
[".~="] = fn__113,
[".to-string"] = fn__114,
},
}
--@ unknown
_location__1 = table__21
--@ compiler/ast.luma:31:44
unknown_location__0 = invoke (_location__1, 3, "unknown", -1, -1)
--@ compiler/ast.luma:33:15
local table__23
local fn__115 = function (param__172)
--@ compiler/ast.luma:34:31
local result__38 = type (param__172) == "table" and (param__172.index == _token_node__1 or param__172[_token_node__1] ~= nil)
return result__38
end
local fn__116 = function (param__173)
--@ compiler/ast.luma:35:35
return invoke (_token_node__1, 2, param__173, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__117 = function (param__174, param__175)
--@ compiler/ast.luma:36:21
local table__24
--@ compiler/ast.luma:39:24
table__24 = {
["index"] = _token_node__1,
[".id"] = param__174,
[".location"] = param__175,
}
--@ unknown
return table__24
end
local fn__118 = function (param__176)
--@ compiler/ast.luma:40:58
return invoke (combine_strings__0, 3, "[token ", invoke_symbol (param__176, ".id", 0), "]")
end
table__23 = {
functions = {
[".?"] = fn__115,
[1] = fn__116,
[2] = fn__117,
},
methods = {
[".to-string"] = fn__118,
},
}
--@ unknown
_token_node__1 = table__23
--@ compiler/ast.luma:42:16
local table__25
local fn__119 = function (param__177)
--@ compiler/ast.luma:43:32
local result__39 = type (param__177) == "table" and (param__177.index == _number_node__1 or param__177[_number_node__1] ~= nil)
return result__39
end
local fn__120 = function (param__178)
--@ compiler/ast.luma:44:42
return invoke (_number_node__1, 2, param__178, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__121 = function (param__179, param__180)
--@ compiler/ast.luma:45:24
local table__26
--@ compiler/ast.luma:48:24
table__26 = {
["index"] = _number_node__1,
[".value"] = param__179,
[".location"] = param__180,
}
--@ unknown
return table__26
end
local fn__122 = function (param__181)
--@ compiler/ast.luma:49:25
return invoke_symbol (invoke_symbol (param__181, ".value", 0), ".to-string", 0)
end
table__25 = {
functions = {
[".?"] = fn__119,
[1] = fn__120,
[2] = fn__121,
},
methods = {
[".to-string"] = fn__122,
},
}
--@ unknown
_number_node__1 = table__25
--@ compiler/ast.luma:51:15
local table__27
local fn__123 = function (param__182)
--@ compiler/ast.luma:52:31
local result__40 = type (param__182) == "table" and (param__182.index == _apply_node__1 or param__182[_apply_node__1] ~= nil)
return result__40
end
local fn__124 = function (param__183)
--@ compiler/ast.luma:53:41
return invoke (_apply_node__1, 2, param__183, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__125 = function (param__184, param__185)
--@ compiler/ast.luma:54:24
local table__28
--@ compiler/ast.luma:57:24
table__28 = {
["index"] = _apply_node__1,
[".items"] = param__184,
[".location"] = param__185,
}
--@ unknown
return table__28
end
local fn__126 = function (param__186)
--@ compiler/ast.luma:58:20
local list_result__39
--@ compiler/ast.luma:59:35
local assert_result__7 = assert(invoke_symbol (invoke_symbol (invoke_symbol (param__186, ".items", 0), ".length", 0), ".>", 1, 0))
--@ compiler/ast.luma:62:56
local fn__127 = function (param__187)
--@ compiler/ast.luma:62:61
return invoke_symbol (param__187, ".to-string", 0)
end
--@ compiler/ast.luma:63:10
list_result__39 = invoke (combine_strings__0, 3, "[", invoke (space_separate__0, 1, invoke_symbol (invoke_symbol (invoke_symbol (invoke_symbol (param__186, ".items", 0), ".iterator", 0), ".map", 1, fn__127), ".to-list", 0)), "]")
--@ unknown
return list_result__39
end
table__27 = {
functions = {
[".?"] = fn__123,
[1] = fn__124,
[2] = fn__125,
},
methods = {
[".to-string"] = fn__126,
},
}
_apply_node__1 = table__27
--@ compiler/ast.luma:65:14
local table__29
local fn__128 = function (param__188)
--@ compiler/ast.luma:66:30
local result__41 = type (param__188) == "table" and (param__188.index == _list_node__1 or param__188[_list_node__1] ~= nil)
return result__41
end
local fn__129 = function (param__189)
--@ compiler/ast.luma:67:40
return invoke (_list_node__1, 2, param__189, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__130 = function (param__190, param__191)
--@ compiler/ast.luma:68:24
local table__30
--@ compiler/ast.luma:71:24
table__30 = {
["index"] = _list_node__1,
[".items"] = param__190,
[".location"] = param__191,
}
--@ unknown
return table__30
end
local fn__131 = function (param__192)
--@ compiler/ast.luma:74:36
local fn__132 = function (param__193)
--@ compiler/ast.luma:74:59
return invoke (combine_strings__0, 2, " ", invoke_symbol (param__193, ".to-string", 0))
end
--@ compiler/ast.luma:75:8
return invoke (combine_strings__0, 3, "[!", invoke_symbol (invoke_symbol (invoke_symbol (invoke_symbol (param__192, ".items", 0), ".iterator", 0), ".map", 1, fn__132), ".to-list", 0), "]")
end
table__29 = {
functions = {
[".?"] = fn__128,
[1] = fn__129,
[2] = fn__130,
},
methods = {
[".to-string"] = fn__131,
},
}
--@ unknown
_list_node__1 = table__29
--@ compiler/ast.luma:77:14
local table__31
local fn__133 = function (param__194)
--@ compiler/ast.luma:78:30
local result__42 = type (param__194) == "table" and (param__194.index == _word_node__1 or param__194[_word_node__1] ~= nil)
return result__42
end
local fn__134 = function (param__195)
--@ compiler/ast.luma:79:34
return invoke (_word_node__1, 2, param__195, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__135 = function (param__196, param__197)
--@ compiler/ast.luma:80:21
local table__32
--@ compiler/ast.luma:83:24
table__32 = {
["index"] = _word_node__1,
[".id"] = param__196,
[".location"] = param__197,
}
--@ unknown
return table__32
end
local fn__136 = function (param__198)
--@ compiler/ast.luma:84:25
return invoke_symbol (param__198, ".id", 0)
end
table__31 = {
functions = {
[".?"] = fn__133,
[1] = fn__134,
[2] = fn__135,
},
methods = {
[".to-string"] = fn__136,
},
}
--@ unknown
_word_node__1 = table__31
--@ compiler/ast.luma:86:16
local table__33
local fn__137 = function (param__199)
--@ compiler/ast.luma:87:32
local result__43 = type (param__199) == "table" and (param__199.index == _vararg_node__1 or param__199[_vararg_node__1] ~= nil)
return result__43
end
local fn__138 = function (param__200)
--@ compiler/ast.luma:88:36
return invoke (_vararg_node__1, 2, param__200, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__139 = function (param__201, param__202)
--@ compiler/ast.luma:89:21
local table__34
--@ compiler/ast.luma:92:24
table__34 = {
["index"] = _vararg_node__1,
[".id"] = param__201,
[".location"] = param__202,
}
--@ unknown
return table__34
end
local fn__140 = function (param__203)
--@ compiler/ast.luma:93:25
return invoke_symbol (param__203, ".id", 0)
end
table__33 = {
functions = {
[".?"] = fn__137,
[1] = fn__138,
[2] = fn__139,
},
methods = {
[".to-string"] = fn__140,
},
}
--@ unknown
_vararg_node__1 = table__33
--@ compiler/ast.luma:95:16
local table__35
local fn__141 = function (param__204)
--@ compiler/ast.luma:96:32
local result__44 = type (param__204) == "table" and (param__204.index == _string_node__1 or param__204[_string_node__1] ~= nil)
return result__44
end
local fn__142 = function (param__205)
--@ compiler/ast.luma:97:42
return invoke (_string_node__1, 2, param__205, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__143 = function (param__206, param__207)
--@ compiler/ast.luma:98:24
local table__36
--@ compiler/ast.luma:101:24
table__36 = {
["index"] = _string_node__1,
[".value"] = param__206,
[".location"] = param__207,
}
--@ unknown
return table__36
end
local fn__144 = function (param__208)
--@ compiler/ast.luma:102:57
return invoke (combine_strings__0, 3, "'", invoke_symbol (param__208, ".value", 0), "'")
end
table__35 = {
functions = {
[".?"] = fn__141,
[1] = fn__142,
[2] = fn__143,
},
methods = {
[".to-string"] = fn__144,
},
}
--@ unknown
_string_node__1 = table__35
--@ compiler/ast.luma:104:17
local table__37
local fn__145 = function (param__209)
--@ compiler/ast.luma:105:33
local result__45 = type (param__209) == "table" and (param__209.index == _binding_node__1 or param__209[_binding_node__1] ~= nil)
return result__45
end
local fn__146 = function (param__210, param__211)
--@ compiler/ast.luma:106:49
return invoke (_binding_node__1, 3, param__210, param__211, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__147 = function (param__212, param__213, param__214)
--@ compiler/ast.luma:107:27
local table__38
--@ compiler/ast.luma:111:24
table__38 = {
["index"] = _binding_node__1,
[".id"] = param__212,
[".value"] = param__213,
[".location"] = param__214,
}
--@ unknown
return table__38
end
local fn__148 = function (param__215)
--@ compiler/ast.luma:112:54
return invoke (combine_strings__0, 3, invoke_symbol (param__215, ".id", 0), ": ", invoke_symbol (invoke_symbol (param__215, ".value", 0), ".to-string", 0))
end
table__37 = {
functions = {
[".?"] = fn__145,
[2] = fn__146,
[3] = fn__147,
},
methods = {
[".to-string"] = fn__148,
},
}
--@ unknown
_binding_node__1 = table__37
--@ compiler/ast.luma:114:15
local table__39
local fn__149 = function (param__216)
--@ compiler/ast.luma:115:31
local result__46 = type (param__216) == "table" and (param__216.index == _field_node__1 or param__216[_field_node__1] ~= nil)
return result__46
end
local fn__150 = function (param__217, param__218)
--@ compiler/ast.luma:116:47
return invoke (_field_node__1, 3, param__217, param__218, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__151 = function (param__219, param__220, param__221)
--@ compiler/ast.luma:117:27
local table__40
--@ compiler/ast.luma:121:24
table__40 = {
["index"] = _field_node__1,
[".id"] = param__219,
[".value"] = param__220,
[".location"] = param__221,
}
--@ unknown
return table__40
end
local fn__152 = function (param__222)
--@ compiler/ast.luma:122:54
return invoke (combine_strings__0, 3, invoke_symbol (param__222, ".id", 0), ": ", invoke_symbol (invoke_symbol (param__222, ".value", 0), ".to-string", 0))
end
table__39 = {
functions = {
[".?"] = fn__149,
[2] = fn__150,
[3] = fn__151,
},
methods = {
[".to-string"] = fn__152,
},
}
--@ unknown
_field_node__1 = table__39
--@ compiler/ast.luma:124:18
local table__41
local fn__153 = function (param__223)
--@ compiler/ast.luma:125:34
local result__47 = type (param__223) == "table" and (param__223.index == _function_node__1 or param__223[_function_node__1] ~= nil)
return result__47
end
local fn__154 = function (param__224, param__225)
--@ compiler/ast.luma:126:56
return invoke (_function_node__1, 3, param__224, param__225, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__155 = function (param__226, param__227, param__228)
--@ compiler/ast.luma:127:30
local table__42
--@ compiler/ast.luma:131:24
table__42 = {
["index"] = _function_node__1,
[".params"] = param__226,
[".body"] = param__227,
[".location"] = param__228,
}
--@ unknown
return table__42
end
local fn__156 = function (param__229)
--@ compiler/ast.luma:134:27
local fn__157 = function (param__230)
--@ compiler/ast.luma:134:50
return invoke (combine_strings__0, 2, " ", param__230)
end
--@ compiler/ast.luma:136:9
return invoke (combine_strings__0, 4, "[.", invoke_symbol (invoke_symbol (param__229, ".params", 0), ".map", 1, fn__157), "]: ", invoke_symbol (invoke_symbol (param__229, ".body", 0), ".to-string", 0))
end
table__41 = {
functions = {
[".?"] = fn__153,
[2] = fn__154,
[3] = fn__155,
},
methods = {
[".to-string"] = fn__156,
},
}
--@ unknown
_function_node__1 = table__41
--@ compiler/ast.luma:138:25
local table__43
local fn__158 = function (param__231)
--@ compiler/ast.luma:139:41
local result__48 = type (param__231) == "table" and (param__231.index == _symbol_function_node__1 or param__231[_symbol_function_node__1] ~= nil)
return result__48
end
local fn__159 = function (param__232, param__233)
--@ compiler/ast.luma:140:63
return invoke (_symbol_function_node__1, 3, param__232, param__233, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__160 = function (param__234, param__235, param__236, param__237)
--@ compiler/ast.luma:141:37
local table__44
--@ compiler/ast.luma:146:24
table__44 = {
["index"] = _symbol_function_node__1,
[".symbol"] = param__234,
[".params"] = param__235,
[".body"] = param__236,
[".location"] = param__237,
}
--@ unknown
return table__44
end
local fn__161 = function (param__238)
--@ compiler/ast.luma:149:27
local fn__162 = function (param__239)
--@ compiler/ast.luma:149:50
return invoke (combine_strings__0, 2, " ", param__239)
end
--@ compiler/ast.luma:150:21
return invoke (combine_strings__0, 3, invoke (_list__0, 2, "[. ", invoke_symbol (param__238, ".symbol", 0)), invoke_symbol (invoke_symbol (param__238, ".params", 0), ".map", 1, fn__162), invoke (_list__0, 2, "]: ", invoke_symbol (invoke_symbol (param__238, ".body", 0), ".to-string", 0)))
end
table__43 = {
functions = {
[".?"] = fn__158,
[2] = fn__159,
[4] = fn__160,
},
methods = {
[".to-string"] = fn__161,
},
}
--@ unknown
_symbol_function_node__1 = table__43
--@ compiler/ast.luma:152:23
local table__45
local fn__163 = function (param__240)
--@ compiler/ast.luma:153:39
local result__49 = type (param__240) == "table" and (param__240.index == _symbol_method_node__1 or param__240[_symbol_method_node__1] ~= nil)
return result__49
end
local fn__164 = function (param__241, param__242)
--@ compiler/ast.luma:154:61
return invoke (_symbol_method_node__1, 3, param__241, param__242, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__165 = function (param__243, param__244, param__245, param__246)
--@ compiler/ast.luma:155:37
local table__46
--@ compiler/ast.luma:160:24
table__46 = {
["index"] = _symbol_method_node__1,
[".symbol"] = param__243,
[".params"] = param__244,
[".body"] = param__245,
[".location"] = param__246,
}
--@ unknown
return table__46
end
local fn__166 = function (param__247)
--@ compiler/ast.luma:161:20
local list_result__40
local iter__1, first__0
--@ compiler/ast.luma:162:15
iter__1 = invoke_symbol (invoke_symbol (param__247, ".params", 0), ".iterator", 0)
--@ compiler/ast.luma:163:16
first__0 = invoke_symbol (iter__1, ".item", 0)
--@ compiler/ast.luma:164:9
invoke_symbol (iter__1, ".advance", 0)
--@ compiler/ast.luma:167:23
local fn__167 = function (param__248)
--@ compiler/ast.luma:167:46
return invoke (combine_strings__0, 2, " ", param__248)
end
--@ compiler/ast.luma:168:23
list_result__40 = invoke (combine_strings__0, 3, invoke (_list__0, 3, "[", first__0, invoke_symbol (param__247, ".symbol", 0)), invoke_symbol (invoke_symbol (iter__1, ".map", 1, fn__167), ".to-list", 0), invoke (_list__0, 2, "]: ", invoke_symbol (invoke_symbol (param__247, ".body", 0), ".to-string", 0)))
--@ unknown
return list_result__40
end
table__45 = {
functions = {
[".?"] = fn__163,
[2] = fn__164,
[4] = fn__165,
},
methods = {
[".to-string"] = fn__166,
},
}
_symbol_method_node__1 = table__45
--@ compiler/ast.luma:170:16
local table__47
local fn__168 = function (param__249)
--@ compiler/ast.luma:171:32
local result__50 = type (param__249) == "table" and (param__249.index == _symbol_node__1 or param__249[_symbol_node__1] ~= nil)
return result__50
end
local fn__169 = function (param__250)
--@ compiler/ast.luma:172:36
return invoke (_symbol_node__1, 2, param__250, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__170 = function (param__251, param__252)
--@ compiler/ast.luma:173:21
local table__48
--@ compiler/ast.luma:176:24
table__48 = {
["index"] = _symbol_node__1,
[".id"] = param__251,
[".location"] = param__252,
}
--@ unknown
return table__48
end
local fn__171 = function (param__253)
--@ compiler/ast.luma:177:25
return invoke_symbol (param__253, ".id", 0)
end
table__47 = {
functions = {
[".?"] = fn__168,
[1] = fn__169,
[2] = fn__170,
},
methods = {
[".to-string"] = fn__171,
},
}
--@ unknown
_symbol_node__1 = table__47
--@ compiler/ast.luma:179:15
local table__49
local fn__172 = function (param__254)
--@ compiler/ast.luma:180:31
local result__51 = type (param__254) == "table" and (param__254.index == _table_node__1 or param__254[_table_node__1] ~= nil)
return result__51
end
local fn__173 = function (param__255)
--@ compiler/ast.luma:181:41
return invoke (_table_node__1, 2, param__255, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__174 = function (param__256, param__257)
--@ compiler/ast.luma:182:24
local table__50
--@ compiler/ast.luma:185:24
table__50 = {
["index"] = _table_node__1,
[".items"] = param__256,
[".location"] = param__257,
}
--@ unknown
return table__50
end
local fn__175 = function (param__258)
--@ compiler/ast.luma:189:38
local fn__176 = function (param__259)
--@ compiler/ast.luma:189:61
return invoke (combine_strings__0, 2, " ", invoke_symbol (param__259, ".to-string", 0))
end
--@ compiler/ast.luma:190:10
return invoke (combine_strings__0, 3, "[#", invoke_symbol (invoke_symbol (invoke_symbol (invoke_symbol (param__258, ".items", 0), ".iterator", 0), ".map", 1, fn__176), ".to-list", 0), "]")
end
table__49 = {
functions = {
[".?"] = fn__172,
[1] = fn__173,
[2] = fn__174,
},
methods = {
[".to-string"] = fn__175,
},
}
--@ unknown
_table_node__1 = table__49
--@ compiler/ast.luma:192:19
local table__51
local fn__177 = function (param__260)
--@ compiler/ast.luma:193:35
local result__52 = type (param__260) == "table" and (param__260.index == _primitive_node__1 or param__260[_primitive_node__1] ~= nil)
return result__52
end
local fn__178 = function (param__261)
--@ compiler/ast.luma:194:39
return invoke (_primitive_node__1, 2, param__261, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__179 = function (param__262, param__263)
--@ compiler/ast.luma:195:21
local table__52
--@ compiler/ast.luma:198:24
table__52 = {
["index"] = _primitive_node__1,
[".fn"] = param__262,
[".location"] = param__263,
}
--@ unknown
return table__52
end
local fn__180 = function (param__264)
--@ compiler/ast.luma:199:29
return "<prim>"
end
table__51 = {
functions = {
[".?"] = fn__177,
[1] = fn__178,
[2] = fn__179,
},
methods = {
[".to-string"] = fn__180,
},
}
--@ unknown
_primitive_node__1 = table__51
--@ compiler/ast.luma:201:14
local table__53
local fn__181 = function (param__265)
--@ compiler/ast.luma:202:30
local result__53 = type (param__265) == "table" and (param__265.index == _pair_node__1 or param__265[_pair_node__1] ~= nil)
return result__53
end
local fn__182 = function (param__266, param__267)
--@ compiler/ast.luma:203:48
return invoke (_pair_node__1, 3, param__266, param__267, invoke_symbol (_location__1, ".unknown", 0))
end
local fn__183 = function (param__268, param__269, param__270)
--@ compiler/ast.luma:204:28
local table__54
--@ compiler/ast.luma:208:24
table__54 = {
["index"] = _pair_node__1,
[".key"] = param__268,
[".value"] = param__269,
[".location"] = param__270,
}
--@ unknown
return table__54
end
local fn__184 = function (param__271)
--@ compiler/ast.luma:210:49
return invoke (combine_strings__0, 3, invoke_symbol (invoke_symbol (param__271, ".key", 0), ".to-string", 0), ": ", invoke_symbol (invoke_symbol (param__271, ".value", 0), ".to-string", 0))
end
table__53 = {
functions = {
[".?"] = fn__181,
[2] = fn__182,
[3] = fn__183,
},
methods = {
[".to-string"] = fn__184,
},
}
--@ unknown
_pair_node__1 = table__53
--@ compiler/ast.luma:212:14
local fn__185 = function (param__272, param__273)
local list_result__41
local a_type_value__0, b_type_value__0
--@ compiler/ast.luma:213:32
local result__54
if invoke_symbol (_number__0, ".?", 1, param__272) then
--@ compiler/ast.luma:213:35
result__54 = 0
else
--@ compiler/ast.luma:213:37
result__54 = 1
end
a_type_value__0 = result__54
--@ compiler/ast.luma:214:32
local result__55
if invoke_symbol (_number__0, ".?", 1, param__273) then
--@ compiler/ast.luma:214:35
result__55 = 0
else
--@ compiler/ast.luma:214:37
result__55 = 1
end
b_type_value__0 = result__55
--@ compiler/ast.luma:215:7
local result__56
--@ compiler/ast.luma:216:34
if invoke_symbol (a_type_value__0, ".<", 1, b_type_value__0) then
--@ compiler/ast.luma:216:41
result__56 = true
else
--@ compiler/ast.luma:217:34
if invoke_symbol (a_type_value__0, ".=", 1, b_type_value__0) then
--@ compiler/ast.luma:217:44
result__56 = invoke_symbol (param__272, ".<=", 1, param__273)
else
--@ compiler/ast.luma:218:9
if else__0 then
--@ compiler/ast.luma:218:42
result__56 = false
else
result__56 = false
end
end
end
list_result__41 = result__56
--@ unknown
return list_result__41
end
key_____0 = fn__185
--@ compiler/ast.luma:220:2
local table__55
--@ compiler/ast.luma:237:26
table__55 = {
[".#location"] = _location__1,
[".#token-node"] = _token_node__1,
[".#number-node"] = _number_node__1,
[".#apply-node"] = _apply_node__1,
[".#list-node"] = _list_node__1,
[".#word-node"] = _word_node__1,
[".#vararg-node"] = _vararg_node__1,
[".#string-node"] = _string_node__1,
[".#binding-node"] = _binding_node__1,
[".#field-node"] = _field_node__1,
[".#function-node"] = _function_node__1,
[".#symbol-function-node"] = _symbol_function_node__1,
[".#symbol-method-node"] = _symbol_method_node__1,
[".#symbol-node"] = _symbol_node__1,
[".#table-node"] = _table_node__1,
[".#primitive-node"] = _primitive_node__1,
[".#pair-node"] = _pair_node__1,
}
--@ unknown
list_result__35 = table__55
end)()
_modules_compiler_ast__0 = list_result__35
_location__0 = invoke_symbol (_modules_compiler_ast__0, ".#location", 0)
_token_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#token-node", 0)
_number_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#number-node", 0)
_apply_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#apply-node", 0)
_list_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#list-node", 0)
_word_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#word-node", 0)
_vararg_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#vararg-node", 0)
_string_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#string-node", 0)
_binding_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#binding-node", 0)
_field_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#field-node", 0)
_function_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#function-node", 0)
_symbol_function_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#symbol-function-node", 0)
_symbol_method_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#symbol-method-node", 0)
_symbol_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#symbol-node", 0)
_table_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#table-node", 0)
_primitive_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#primitive-node", 0)
_pair_node__0 = invoke_symbol (_modules_compiler_ast__0, ".#pair-node", 0)
local list_result__42
local read__1
--@ compiler/read.luma:1:21
local fn__186 = function (param__274, param__275)
local list_result__43
(function ()
local i__4, line__0, col__0, char__0, current_location__0, peek__0, advance__0, emit_index__0, pending_text__0, discard__0, is_char___0, is_in___0, is_space___0, begins_word___0, continues_word___0, begins_number___0, continues_number___0, tokens__0, emit__0, skip_space__0, skip_comment__0, skip_space_and_comments__0, indent_levels__0, paren_level__0, current_indent__0, read_new_line__0, read_word__0, read_number__0, read_dash__0, read_string__0, read_token__0, unindent_loop__0
--@ compiler/read.luma:3:7
i__4 = 0
--@ compiler/read.luma:4:10
line__0 = 1
--@ compiler/read.luma:5:9
col__0 = 0
--@ compiler/read.luma:6:11
char__0 = ""
--@ compiler/read.luma:8:22
local fn__187 = function ()
--@ compiler/read.luma:9:32
return invoke (_location__0, 3, param__275, line__0, col__0)
end
current_location__0 = fn__187
--@ compiler/read.luma:11:10
local fn__188 = function ()
--@ compiler/read.luma:12:33
local result__57 = invoke (___5, 2, invoke (___0, 2, i__4, invoke_symbol (char__0, ".length", 0)), invoke_symbol (param__274, ".length", 0))
if result__57 then
--@ compiler/read.luma:13:36
result__57 = invoke_symbol (param__274, ".utf8-char-at", 1, invoke (___0, 2, i__4, invoke_symbol (char__0, ".length", 0)))
end
return result__57
end
peek__0 = fn__188
--@ compiler/read.luma:15:13
local fn__189 = function ()
local list_result__44
local len__1
--@ compiler/read.luma:16:9
local result__58
--@ compiler/read.luma:16:25
local op_result__18 = char__0 == false
if op_result__18 then
--@ compiler/read.luma:17:51
result__58 = invoke (error_at__0, 2, invoke (current_location__0, 0), "passed the end")
else
result__58 = false
end
--@ compiler/read.luma:19:9
local result__59
--@ compiler/read.luma:20:21
local op_result__19 = char__0 == "\
"
if op_result__19 then
--@ compiler/read.luma:20:23
local list_result__45
--@ compiler/read.luma:21:27
line__0 = invoke (___0, 2, line__0, 1)
--@ compiler/read.luma:22:18
col__0 = 1
list_result__45 = true
--@ unknown
result__59 = list_result__45
else
--@ compiler/read.luma:23:11
if else__0 then
--@ compiler/read.luma:24:25
col__0 = invoke (___0, 2, col__0, 1)
result__59 = true
else
result__59 = false
end
end
--@ compiler/read.luma:26:14
len__1 = invoke_symbol (char__0, ".length", 0)
--@ compiler/read.luma:27:19
char__0 = invoke (peek__0, 0)
--@ compiler/read.luma:28:19
i__4 = invoke (___0, 2, i__4, len__1)
list_result__44 = true
--@ unknown
return list_result__44
end
advance__0 = fn__189
--@ compiler/read.luma:30:11
invoke (advance__0, 0)
--@ compiler/read.luma:33:16
emit_index__0 = 0
--@ compiler/read.luma:34:18
local fn__190 = function ()
--@ compiler/read.luma:34:47
return invoke_symbol (param__274, ".substring", 2, emit_index__0, i__4)
end
pending_text__0 = fn__190
--@ compiler/read.luma:35:13
local fn__191 = function ()
--@ compiler/read.luma:35:37
emit_index__0 = i__4
return true
end
discard__0 = fn__191
--@ compiler/read.luma:38:16
local fn__192 = function (param__276)
--@ compiler/read.luma:38:33
return invoke (___4, 2, param__276, char__0)
end
is_char___0 = fn__192
--@ compiler/read.luma:39:20
local fn__193 = function (param__277)
--@ compiler/read.luma:39:32
local result__60 = char__0
if result__60 then
--@ compiler/read.luma:39:56
result__60 = invoke_symbol (param__277, ".contains?", 1, char__0)
end
return result__60
end
is_in___0 = fn__193
--@ compiler/read.luma:40:15
local fn__194 = function ()
--@ compiler/read.luma:40:36
return invoke (is_in___0, 1, " \9")
end
is_space___0 = fn__194
--@ compiler/read.luma:41:18
local fn__195 = function ()
--@ compiler/read.luma:41:32
local result__61 = char__0
if result__61 then
--@ compiler/read.luma:41:60
result__61 = invoke (not__0, 1, invoke (is_in___0, 1, "\
\9 :[]()'"))
end
return result__61
end
begins_word___0 = fn__195
--@ compiler/read.luma:42:21
local fn__196 = function ()
--@ compiler/read.luma:42:32
local result__62 = char__0
if result__62 then
--@ compiler/read.luma:42:61
result__62 = invoke (not__0, 1, invoke (is_in___0, 1, "\
\9 .:[]()'"))
end
return result__62
end
continues_word___0 = fn__196
--@ compiler/read.luma:43:20
local fn__197 = function ()
--@ compiler/read.luma:43:32
local result__63 = char__0
if result__63 then
--@ compiler/read.luma:43:54
result__63 = invoke (is_in___0, 1, "-0123456789")
end
return result__63
end
begins_number___0 = fn__197
--@ compiler/read.luma:44:23
local fn__198 = function ()
--@ compiler/read.luma:44:32
local result__64 = char__0
if result__64 then
--@ compiler/read.luma:44:60
result__64 = invoke (not__0, 1, invoke (is_in___0, 1, "\
\9 :[]()'"))
end
return result__64
end
continues_number___0 = fn__198
--@ compiler/read.luma:47:17
tokens__0 = invoke (_list__0, 0)
--@ compiler/read.luma:48:16
local fn__199 = function (param__278)
local list_result__46
local location__1
--@ compiler/read.luma:49:32
location__1 = invoke (current_location__0, 0)
--@ compiler/read.luma:50:44
invoke_symbol (tokens__0, ".push", 1, invoke (_token_node__0, 2, param__278, location__1))
--@ compiler/read.luma:51:13
list_result__46 = invoke (discard__0, 0)
--@ unknown
return list_result__46
end
emit__0 = fn__199
--@ compiler/read.luma:53:16
local fn__200 = function ()
--@ compiler/read.luma:54:9
local result__65
--@ compiler/read.luma:55:17
if invoke (is_space___0, 0) then
--@ compiler/read.luma:55:19
local list_result__47
--@ compiler/read.luma:56:17
invoke (advance__0, 0)
--@ compiler/read.luma:57:20
list_result__47 = invoke (skip_space__0, 0)
--@ unknown
result__65 = list_result__47
else
--@ compiler/read.luma:58:11
if else__0 then
--@ compiler/read.luma:59:17
result__65 = invoke (discard__0, 0)
else
result__65 = false
end
end
return result__65
end
skip_space__0 = fn__200
--@ compiler/read.luma:61:18
local fn__201 = function ()
local list_result__48
local depth__0
--@ compiler/read.luma:62:13
invoke (advance__0, 0)
--@ compiler/read.luma:63:13
depth__0 = 1
--@ compiler/read.luma:64:22
local while_condition__10 = invoke_symbol (depth__0, ".>", 1, 0)
while while_condition__10 do
--@ compiler/read.luma:64:24
local list_result__49
--@ compiler/read.luma:65:11
local result__66
--@ compiler/read.luma:66:22
if invoke (is_char___0, 1, "(") then
--@ compiler/read.luma:67:32
depth__0 = invoke_symbol (depth__0, ".+", 1, 1)
result__66 = true
else
--@ compiler/read.luma:68:22
if invoke (is_char___0, 1, ")") then
--@ compiler/read.luma:69:32
depth__0 = invoke_symbol (depth__0, ".-", 1, 1)
result__66 = true
else
result__66 = false
end
end
--@ compiler/read.luma:70:15
list_result__49 = invoke (advance__0, 0)
--@ unknown
local _ = list_result__49
--@ compiler/read.luma:64:22
while_condition__10 = invoke_symbol (depth__0, ".>", 1, 0)
end
--@ compiler/read.luma:71:13
list_result__48 = invoke (discard__0, 0)
--@ unknown
return list_result__48
end
skip_comment__0 = fn__201
--@ compiler/read.luma:73:29
local fn__202 = function ()
--@ compiler/read.luma:74:25
local result__67 = invoke (is_space___0, 0)
if not result__67 then
--@ compiler/read.luma:74:40
result__67 = invoke (is_char___0, 1, "(")
end
local while_condition__11 = result__67
while while_condition__11 do
--@ compiler/read.luma:74:43
local list_result__50
--@ compiler/read.luma:75:18
invoke (skip_space__0, 0)
--@ compiler/read.luma:76:11
local result__68
--@ compiler/read.luma:76:25
if invoke (is_char___0, 1, "(") then
--@ compiler/read.luma:77:22
result__68 = invoke (skip_comment__0, 0)
else
result__68 = false
end
list_result__50 = result__68
--@ unknown
local _ = list_result__50
--@ compiler/read.luma:74:25
local result__69 = invoke (is_space___0, 0)
if not result__69 then
--@ compiler/read.luma:74:40
result__69 = invoke (is_char___0, 1, "(")
end
while_condition__11 = result__69
end
return false
end
skip_space_and_comments__0 = fn__202
--@ compiler/read.luma:80:27
indent_levels__0 = invoke (_list__0, 1, -1)
--@ compiler/read.luma:81:17
paren_level__0 = 0
--@ compiler/read.luma:82:20
local fn__203 = function ()
--@ compiler/read.luma:82:34
return invoke_symbol (indent_levels__0, ".peek", 0)
end
current_indent__0 = fn__203
--@ compiler/read.luma:85:19
local fn__204 = function ()
local list_result__51
(function ()
local read_whitespace__0, indent__0
--@ compiler/read.luma:87:23
local fn__205 = function ()
--@ compiler/read.luma:88:11
local result__70
--@ compiler/read.luma:88:21
local result__71 = char__0
if result__71 then
--@ compiler/read.luma:88:32
result__71 = invoke (is_space___0, 0)
end
if result__71 then
--@ compiler/read.luma:88:35
local list_result__52
--@ compiler/read.luma:89:17
invoke (advance__0, 0)
--@ compiler/read.luma:90:25
list_result__52 = invoke (read_whitespace__0, 0)
--@ unknown
result__70 = list_result__52
else
result__70 = false
end
return result__70
end
read_whitespace__0 = fn__205
--@ compiler/read.luma:91:21
invoke (read_whitespace__0, 0)
--@ compiler/read.luma:92:26
indent__0 = invoke_symbol (invoke (pending_text__0, 0), ".length", 0)
--@ compiler/read.luma:93:13
invoke (discard__0, 0)
--@ compiler/read.luma:94:29
invoke (skip_space_and_comments__0, 0)
--@ compiler/read.luma:95:9
local result__72
--@ compiler/read.luma:96:21
if invoke (is_char___0, 1, "\
") then
--@ compiler/read.luma:96:23
local list_result__53
--@ compiler/read.luma:97:17
invoke (advance__0, 0)
--@ compiler/read.luma:98:17
invoke (discard__0, 0)
--@ compiler/read.luma:99:23
list_result__53 = invoke (read_new_line__0, 0)
--@ unknown
result__72 = list_result__53
else
--@ compiler/read.luma:100:16
local result__73 = char__0
if result__73 then
--@ compiler/read.luma:100:34
result__73 = invoke (____1, 2, paren_level__0, 0)
end
if result__73 then
--@ compiler/read.luma:100:37
local list_result__54
local unindent_loop__1
--@ compiler/read.luma:101:13
local result__74
--@ compiler/read.luma:101:40
if invoke (___5, 2, invoke (current_indent__0, 0), indent__0) then
--@ compiler/read.luma:101:42
local list_result__55
--@ compiler/read.luma:102:36
invoke_symbol (indent_levels__0, ".push", 1, indent__0)
--@ compiler/read.luma:103:26
list_result__55 = invoke (emit__0, 1, "[indent]")
--@ unknown
result__74 = list_result__55
else
result__74 = false
end
--@ compiler/read.luma:104:25
local fn__206 = function ()
--@ compiler/read.luma:105:15
local result__75
--@ compiler/read.luma:105:41
if invoke (___5, 2, indent__0, invoke (current_indent__0, 0)) then
--@ compiler/read.luma:105:44
local list_result__56
--@ compiler/read.luma:106:26
invoke_symbol (indent_levels__0, ".pop", 0)
--@ compiler/read.luma:107:30
invoke (emit__0, 1, "[unindent]")
--@ compiler/read.luma:108:27
list_result__56 = invoke (unindent_loop__1, 0)
--@ unknown
result__75 = list_result__56
else
result__75 = false
end
return result__75
end
unindent_loop__1 = fn__206
--@ compiler/read.luma:109:23
invoke (unindent_loop__1, 0)
--@ compiler/read.luma:110:22
list_result__54 = invoke (emit__0, 1, "[line]")
--@ unknown
result__72 = list_result__54
else
result__72 = false
end
end
list_result__51 = result__72
end)()
return list_result__51
end
read_new_line__0 = fn__204
--@ compiler/read.luma:112:15
local fn__207 = function ()
local list_result__57
--@ compiler/read.luma:113:13
invoke (advance__0, 0)
--@ compiler/read.luma:114:27
local while_condition__12 = invoke (continues_word___0, 0)
while while_condition__12 do
--@ compiler/read.luma:115:15
local _ = invoke (advance__0, 0)
--@ compiler/read.luma:114:27
while_condition__12 = invoke (continues_word___0, 0)
end
--@ compiler/read.luma:116:9
local result__76
--@ compiler/read.luma:116:28
local result__77 = invoke (is_char___0, 1, ".")
if result__77 then
--@ compiler/read.luma:116:42
result__77 = invoke (___4, 2, ".", invoke (peek__0, 0))
end
if result__77 then
--@ compiler/read.luma:116:46
local list_result__58
--@ compiler/read.luma:117:15
invoke (advance__0, 0)
--@ compiler/read.luma:118:15
list_result__58 = invoke (advance__0, 0)
--@ unknown
result__76 = list_result__58
else
result__76 = false
end
--@ compiler/read.luma:119:23
list_result__57 = invoke (emit__0, 1, invoke (pending_text__0, 0))
--@ unknown
return list_result__57
end
read_word__0 = fn__207
--@ compiler/read.luma:121:17
local fn__208 = function ()
local list_result__59
--@ compiler/read.luma:122:13
invoke (advance__0, 0)
--@ compiler/read.luma:123:29
local while_condition__13 = invoke (continues_number___0, 0)
while while_condition__13 do
--@ compiler/read.luma:124:15
local _ = invoke (advance__0, 0)
--@ compiler/read.luma:123:29
while_condition__13 = invoke (continues_number___0, 0)
end
--@ compiler/read.luma:125:23
invoke (emit__0, 1, invoke (pending_text__0, 0))
--@ compiler/read.luma:126:9
local result__78
--@ compiler/read.luma:126:26
if invoke (continues_word___0, 0) then
--@ compiler/read.luma:127:62
result__78 = invoke (error_at__0, 2, invoke (current_location__0, 0), "invalid text after number")
else
result__78 = false
end
list_result__59 = result__78
--@ unknown
return list_result__59
end
read_number__0 = fn__208
--@ compiler/read.luma:129:15
local fn__209 = function ()
local list_result__60
--@ compiler/read.luma:130:13
invoke (advance__0, 0)
--@ compiler/read.luma:131:9
local result__79
--@ compiler/read.luma:132:25
if invoke (continues_number___0, 0) then
--@ compiler/read.luma:132:40
result__79 = invoke (read_number__0, 0)
else
--@ compiler/read.luma:133:23
if invoke (continues_word___0, 0) then
--@ compiler/read.luma:133:38
result__79 = invoke (read_word__0, 0)
else
--@ compiler/read.luma:134:11
if else__0 then
--@ compiler/read.luma:134:46
result__79 = invoke (emit__0, 1, invoke (pending_text__0, 0))
else
result__79 = false
end
end
end
list_result__60 = result__79
--@ unknown
return list_result__60
end
read_dash__0 = fn__209
--@ compiler/read.luma:136:17
local fn__210 = function ()
local list_result__61
(function ()
local out__1, put__0, escaping__0
--@ compiler/read.luma:137:16
out__1 = invoke (_list__0, 0)
--@ compiler/read.luma:138:15
local fn__211 = function (param__279)
local list_result__62
--@ compiler/read.luma:139:11
local result__80
--@ compiler/read.luma:139:31
if invoke (not__0, 1, invoke_symbol (_string__0, ".?", 1, param__279)) then
--@ compiler/read.luma:140:77
result__80 = invoke (error_at__0, 2, invoke (current_location__0, 0), "tried to put non-string in read-string")
else
result__80 = false
end
--@ compiler/read.luma:141:19
list_result__62 = invoke_symbol (out__1, ".push", 1, param__279)
--@ unknown
return list_result__62
end
put__0 = fn__211
--@ compiler/read.luma:143:13
invoke (advance__0, 0)
--@ compiler/read.luma:144:13
invoke (put__0, 1, "'")
--@ compiler/read.luma:145:20
escaping__0 = false
--@ compiler/read.luma:147:23
local result__81 = escaping__0
if not result__81 then
--@ compiler/read.luma:147:43
result__81 = invoke (not__0, 1, invoke (is_char___0, 1, "'"))
end
local while_condition__14 = result__81
while while_condition__14 do
--@ compiler/read.luma:147:47
local list_result__63
--@ compiler/read.luma:148:11
local result__82
--@ compiler/read.luma:149:17
if escaping__0 then
--@ compiler/read.luma:149:18
local list_result__64
--@ compiler/read.luma:150:15
local result__83
--@ compiler/read.luma:150:29
if invoke (is_char___0, 1, "n") then
--@ compiler/read.luma:150:41
result__83 = invoke (put__0, 1, "\
")
else
--@ compiler/read.luma:151:29
if invoke (is_char___0, 1, "t") then
--@ compiler/read.luma:151:41
result__83 = invoke (put__0, 1, "\9")
else
--@ compiler/read.luma:152:20
if else__0 then
--@ compiler/read.luma:152:41
result__83 = invoke (put__0, 1, char__0)
else
result__83 = false
end
end
end
--@ compiler/read.luma:153:29
escaping__0 = false
list_result__64 = true
--@ unknown
result__82 = list_result__64
else
--@ compiler/read.luma:154:13
if else__0 then
--@ compiler/read.luma:155:15
local result__84
--@ compiler/read.luma:156:27
if invoke (is_char___0, 1, "\\") then
--@ compiler/read.luma:156:47
escaping__0 = true
result__84 = true
else
--@ compiler/read.luma:157:17
if else__0 then
--@ compiler/read.luma:157:38
result__84 = invoke (put__0, 1, char__0)
else
result__84 = false
end
end
result__82 = result__84
else
result__82 = false
end
end
--@ compiler/read.luma:158:15
list_result__63 = invoke (advance__0, 0)
--@ unknown
local _ = list_result__63
--@ compiler/read.luma:147:23
local result__85 = escaping__0
if not result__85 then
--@ compiler/read.luma:147:43
result__85 = invoke (not__0, 1, invoke (is_char___0, 1, "'"))
end
while_condition__14 = result__85
end
--@ compiler/read.luma:160:13
invoke (advance__0, 0)
--@ compiler/read.luma:161:13
invoke (put__0, 1, "'")
--@ compiler/read.luma:162:13
list_result__61 = invoke (emit__0, 1, invoke_symbol (out__1, ".concat", 0))
--@ unknown
end)()
return list_result__61
end
read_string__0 = fn__210
--@ compiler/read.luma:164:16
local fn__212 = function ()
local list_result__65
--@ compiler/read.luma:165:16
invoke (skip_space__0, 0)
--@ compiler/read.luma:166:9
local result__86
--@ compiler/read.luma:167:20
if invoke (is_char___0, 1, "-") then
--@ compiler/read.luma:167:36
result__86 = invoke (read_dash__0, 0)
else
--@ compiler/read.luma:168:22
if invoke (begins_number___0, 0) then
--@ compiler/read.luma:168:38
result__86 = invoke (read_number__0, 0)
else
--@ compiler/read.luma:169:20
if invoke (begins_word___0, 0) then
--@ compiler/read.luma:169:36
result__86 = invoke (read_word__0, 0)
else
--@ compiler/read.luma:170:21
if invoke (is_char___0, 1, "'") then
--@ compiler/read.luma:170:38
result__86 = invoke (read_string__0, 0)
else
--@ compiler/read.luma:171:20
if invoke (is_char___0, 1, "(") then
--@ compiler/read.luma:171:39
result__86 = invoke (skip_comment__0, 0)
else
--@ compiler/read.luma:172:20
if invoke (is_char___0, 1, "[") then
--@ compiler/read.luma:172:22
local list_result__66
--@ compiler/read.luma:173:17
invoke (advance__0, 0)
--@ compiler/read.luma:174:41
paren_level__0 = invoke (___0, 2, paren_level__0, 1)
--@ compiler/read.luma:175:27
list_result__66 = invoke (emit__0, 1, invoke (pending_text__0, 0))
--@ unknown
result__86 = list_result__66
else
--@ compiler/read.luma:176:20
if invoke (is_char___0, 1, "]") then
--@ compiler/read.luma:176:22
local list_result__67
--@ compiler/read.luma:177:17
invoke (advance__0, 0)
--@ compiler/read.luma:178:41
paren_level__0 = invoke (___1, 2, paren_level__0, 1)
--@ compiler/read.luma:179:27
list_result__67 = invoke (emit__0, 1, invoke (pending_text__0, 0))
--@ unknown
result__86 = list_result__67
else
--@ compiler/read.luma:180:20
if invoke (is_char___0, 1, ":") then
--@ compiler/read.luma:180:22
local list_result__68
--@ compiler/read.luma:181:17
invoke (advance__0, 0)
--@ compiler/read.luma:182:27
list_result__68 = invoke (emit__0, 1, invoke (pending_text__0, 0))
--@ unknown
result__86 = list_result__68
else
--@ compiler/read.luma:183:21
if invoke (is_char___0, 1, "\
") then
--@ compiler/read.luma:183:23
local list_result__69
--@ compiler/read.luma:184:17
invoke (advance__0, 0)
--@ compiler/read.luma:185:17
invoke (discard__0, 0)
--@ compiler/read.luma:186:23
list_result__69 = invoke (read_new_line__0, 0)
--@ unknown
result__86 = list_result__69
else
--@ compiler/read.luma:187:11
if else__0 then
--@ compiler/read.luma:188:80
result__86 = invoke (error_at__0, 2, invoke (current_location__0, 0), invoke (combine_strings__0, 2, "unknown character: ", invoke_symbol (char__0, ".to-string", 0)))
else
result__86 = false
end
end
end
end
end
end
end
end
end
end
list_result__65 = result__86
--@ unknown
return list_result__65
end
read_token__0 = fn__212
--@ compiler/read.luma:190:17
invoke (read_new_line__0, 0)
--@ compiler/read.luma:191:14
invoke (skip_space__0, 0)
--@ compiler/read.luma:193:13
local while_condition__15 = char__0
while while_condition__15 do
--@ compiler/read.luma:193:14
local list_result__70
--@ compiler/read.luma:194:16
invoke (read_token__0, 0)
--@ compiler/read.luma:195:16
list_result__70 = invoke (skip_space__0, 0)
--@ unknown
local _ = list_result__70
--@ compiler/read.luma:193:13
while_condition__15 = char__0
end
--@ compiler/read.luma:197:19
local fn__213 = function ()
--@ compiler/read.luma:198:9
local result__87
--@ compiler/read.luma:198:29
if invoke_symbol (1, ".<", 1, invoke_symbol (indent_levels__0, ".length", 0)) then
--@ compiler/read.luma:198:38
local list_result__71
--@ compiler/read.luma:199:24
invoke (emit__0, 1, "[unindent]")
--@ compiler/read.luma:200:20
invoke_symbol (indent_levels__0, ".pop", 0)
--@ compiler/read.luma:201:21
list_result__71 = invoke (unindent_loop__0, 0)
--@ unknown
result__87 = list_result__71
else
result__87 = false
end
return result__87
end
unindent_loop__0 = fn__213
--@ compiler/read.luma:202:17
invoke (unindent_loop__0, 0)
--@ compiler/read.luma:204:9
list_result__43 = tokens__0
--@ unknown
end)()
return list_result__43
end
read__1 = fn__186
--@ compiler/read.luma:206:2
local table__56
--@ compiler/read.luma:207:14
table__56 = {
[".read"] = read__1,
}
--@ unknown
list_result__42 = table__56
_modules_compiler_read__0 = list_result__42
read__0 = invoke_symbol (_modules_compiler_read__0, ".read", 0)
local list_result__72
local _context__1
--@ compiler/context.luma:1:12
local table__57
local fn__214 = function (param__280)
--@ compiler/context.luma:2:28
local result__88 = type (param__280) == "table" and (param__280.index == _context__1 or param__280[_context__1] ~= nil)
return result__88
end
local fn__215 = function ()
--@ compiler/context.luma:3:22
return invoke (_context__1, 1, false)
end
local fn__216 = function (param__281)
--@ compiler/context.luma:4:16
local table__58
--@ compiler/context.luma:7:20
table__58 = {
["index"] = _context__1,
[".parent"] = param__281,
[".scope"] = invoke (_table__0, 0),
}
--@ unknown
return table__58
end
local fn__217 = function (param__282, param__283, param__284)
--@ compiler/context.luma:9:24
local list_result__73
--@ compiler/context.luma:10:52
local assert_result__8 = assert(invoke_symbol (_string__0, ".?", 1, param__283), "expected string as key")
--@ compiler/context.luma:11:68
local assert_result__9 = assert(invoke (not__0, 1, invoke_symbol (invoke_symbol (param__282, ".scope", 0), ".has?", 1, param__283)), "duplicate entry in context")
--@ compiler/context.luma:12:29
list_result__73 = invoke_symbol (invoke_symbol (param__282, ".scope", 0), ".set", 2, param__283, param__284)
--@ unknown
return list_result__73
end
local fn__218 = function (param__285, param__286, param__287)
--@ compiler/context.luma:14:30
local list_result__74
local result__89
--@ compiler/context.luma:15:41
result__89 = invoke_symbol (param__285, ".lookup-recursively", 1, param__286)
--@ compiler/context.luma:16:9
local result__90
--@ compiler/context.luma:16:21
if invoke (not__0, 1, result__89) then
--@ compiler/context.luma:17:85
result__90 = invoke (error_at__0, 2, invoke (_word_node__0, 2, param__286, param__287), invoke (combine_strings__0, 2, "missing in context: ", param__286))
else
result__90 = false
end
--@ compiler/context.luma:18:11
list_result__74 = result__89
--@ unknown
return list_result__74
end
local fn__219 = function (param__288, param__289)
--@ compiler/context.luma:21:42
return invoke (not__0, 1, invoke (not__0, 1, invoke_symbol (param__288, ".lookup-recursively", 1, param__289)))
end
local fn__220 = function (param__290, param__291)
--@ compiler/context.luma:24:36
local result__91 = invoke_symbol (invoke_symbol (param__290, ".scope", 0), ".get-or", 2, param__291, false)
if not result__91 then
--@ compiler/context.luma:25:16
local result__92 = invoke_symbol (param__290, ".parent", 0)
if result__92 then
--@ compiler/context.luma:25:59
result__92 = invoke_symbol (invoke_symbol (param__290, ".parent", 0), ".lookup-recursively", 1, param__291)
end
result__91 = result__92
end
return result__91
end
table__57 = {
functions = {
[".?"] = fn__214,
[0] = fn__215,
[1] = fn__216,
},
methods = {
[".add"] = fn__217,
[".lookup"] = fn__218,
[".has?"] = fn__219,
[".lookup-recursively"] = fn__220,
},
}
--@ unknown
_context__1 = table__57
--@ compiler/context.luma:27:2
local table__59
--@ compiler/context.luma:28:22
table__59 = {
[".#context"] = _context__1,
}
--@ unknown
list_result__72 = table__59
_modules_compiler_context__0 = list_result__72
_context__0 = invoke_symbol (_modules_compiler_context__0, ".#context", 0)
local list_result__75
(function ()
local make_list__0, make_pair__0, is_word_symbol___0, parse__1
--@ compiler/parse.luma:21:28
local fn__221 = function (param__292, param__293)
local list_result__76
local apply_items__0
--@ compiler/parse.luma:22:38
apply_items__0 = invoke (_list__0, 1, invoke (_word_node__0, 1, "!"))
--@ compiler/parse.luma:23:31
invoke_symbol (apply_items__0, ".push-items", 1, param__292)
--@ compiler/parse.luma:24:35
list_result__76 = invoke (_apply_node__0, 2, apply_items__0, param__293)
--@ unknown
return list_result__76
end
make_list__0 = fn__221
--@ compiler/parse.luma:26:26
local fn__222 = function (param__294, param__295, param__296)
--@ compiler/parse.luma:27:52
return invoke (_apply_node__0, 2, invoke (_list__0, 3, invoke (_word_node__0, 1, ":"), param__294, param__295), param__296)
end
make_pair__0 = fn__222
--@ compiler/parse.luma:29:24
local fn__223 = function (param__297)
--@ compiler/parse.luma:30:25
local result__93 = invoke_symbol (_word_node__0, ".?", 1, param__297)
if result__93 then
--@ compiler/parse.luma:30:56
result__93 = invoke (___4, 2, ".", invoke_symbol (invoke_symbol (param__297, ".id", 0), ".substring", 2, 0, 1))
end
return result__93
end
is_word_symbol___0 = fn__223
--@ compiler/parse.luma:32:20
local fn__224 = function (param__298)
local list_result__77
(function ()
local token_index__0, current__0, current_location__1, is_token___0, is_symbol___0, check_is__0, next__0, starts_expr__0, rules__0
--@ compiler/parse.luma:33:17
token_index__0 = 0
--@ compiler/parse.luma:35:13
local fn__225 = function ()
--@ compiler/parse.luma:36:34
local result__94
if invoke_symbol (token_index__0, ".<", 1, invoke_symbol (param__298, ".length", 0)) then
--@ compiler/parse.luma:37:33
result__94 = invoke_symbol (param__298, ".get", 1, token_index__0)
else
--@ compiler/parse.luma:38:12
result__94 = false
end
return result__94
end
current__0 = fn__225
--@ compiler/parse.luma:40:22
local fn__226 = function ()
local list_result__78
local t__0
--@ compiler/parse.luma:41:16
t__0 = invoke (current__0, 0)
--@ compiler/parse.luma:42:9
local result__95
if t__0 then
--@ compiler/parse.luma:43:8
result__95 = invoke_symbol (t__0, ".location", 0)
else
--@ compiler/parse.luma:44:16
result__95 = invoke_symbol (_location__0, ".unknown", 0)
end
list_result__78 = result__95
--@ unknown
return list_result__78
end
current_location__1 = fn__226
--@ compiler/parse.luma:46:17
local fn__227 = function (param__299)
--@ compiler/parse.luma:47:17
local result__96 = invoke (current__0, 0)
if result__96 then
--@ compiler/parse.luma:47:36
result__96 = invoke (___4, 2, invoke_symbol (invoke (current__0, 0), ".id", 0), param__299)
end
return result__96
end
is_token___0 = fn__227
--@ compiler/parse.luma:49:16
local fn__228 = function ()
--@ compiler/parse.luma:50:32
local result__97 = invoke_symbol (_token_node__0, ".?", 1, invoke (current__0, 0))
if result__97 then
--@ compiler/parse.luma:50:69
result__97 = invoke (___4, 2, ".", invoke_symbol (invoke_symbol (invoke (current__0, 0), ".id", 0), ".substring", 2, 0, 1))
end
return result__97
end
is_symbol___0 = fn__228
--@ compiler/parse.luma:52:16
local fn__229 = function (param__300)
--@ compiler/parse.luma:53:9
local result__98
--@ compiler/parse.luma:53:27
if invoke (not__0, 1, invoke (is_token___0, 1, param__300)) then
--@ compiler/parse.luma:55:89
local _value_to_string_result__2 = tostring(invoke_symbol (invoke (current__0, 0), ".id", 0))
--@ compiler/parse.luma:55:122
local assert_result__10 = assert(false, invoke (combine_strings__0, 6, "expected '", param__300, "', got '", invoke (_string__0, 1, _value_to_string_result__2), "' at ", invoke_symbol (invoke (current_location__1, 0), ".to-string", 0)))
result__98 = assert_result__10
else
result__98 = false
end
return result__98
end
check_is__0 = fn__229
--@ compiler/parse.luma:57:10
local table__60
local fn__230 = function (param__301)
--@ compiler/parse.luma:58:11
local list_result__79
--@ compiler/parse.luma:59:17
invoke (check_is__0, 1, param__301)
--@ compiler/parse.luma:60:12
list_result__79 = invoke (next__0, 0)
--@ unknown
return list_result__79
end
local fn__231 = function ()
--@ compiler/parse.luma:61:9
local list_result__80
--@ compiler/parse.luma:62:51
local assert_result__11 = assert(invoke (current__0, 0), "tried to advance past end")
--@ compiler/parse.luma:63:40
token_index__0 = invoke_symbol (1, ".+", 1, token_index__0)
list_result__80 = true
--@ unknown
return list_result__80
end
table__60 = {
functions = {
[1] = fn__230,
[0] = fn__231,
},
}
next__0 = table__60
--@ compiler/parse.luma:65:17
local fn__232 = function ()
--@ compiler/parse.luma:66:9
local result__99
--@ compiler/parse.luma:67:30
if invoke (is_token___0, 1, "[unindent]") then
--@ compiler/parse.luma:67:38
result__99 = false
else
--@ compiler/parse.luma:68:26
if invoke (is_token___0, 1, "[line]") then
--@ compiler/parse.luma:68:38
result__99 = false
else
--@ compiler/parse.luma:69:28
if invoke (is_token___0, 1, "[indent]") then
--@ compiler/parse.luma:69:38
result__99 = false
else
--@ compiler/parse.luma:70:21
if invoke (is_token___0, 1, ":") then
--@ compiler/parse.luma:70:38
result__99 = false
else
--@ compiler/parse.luma:71:21
if invoke (is_token___0, 1, "]") then
--@ compiler/parse.luma:71:38
result__99 = false
else
--@ compiler/parse.luma:72:23
if invoke (is_token___0, 1, false) then
--@ compiler/parse.luma:72:38
result__99 = false
else
--@ compiler/parse.luma:73:11
if else__0 then
--@ compiler/parse.luma:73:37
result__99 = true
else
result__99 = false
end
end
end
end
end
end
end
return result__99
end
starts_expr__0 = fn__232
--@ compiler/parse.luma:75:11
local table__61
local fn__233 = function ()
--@ compiler/parse.luma:77:45
return invoke (make_list__0, 2, invoke_symbol (rules__0, ".body", 0), invoke (current_location__1, 0))
end
local fn__234 = function ()
--@ compiler/parse.luma:79:15
local list_result__81
local items__0
--@ compiler/parse.luma:80:20
items__0 = invoke (_list__0, 0)
--@ compiler/parse.luma:81:22
invoke (next__0, 1, "[indent]")
--@ compiler/parse.luma:82:46
local result__100 = invoke (not__0, 1, invoke (is_token___0, 1, "[unindent]"))
if result__100 then
--@ compiler/parse.luma:82:70
result__100 = invoke (not__0, 1, invoke (is_token___0, 1, false))
end
local while_condition__16 = result__100
while while_condition__16 do
--@ compiler/parse.luma:82:74
local list_result__82
--@ compiler/parse.luma:83:22
invoke (next__0, 1, "[line]")
--@ compiler/parse.luma:84:25
list_result__82 = invoke_symbol (items__0, ".push", 1, invoke_symbol (rules__0, ".line", 0))
--@ unknown
local _ = list_result__82
--@ compiler/parse.luma:82:46
local result__101 = invoke (not__0, 1, invoke (is_token___0, 1, "[unindent]"))
if result__101 then
--@ compiler/parse.luma:82:70
result__101 = invoke (not__0, 1, invoke (is_token___0, 1, false))
end
while_condition__16 = result__101
end
--@ compiler/parse.luma:85:24
invoke (next__0, 1, "[unindent]")
--@ compiler/parse.luma:86:12
list_result__81 = items__0
--@ unknown
return list_result__81
end
local fn__235 = function ()
--@ compiler/parse.luma:88:15
local list_result__83
local items__1
--@ compiler/parse.luma:89:26
items__1 = invoke (_list__0, 1, invoke_symbol (rules__0, ".first-expr", 0))
--@ compiler/parse.luma:90:29
invoke_symbol (items__1, ".push-items", 1, invoke_symbol (rules__0, ".rest", 0))
--@ compiler/parse.luma:91:20
local result__102
if invoke (___4, 2, 1, invoke_symbol (items__1, ".length", 0)) then
--@ compiler/parse.luma:92:20
result__102 = invoke_symbol (items__1, ".get", 1, 0)
else
--@ compiler/parse.luma:93:39
result__102 = invoke (_apply_node__0, 2, items__1, invoke_symbol (invoke_symbol (items__1, ".get", 1, 0), ".location", 0))
end
list_result__83 = result__102
--@ unknown
return list_result__83
end
local fn__236 = function ()
--@ compiler/parse.luma:95:15
local list_result__84
local items__2
--@ compiler/parse.luma:96:20
items__2 = invoke (_list__0, 0)
--@ compiler/parse.luma:97:25
local while_condition__17 = invoke (starts_expr__0, 0)
while while_condition__17 do
--@ compiler/parse.luma:98:25
local _ = invoke_symbol (items__2, ".push", 1, invoke_symbol (rules__0, ".rest-expr", 0))
--@ compiler/parse.luma:97:25
while_condition__17 = invoke (starts_expr__0, 0)
end
--@ compiler/parse.luma:99:11
local result__103
--@ compiler/parse.luma:99:33
if invoke (is_token___0, 1, "[indent]") then
--@ compiler/parse.luma:100:40
local fn__237 = function (param__302)
--@ compiler/parse.luma:100:54
return invoke_symbol (items__2, ".push", 1, param__302)
end
result__103 = invoke_symbol (invoke_symbol (invoke_symbol (rules__0, ".body", 0), ".iterator", 0), ".each", 1, fn__237)
else
result__103 = false
end
--@ compiler/parse.luma:101:12
list_result__84 = items__2
--@ unknown
return list_result__84
end
local fn__238 = function (param__303, param__304, param__305)
--@ compiler/parse.luma:104:11
local result__104
--@ compiler/parse.luma:105:30
if invoke (is_token___0, 1, "[indent]") then
--@ compiler/parse.luma:105:32
local list_result__85
local body__0
--@ compiler/parse.luma:106:22
body__0 = invoke_symbol (rules__0, ".body", 0)
--@ compiler/parse.luma:107:23
local result__105
if invoke (___4, 2, 1, invoke_symbol (body__0, ".length", 0)) then
--@ compiler/parse.luma:108:49
result__105 = invoke (make_pair__0, 3, param__303, invoke_symbol (body__0, ".get", 1, 0), param__304)
else
--@ compiler/parse.luma:109:62
result__105 = invoke (make_pair__0, 3, param__303, invoke (make_list__0, 2, body__0, param__304), param__304)
end
list_result__85 = result__105
--@ unknown
result__104 = list_result__85
else
--@ compiler/parse.luma:110:13
if else__0 then
--@ compiler/parse.luma:111:51
result__104 = invoke (make_pair__0, 3, param__303, invoke (param__305, 0), param__304)
else
result__104 = false
end
end
return result__104
end
local fn__239 = function ()
--@ compiler/parse.luma:114:21
local list_result__86
local expr__0
--@ compiler/parse.luma:115:18
expr__0 = invoke_symbol (rules__0, ".expr", 0)
--@ compiler/parse.luma:116:11
local result__106
--@ compiler/parse.luma:117:40
local result__107 = invoke (not__0, 1, invoke (is_word_symbol___0, 1, expr__0))
if result__107 then
--@ compiler/parse.luma:117:54
result__107 = invoke (is_symbol___0, 0)
end
if result__107 then
--@ compiler/parse.luma:117:57
local list_result__87
--@ compiler/parse.luma:118:28
local while_condition__18 = invoke (is_symbol___0, 0)
while while_condition__18 do
--@ compiler/parse.luma:119:76
expr__0 = invoke (_apply_node__0, 2, invoke (_list__0, 2, expr__0, invoke_symbol (rules__0, ".word", 0)), invoke (current_location__1, 0))
local _ = true
--@ compiler/parse.luma:118:28
while_condition__18 = invoke (is_symbol___0, 0)
end
--@ compiler/parse.luma:120:19
expr__0 [".items"] = invoke_symbol (_list__0, ".append", 2, invoke_symbol (expr__0, ".items", 0), invoke_symbol (rules__0, ".rest", 0))
list_result__87 = true
--@ unknown
result__106 = list_result__87
else
result__106 = false
end
--@ compiler/parse.luma:121:11
local result__108
--@ compiler/parse.luma:122:23
if invoke (is_token___0, 1, ":") then
--@ compiler/parse.luma:122:25
local list_result__88
local location__2
--@ compiler/parse.luma:123:38
location__2 = invoke (current_location__1, 0)
--@ compiler/parse.luma:124:16
invoke (next__0, 0)
--@ compiler/parse.luma:125:56
local fn__240 = function ()
--@ compiler/parse.luma:125:63
return invoke_symbol (rules__0, ".line", 0)
end
expr__0 = invoke_symbol (rules__0, ".pair-value", 3, expr__0, location__2, fn__240)
list_result__88 = true
--@ unknown
result__108 = list_result__88
else
result__108 = false
end
--@ compiler/parse.luma:126:11
list_result__86 = expr__0
--@ unknown
return list_result__86
end
local fn__241 = function ()
--@ compiler/parse.luma:128:20
local list_result__89
local expr__1
--@ compiler/parse.luma:129:18
expr__1 = invoke_symbol (rules__0, ".expr", 0)
--@ compiler/parse.luma:130:11
local result__109
--@ compiler/parse.luma:131:40
local result__110 = invoke (not__0, 1, invoke (is_word_symbol___0, 1, expr__1))
if result__110 then
--@ compiler/parse.luma:131:54
result__110 = invoke (is_symbol___0, 0)
end
if result__110 then
--@ compiler/parse.luma:132:28
local while_condition__19 = invoke (is_symbol___0, 0)
while while_condition__19 do
--@ compiler/parse.luma:133:76
expr__1 = invoke (_apply_node__0, 2, invoke (_list__0, 2, expr__1, invoke_symbol (rules__0, ".word", 0)), invoke (current_location__1, 0))
local _ = true
--@ compiler/parse.luma:132:28
while_condition__19 = invoke (is_symbol___0, 0)
end
result__109 = false
else
result__109 = false
end
--@ compiler/parse.luma:134:11
local result__111
--@ compiler/parse.luma:135:23
if invoke (is_token___0, 1, ":") then
--@ compiler/parse.luma:135:25
local list_result__90
local location__3
--@ compiler/parse.luma:136:38
location__3 = invoke (current_location__1, 0)
--@ compiler/parse.luma:137:16
invoke (next__0, 0)
--@ compiler/parse.luma:138:56
local fn__242 = function ()
--@ compiler/parse.luma:138:63
return invoke_symbol (rules__0, ".rest-expr", 0)
end
expr__1 = invoke_symbol (rules__0, ".pair-value", 3, expr__1, location__3, fn__242)
list_result__90 = true
--@ unknown
result__111 = list_result__90
else
result__111 = false
end
--@ compiler/parse.luma:139:11
list_result__89 = expr__1
--@ unknown
return list_result__89
end
local fn__243 = function ()
--@ compiler/parse.luma:142:11
local result__112
--@ compiler/parse.luma:143:23
if invoke (is_token___0, 1, "[") then
--@ compiler/parse.luma:143:25
local list_result__91
(function ()
local do_wrap___0, expr__2, rest__0
--@ compiler/parse.luma:144:16
invoke (next__0, 0)
--@ compiler/parse.luma:145:25
do_wrap___0 = true
--@ compiler/parse.luma:146:22
expr__2 = invoke_symbol (rules__0, ".expr", 0)
--@ compiler/parse.luma:147:15
local result__113
--@ compiler/parse.luma:147:47
local result__114 = invoke (not__0, 1, invoke (is_word_symbol___0, 1, expr__2))
if result__114 then
--@ compiler/parse.luma:147:61
result__114 = invoke (is_symbol___0, 0)
end
if result__114 then
--@ compiler/parse.luma:147:64
local list_result__92
--@ compiler/parse.luma:148:30
local while_condition__20 = invoke (is_symbol___0, 0)
while while_condition__20 do
--@ compiler/parse.luma:148:32
local list_result__93
--@ compiler/parse.luma:149:78
expr__2 = invoke (_apply_node__0, 2, invoke (_list__0, 2, expr__2, invoke_symbol (rules__0, ".word", 0)), invoke (current_location__1, 0))
--@ compiler/parse.luma:150:33
do_wrap___0 = false
list_result__93 = true
--@ unknown
local _ = list_result__93
--@ compiler/parse.luma:148:30
while_condition__20 = invoke (is_symbol___0, 0)
end
--@ compiler/parse.luma:151:21
expr__2 [".items"] = invoke_symbol (_list__0, ".append", 2, invoke_symbol (expr__2, ".items", 0), invoke_symbol (rules__0, ".rest", 0))
list_result__92 = true
--@ unknown
result__113 = list_result__92
else
result__113 = false
end
--@ compiler/parse.luma:152:22
rest__0 = invoke_symbol (rules__0, ".rest", 0)
--@ compiler/parse.luma:153:19
invoke (next__0, 1, "]")
--@ compiler/parse.luma:154:26
local result__115 = do_wrap___0
if not result__115 then
--@ compiler/parse.luma:154:44
result__115 = invoke_symbol (invoke_symbol (rest__0, ".length", 0), ".>", 1, 0)
end
local result__116
if result__115 then
--@ compiler/parse.luma:155:62
result__116 = invoke (_apply_node__0, 2, invoke_symbol (_list__0, ".append", 2, invoke (_list__0, 1, expr__2), rest__0), invoke_symbol (expr__2, ".location", 0))
else
--@ compiler/parse.luma:156:17
result__116 = expr__2
end
list_result__91 = result__116
--@ unknown
end)()
result__112 = list_result__91
else
--@ compiler/parse.luma:158:13
if else__0 then
--@ compiler/parse.luma:159:16
result__112 = invoke_symbol (rules__0, ".word", 0)
else
result__112 = false
end
end
return result__112
end
local fn__244 = function ()
--@ compiler/parse.luma:161:15
local list_result__94
local token__0, location__4
--@ compiler/parse.luma:163:22
token__0 = invoke (current__0, 0)
--@ compiler/parse.luma:164:34
location__4 = invoke (current_location__1, 0)
--@ compiler/parse.luma:165:12
invoke (next__0, 0)
--@ compiler/parse.luma:166:35
list_result__94 = invoke (_word_node__0, 2, invoke_symbol (token__0, ".id", 0), location__4)
--@ unknown
return list_result__94
end
table__61 = {
functions = {
[".root"] = fn__233,
[".body"] = fn__234,
[".line"] = fn__235,
[".rest"] = fn__236,
[".pair-value"] = fn__238,
[".first-expr"] = fn__239,
[".rest-expr"] = fn__241,
[".expr"] = fn__243,
[".word"] = fn__244,
},
}
rules__0 = table__61
--@ compiler/parse.luma:169:8
list_result__77 = invoke_symbol (rules__0, ".root", 0)
--@ unknown
end)()
return list_result__77
end
parse__1 = fn__224
--@ compiler/parse.luma:171:2
local table__62
--@ compiler/parse.luma:172:16
table__62 = {
[".parse"] = parse__1,
}
--@ unknown
list_result__75 = table__62
end)()
_modules_compiler_parse__0 = list_result__75
parse__0 = invoke_symbol (_modules_compiler_parse__0, ".parse", 0)
local list_result__95
(function ()
local is_word___0, is_anon_key___0, words__ids__0, process_symbol_function_or_method__0, process_plain_function__0, process_pair__0, process_pairs__0, resolve__1
--@ compiler/resolve.luma:1:22
local fn__245 = function (param__306, param__307)
--@ compiler/resolve.luma:2:25
local result__117 = invoke_symbol (_word_node__0, ".?", 1, param__306)
if result__117 then
--@ compiler/resolve.luma:2:42
result__117 = invoke (___4, 2, invoke_symbol (param__306, ".id", 0), param__307)
end
return result__117
end
is_word___0 = fn__245
--@ compiler/resolve.luma:4:21
local fn__246 = function (param__308)
--@ compiler/resolve.luma:5:7
local result__118
--@ compiler/resolve.luma:6:29
if invoke (not__0, 1, invoke_symbol (_apply_node__0, ".?", 1, param__308)) then
--@ compiler/resolve.luma:6:38
result__118 = false
else
--@ compiler/resolve.luma:7:28
if invoke_symbol (invoke_symbol (invoke_symbol (param__308, ".items", 0), ".length", 0), ".=", 1, 0) then
--@ compiler/resolve.luma:7:36
result__118 = false
else
--@ compiler/resolve.luma:8:43
local result__119 = invoke_symbol (_symbol_node__0, ".?", 1, invoke_symbol (invoke_symbol (param__308, ".items", 0), ".get", 1, 0))
if result__119 then
--@ compiler/resolve.luma:9:38
result__119 = invoke (___4, 2, invoke_symbol (invoke_symbol (invoke_symbol (param__308, ".items", 0), ".get", 1, 0), ".id", 0), ".")
end
if result__119 then
--@ compiler/resolve.luma:10:11
local result__120
--@ compiler/resolve.luma:11:32
if invoke_symbol (invoke_symbol (invoke_symbol (param__308, ".items", 0), ".length", 0), ".=", 1, 1) then
--@ compiler/resolve.luma:11:39
result__120 = true
else
--@ compiler/resolve.luma:12:42
if invoke_symbol (_symbol_node__0, ".?", 1, invoke_symbol (invoke_symbol (param__308, ".items", 0), ".get", 1, 1)) then
--@ compiler/resolve.luma:12:51
result__120 = false
else
--@ compiler/resolve.luma:13:13
if else__0 then
--@ compiler/resolve.luma:13:19
result__120 = true
else
result__120 = false
end
end
end
result__118 = result__120
else
--@ compiler/resolve.luma:14:9
if else__0 then
--@ compiler/resolve.luma:14:16
result__118 = false
else
result__118 = false
end
end
end
end
return result__118
end
is_anon_key___0 = fn__246
--@ compiler/resolve.luma:16:20
local fn__247 = function (param__309)
--@ compiler/resolve.luma:17:19
local fn__248 = function (param__310)
--@ compiler/resolve.luma:17:22
return invoke_symbol (param__310, ".id", 0)
end
return invoke_symbol (param__309, ".map", 1, fn__248)
end
words__ids__0 = fn__247
--@ compiler/resolve.luma:19:41
local fn__249 = function (param__311)
local list_result__96
local signature__0, first__1, symbol__0, args__0
--@ compiler/resolve.luma:20:17
signature__0 = invoke_symbol (param__311, ".key", 0)
--@ compiler/resolve.luma:21:31
first__1 = invoke_symbol (invoke_symbol (signature__0, ".items", 0), ".get", 1, 0)
--@ compiler/resolve.luma:22:32
symbol__0 = invoke_symbol (invoke_symbol (signature__0, ".items", 0), ".get", 1, 1)
--@ compiler/resolve.luma:23:31
args__0 = invoke_symbol (invoke_symbol (signature__0, ".items", 0), ".drop", 1, 2)
--@ compiler/resolve.luma:24:7
local result__121
--@ compiler/resolve.luma:25:26
if invoke_symbol (_symbol_node__0, ".?", 1, first__1) then
--@ compiler/resolve.luma:25:28
local list_result__97
--@ compiler/resolve.luma:26:96
invoke (assert_at__0, 3, invoke (___4, 2, ".", invoke_symbol (first__1, ".id", 0)), first__1, "invalid symbol in first position of function signature")
--@ compiler/resolve.luma:27:70
list_result__97 = invoke (_symbol_function_node__0, 4, invoke_symbol (symbol__0, ".id", 0), invoke (words__ids__0, 1, args__0), invoke_symbol (param__311, ".value", 0), invoke_symbol (param__311, ".location", 0))
--@ unknown
result__121 = list_result__97
else
--@ compiler/resolve.luma:28:9
if else__0 then
--@ compiler/resolve.luma:28:10
local list_result__98
--@ compiler/resolve.luma:29:64
invoke (assert_at__0, 3, invoke_symbol (_word_node__0, ".?", 1, first__1), first__1, "expected word node")
--@ compiler/resolve.luma:30:97
list_result__98 = invoke (_symbol_method_node__0, 4, invoke_symbol (symbol__0, ".id", 0), invoke (words__ids__0, 1, invoke_symbol (_list__0, ".append", 2, invoke (_list__0, 1, first__1), args__0)), invoke_symbol (param__311, ".value", 0), invoke_symbol (param__311, ".location", 0))
--@ unknown
result__121 = list_result__98
else
result__121 = false
end
end
list_result__96 = result__121
return list_result__96
end
process_symbol_function_or_method__0 = fn__249
--@ compiler/resolve.luma:32:30
local fn__250 = function (param__312)
local list_result__99
local signature__1, first__2, rest__1
--@ compiler/resolve.luma:33:17
signature__1 = invoke_symbol (param__312, ".key", 0)
--@ compiler/resolve.luma:34:31
first__2 = invoke_symbol (invoke_symbol (signature__1, ".items", 0), ".get", 1, 0)
--@ compiler/resolve.luma:35:31
rest__1 = invoke_symbol (invoke_symbol (signature__1, ".items", 0), ".drop", 1, 1)
--@ compiler/resolve.luma:36:7
local result__122
--@ compiler/resolve.luma:37:24
if invoke_symbol (_word_node__0, ".?", 1, first__2) then
--@ compiler/resolve.luma:39:55
result__122 = invoke (_binding_node__0, 2, invoke_symbol (first__2, ".id", 0), invoke (_function_node__0, 3, invoke (words__ids__0, 1, rest__1), invoke_symbol (param__312, ".value", 0), invoke_symbol (param__312, ".location", 0)))
else
--@ compiler/resolve.luma:40:9
if else__0 then
--@ compiler/resolve.luma:40:10
local list_result__100
--@ compiler/resolve.luma:41:43
local result__123 = invoke_symbol (_symbol_node__0, ".?", 1, first__2)
if result__123 then
--@ compiler/resolve.luma:41:57
result__123 = invoke (___4, 2, ".", invoke_symbol (first__2, ".id", 0))
end
--@ compiler/resolve.luma:41:115
invoke (assert_at__0, 3, result__123, first__2, "function expects . or word in first position")
--@ compiler/resolve.luma:42:53
list_result__100 = invoke (_function_node__0, 3, invoke (words__ids__0, 1, rest__1), invoke_symbol (param__312, ".value", 0), invoke_symbol (param__312, ".location", 0))
--@ unknown
result__122 = list_result__100
else
result__122 = false
end
end
list_result__99 = result__122
return list_result__99
end
process_plain_function__0 = fn__250
--@ compiler/resolve.luma:44:29
local fn__251 = function (param__313, param__314)
--@ compiler/resolve.luma:45:7
local result__124
--@ compiler/resolve.luma:46:23
if invoke_symbol (_apply_node__0, ".?", 1, invoke_symbol (param__313, ".key", 0)) then
--@ compiler/resolve.luma:46:29
local list_result__101
local signature__2
--@ compiler/resolve.luma:47:21
signature__2 = invoke_symbol (param__313, ".key", 0)
--@ compiler/resolve.luma:49:11
local result__125
--@ compiler/resolve.luma:50:30
local result__126 = invoke_symbol (2, ".<=", 1, invoke_symbol (invoke_symbol (signature__2, ".items", 0), ".length", 0))
if result__126 then
--@ compiler/resolve.luma:50:83
result__126 = invoke_symbol (_symbol_node__0, ".?", 1, invoke_symbol (invoke_symbol (signature__2, ".items", 0), ".get", 1, 1))
end
if result__126 then
--@ compiler/resolve.luma:51:48
result__125 = invoke (process_symbol_function_or_method__0, 1, param__313)
else
--@ compiler/resolve.luma:52:13
if else__0 then
--@ compiler/resolve.luma:53:37
result__125 = invoke (process_plain_function__0, 1, param__313)
else
result__125 = false
end
end
list_result__101 = result__125
--@ unknown
result__124 = list_result__101
else
--@ compiler/resolve.luma:54:24
if invoke_symbol (_symbol_node__0, ".?", 1, invoke_symbol (param__313, ".key", 0)) then
--@ compiler/resolve.luma:55:43
result__124 = invoke (_field_node__0, 3, invoke_symbol (invoke_symbol (param__313, ".key", 0), ".id", 0), invoke_symbol (param__313, ".value", 0), invoke_symbol (param__313, ".location", 0))
else
--@ compiler/resolve.luma:56:9
if else__0 then
--@ compiler/resolve.luma:56:10
local list_result__102
--@ compiler/resolve.luma:57:69
invoke (assert_at__0, 3, invoke_symbol (_word_node__0, ".?", 1, invoke_symbol (param__313, ".key", 0)), invoke_symbol (param__313, ".key", 0), "unknown key in pair")
--@ compiler/resolve.luma:58:45
list_result__102 = invoke (_binding_node__0, 3, invoke_symbol (invoke_symbol (param__313, ".key", 0), ".id", 0), invoke_symbol (param__313, ".value", 0), invoke_symbol (param__313, ".location", 0))
--@ unknown
result__124 = list_result__102
else
result__124 = false
end
end
end
return result__124
end
process_pair__0 = fn__251
--@ compiler/resolve.luma:60:31
local fn__252 = function (param__315, param__316)
--@ compiler/resolve.luma:61:20
local fn__253 = function (param__317)
--@ compiler/resolve.luma:62:25
local result__127
if invoke_symbol (_pair_node__0, ".?", 1, param__317) then
--@ compiler/resolve.luma:63:32
result__127 = invoke (process_pair__0, 2, param__317, param__316)
else
--@ compiler/resolve.luma:64:10
result__127 = param__317
end
return result__127
end
return invoke_symbol (param__315, ".map", 1, fn__253)
end
process_pairs__0 = fn__252
--@ compiler/resolve.luma:66:21
local fn__254 = function (param__318)
local list_result__103
(function ()
local resolve_table__0, resolve_list__0, resolve_pair__0, resolve_apply__0, resolve_word__0, resolve_node__0
--@ compiler/resolve.luma:68:24
local fn__255 = function (param__319)
local list_result__104
local items__3
--@ compiler/resolve.luma:69:69
items__3 = invoke (process_pairs__0, 2, invoke_symbol (invoke_symbol (invoke_symbol (param__319, ".items", 0), ".drop", 1, 1), ".map", 1, resolve_node__0), true)
--@ compiler/resolve.luma:70:27
list_result__104 = invoke (_table_node__0, 2, items__3, invoke_symbol (param__319, ".location", 0))
--@ unknown
return list_result__104
end
resolve_table__0 = fn__255
--@ compiler/resolve.luma:72:23
local fn__256 = function (param__320)
local list_result__105
local items__4
--@ compiler/resolve.luma:73:70
items__4 = invoke (process_pairs__0, 2, invoke_symbol (invoke_symbol (invoke_symbol (param__320, ".items", 0), ".drop", 1, 1), ".map", 1, resolve_node__0), false)
--@ compiler/resolve.luma:74:26
list_result__105 = invoke (_list_node__0, 2, items__4, invoke_symbol (param__320, ".location", 0))
--@ unknown
return list_result__105
end
resolve_list__0 = fn__256
--@ compiler/resolve.luma:76:23
local fn__257 = function (param__321)
local list_result__106
local items__5, pair__0
--@ compiler/resolve.luma:77:48
items__5 = invoke_symbol (invoke_symbol (invoke_symbol (param__321, ".items", 0), ".drop", 1, 1), ".map", 1, resolve_node__0)
--@ compiler/resolve.luma:78:62
local assert_result__12 = assert(invoke (___4, 2, 2, invoke_symbol (items__5, ".length", 0)), "pair needs two items at ", invoke_symbol (invoke_symbol (param__321, ".location", 0), ".to-string", 0))
--@ compiler/resolve.luma:79:54
pair__0 = invoke (_pair_node__0, 3, invoke_symbol (items__5, ".get", 1, 0), invoke_symbol (items__5, ".get", 1, 1), invoke_symbol (param__321, ".location", 0))
--@ compiler/resolve.luma:80:26
local result__128
if invoke (is_anon_key___0, 1, invoke_symbol (pair__0, ".key", 0)) then
--@ compiler/resolve.luma:81:34
result__128 = invoke (process_plain_function__0, 1, pair__0)
else
--@ compiler/resolve.luma:82:11
result__128 = pair__0
end
list_result__106 = result__128
--@ unknown
return list_result__106
end
resolve_pair__0 = fn__257
--@ compiler/resolve.luma:84:24
local fn__258 = function (param__322)
local list_result__107
local first__3
--@ compiler/resolve.luma:85:81
local assert_result__13 = assert(invoke_symbol (invoke_symbol (invoke_symbol (param__322, ".items", 0), ".length", 0), ".>", 1, 0), invoke (combine_strings__0, 2, "empty apply node at ", invoke_symbol (invoke_symbol (param__322, ".location", 0), ".to-string", 0)))
--@ compiler/resolve.luma:86:28
first__3 = invoke_symbol (invoke_symbol (param__322, ".items", 0), ".get", 1, 0)
--@ compiler/resolve.luma:87:9
local result__129
--@ compiler/resolve.luma:88:26
if invoke (is_word___0, 2, first__3, "#") then
--@ compiler/resolve.luma:88:48
result__129 = invoke (resolve_table__0, 1, param__322)
else
--@ compiler/resolve.luma:89:26
if invoke (is_word___0, 2, first__3, "!") then
--@ compiler/resolve.luma:89:47
result__129 = invoke (resolve_list__0, 1, param__322)
else
--@ compiler/resolve.luma:90:26
if invoke (is_word___0, 2, first__3, ":") then
--@ compiler/resolve.luma:90:47
result__129 = invoke (resolve_pair__0, 1, param__322)
else
--@ compiler/resolve.luma:91:11
if else__0 then
--@ compiler/resolve.luma:91:12
local list_result__108
local items__6
--@ compiler/resolve.luma:92:43
items__6 = invoke_symbol (invoke_symbol (param__322, ".items", 0), ".map", 1, resolve_node__0)
--@ compiler/resolve.luma:93:31
list_result__108 = invoke (_apply_node__0, 2, items__6, invoke_symbol (param__322, ".location", 0))
--@ unknown
result__129 = list_result__108
else
result__129 = false
end
end
end
end
list_result__107 = result__129
return list_result__107
end
resolve_apply__0 = fn__258
--@ compiler/resolve.luma:95:23
local fn__259 = function (param__323)
--@ compiler/resolve.luma:96:9
local result__130
--@ compiler/resolve.luma:97:22
local result__131 = invoke (____1, 2, 1, invoke_symbol (invoke_symbol (param__323, ".id", 0), ".length", 0))
if result__131 then
--@ compiler/resolve.luma:97:63
result__131 = invoke (___4, 2, ".", invoke_symbol (invoke_symbol (param__323, ".id", 0), ".substring", 2, 0, 1))
end
if result__131 then
--@ compiler/resolve.luma:98:34
result__130 = invoke (_symbol_node__0, 2, invoke_symbol (param__323, ".id", 0), invoke_symbol (param__323, ".location", 0))
else
--@ compiler/resolve.luma:99:22
local result__132 = invoke (____1, 2, 1, invoke_symbol (invoke_symbol (param__323, ".id", 0), ".length", 0))
if result__132 then
--@ compiler/resolve.luma:99:64
result__132 = invoke (___4, 2, "'", invoke_symbol (invoke_symbol (param__323, ".id", 0), ".substring", 2, 0, 1))
end
if result__132 then
--@ compiler/resolve.luma:100:69
result__130 = invoke (_string_node__0, 2, invoke_symbol (invoke_symbol (param__323, ".id", 0), ".substring", 2, 1, invoke (___1, 2, invoke_symbol (invoke_symbol (param__323, ".id", 0), ".length", 0), 1)), invoke_symbol (param__323, ".location", 0))
else
--@ compiler/resolve.luma:101:12
if invoke_symbol (invoke_symbol (param__323, ".id", 0), ".to-number", 0) then
--@ compiler/resolve.luma:102:44
result__130 = invoke (_number_node__0, 2, invoke_symbol (invoke_symbol (param__323, ".id", 0), ".to-number", 0), invoke_symbol (param__323, ".location", 0))
else
--@ compiler/resolve.luma:103:30
if invoke_symbol (invoke_symbol (param__323, ".id", 0), ".contains?", 1, "..") then
--@ compiler/resolve.luma:104:34
result__130 = invoke (_vararg_node__0, 2, invoke_symbol (param__323, ".id", 0), invoke_symbol (param__323, ".location", 0))
else
--@ compiler/resolve.luma:105:33
local result__133 = invoke_symbol (invoke_symbol (param__323, ".id", 0), ".contains?", 1, ".")
if not result__133 then
--@ compiler/resolve.luma:105:61
local result__134 = invoke_symbol (invoke_symbol (param__323, ".id", 0), ".contains?", 1, "[")
if not result__134 then
--@ compiler/resolve.luma:105:85
result__134 = invoke_symbol (invoke_symbol (param__323, ".id", 0), ".contains?", 1, "]")
end
result__133 = result__134
end
if result__133 then
--@ compiler/resolve.luma:106:88
local assert_result__14 = assert(false, invoke (combine_strings__0, 4, "invalid character in word: ", invoke_symbol (param__323, ".id", 0), " at ", invoke_symbol (invoke_symbol (param__323, ".location", 0), ".to-string", 0)))
result__130 = assert_result__14
else
--@ compiler/resolve.luma:107:11
if else__0 then
--@ compiler/resolve.luma:108:13
result__130 = param__323
else
result__130 = false
end
end
end
end
end
end
return result__130
end
resolve_word__0 = fn__259
--@ compiler/resolve.luma:110:23
local fn__260 = function (param__324)
--@ compiler/resolve.luma:111:9
local result__135
--@ compiler/resolve.luma:112:26
if invoke_symbol (_apply_node__0, ".?", 1, param__324) then
--@ compiler/resolve.luma:112:48
result__135 = invoke (resolve_apply__0, 1, param__324)
else
--@ compiler/resolve.luma:113:25
if invoke_symbol (_word_node__0, ".?", 1, param__324) then
--@ compiler/resolve.luma:113:47
result__135 = invoke (resolve_word__0, 1, param__324)
else
--@ compiler/resolve.luma:114:11
if else__0 then
--@ compiler/resolve.luma:114:91
local assert_result__15 = assert(false, invoke (combine_strings__0, 2, "resolve: unknown node at ", invoke_symbol (invoke_symbol (param__324, ".location", 0), ".to-string", 0)))
result__135 = assert_result__15
else
result__135 = false
end
end
end
return result__135
end
resolve_node__0 = fn__260
--@ compiler/resolve.luma:116:26
list_result__103 = invoke (resolve_node__0, 1, param__318)
--@ unknown
end)()
return list_result__103
end
resolve__1 = fn__254
--@ compiler/resolve.luma:118:2
local table__63
--@ compiler/resolve.luma:119:20
table__63 = {
[".resolve"] = resolve__1,
}
--@ unknown
list_result__95 = table__63
end)()
_modules_compiler_resolve__0 = list_result__95
resolve__0 = invoke_symbol (_modules_compiler_resolve__0, ".resolve", 0)
local list_result__109
local is_word___1, link__1
--@ compiler/link.luma:1:19
local fn__261 = function (param__325, param__326)
--@ compiler/link.luma:2:24
local result__136 = invoke_symbol (_word_node__0, ".?", 1, param__325)
if result__136 then
--@ compiler/link.luma:2:38
result__136 = invoke (___4, 2, invoke_symbol (param__325, ".id", 0), param__326)
end
return result__136
end
is_word___1 = fn__261
--@ compiler/link.luma:4:18
local fn__262 = function (param__327)
local list_result__110
(function ()
local modules_linked__0, cycling__0, result__137, scan_module_for_imports__0, import_module__0
--@ compiler/link.luma:5:26
modules_linked__0 = invoke (_table__0, 0)
--@ compiler/link.luma:6:19
cycling__0 = invoke (_table__0, 0)
--@ compiler/link.luma:7:17
result__137 = invoke (_list__0, 0)
--@ compiler/link.luma:9:33
local fn__263 = function (param__328)
local list_result__111
--@ compiler/link.luma:10:76
invoke (assert_at__0, 3, invoke_symbol (_list_node__0, ".?", 1, param__328), param__328, "top level of module should be a list")
--@ compiler/link.luma:11:29
local fn__264 = function (param__329)
--@ compiler/link.luma:12:11
local result__138
--@ compiler/link.luma:12:36
local result__139 = invoke_symbol (_apply_node__0, ".?", 1, param__329)
if result__139 then
--@ compiler/link.luma:12:75
result__139 = invoke (is_word___1, 2, invoke_symbol (invoke_symbol (param__329, ".items", 0), ".get", 1, 0), "import")
end
if result__139 then
--@ compiler/link.luma:12:78
local list_result__112
local name__0
--@ compiler/link.luma:13:81
invoke (assert_at__0, 3, invoke (___4, 2, 2, invoke_symbol (invoke_symbol (param__329, ".items", 0), ".length", 0)), param__329, "import should take one argument")
--@ compiler/link.luma:14:31
name__0 = invoke_symbol (invoke_symbol (param__329, ".items", 0), ".get", 1, 1)
--@ compiler/link.luma:15:87
invoke (assert_at__0, 3, invoke_symbol (_string_node__0, ".?", 1, name__0), param__329, "import should be given a string literal")
--@ compiler/link.luma:16:27
list_result__112 = invoke (import_module__0, 1, invoke_symbol (name__0, ".value", 0))
--@ unknown
result__138 = list_result__112
else
result__138 = false
end
return result__138
end
list_result__111 = invoke_symbol (invoke_symbol (param__328, ".items", 0), ".each", 1, fn__264)
return list_result__111
end
scan_module_for_imports__0 = fn__263
--@ compiler/link.luma:18:24
local fn__265 = function (param__330)
local list_result__113
local internal__0
--@ compiler/link.luma:19:47
internal__0 = invoke (combine_strings__0, 2, "&modules/", param__330)
--@ compiler/link.luma:20:9
local result__140
--@ compiler/link.luma:20:40
if invoke (not__0, 1, invoke_symbol (modules_linked__0, ".has?", 1, param__330)) then
--@ compiler/link.luma:20:43
local list_result__114
(function ()
local filename__0, str__0, tokens__1, mod__0, exports_table__0
--@ compiler/link.luma:21:11
local result__141
--@ compiler/link.luma:21:30
if invoke_symbol (cycling__0, ".has?", 1, param__330) then
--@ compiler/link.luma:22:65
local assert_result__16 = assert(false, invoke (combine_strings__0, 2, "cycle in import of ", param__330))
result__141 = assert_result__16
else
result__141 = false
end
--@ compiler/link.luma:23:35
invoke_symbol (modules_linked__0, ".set", 2, param__330, true)
--@ compiler/link.luma:24:28
invoke_symbol (cycling__0, ".set", 2, param__330, true)
--@ compiler/link.luma:26:45
filename__0 = invoke (combine_strings__0, 2, param__330, ".luma")
--@ compiler/link.luma:27:30
str__0 = invoke (read_file__0, 1, filename__0)
--@ compiler/link.luma:28:32
tokens__1 = invoke (read__0, 2, str__0, filename__0)
--@ compiler/link.luma:29:33
mod__0 = invoke (resolve__0, 1, invoke (parse__0, 1, tokens__1))
--@ compiler/link.luma:30:34
invoke (scan_module_for_imports__0, 1, mod__0)
--@ compiler/link.luma:31:88
invoke (assert_at__0, 3, invoke_symbol (invoke_symbol (invoke_symbol (mod__0, ".items", 0), ".length", 0), ".>", 1, 0), mod__0, "empty module (todo: does this ever fire?)")
--@ compiler/link.luma:33:46
invoke_symbol (result__137, ".push", 1, invoke (_binding_node__0, 2, internal__0, mod__0))
--@ compiler/link.luma:35:25
exports_table__0 = invoke_symbol (invoke_symbol (mod__0, ".items", 0), ".last", 0)
--@ compiler/link.luma:36:101
invoke (assert_at__0, 3, invoke_symbol (_table_node__0, ".?", 1, exports_table__0), exports_table__0, "modules need to end in a literal table")
--@ compiler/link.luma:37:42
local fn__266 = function (param__331)
local list_result__115
--@ compiler/link.luma:38:79
invoke (assert_at__0, 3, invoke_symbol (_field_node__0, ".?", 1, param__331), param__331, "unknown item in module exports")
--@ compiler/link.luma:42:85
list_result__115 = invoke_symbol (result__137, ".push", 1, invoke (_binding_node__0, 2, invoke_symbol (invoke_symbol (param__331, ".id", 0), ".substring", 2, 1, invoke_symbol (invoke_symbol (param__331, ".id", 0), ".length", 0)), invoke (_apply_node__0, 1, invoke (_list__0, 2, invoke (_word_node__0, 1, internal__0), invoke (_symbol_node__0, 1, invoke_symbol (param__331, ".id", 0))))))
--@ unknown
return list_result__115
end
invoke_symbol (invoke_symbol (exports_table__0, ".items", 0), ".each", 1, fn__266)
--@ compiler/link.luma:43:26
list_result__114 = invoke_symbol (cycling__0, ".remove", 1, param__330)
--@ unknown
end)()
result__140 = list_result__114
else
result__140 = false
end
list_result__113 = result__140
return list_result__113
end
import_module__0 = fn__265
--@ compiler/link.luma:45:37
invoke (scan_module_for_imports__0, 1, param__327)
--@ compiler/link.luma:46:24
invoke_symbol (result__137, ".push", 1, param__327)
--@ compiler/link.luma:47:21
list_result__110 = invoke (_list_node__0, 1, result__137)
--@ unknown
end)()
return list_result__110
end
link__1 = fn__262
--@ compiler/link.luma:49:2
local table__64
--@ compiler/link.luma:50:14
table__64 = {
[".link"] = link__1,
}
--@ unknown
list_result__109 = table__64
_modules_compiler_link__0 = list_result__109
link__0 = invoke_symbol (_modules_compiler_link__0, ".link", 0)
local list_result__116
local _value__1
--@ compiler/value.luma:1:10
local table__65
local fn__267 = function (param__332)
--@ compiler/value.luma:2:26
local result__142 = type (param__332) == "table" and (param__332.index == _value__1 or param__332[_value__1] ~= nil)
return result__142
end
local fn__268 = function (param__333)
--@ compiler/value.luma:4:14
local table__66
--@ compiler/value.luma:7:19
table__66 = {
["index"] = _value__1,
[".id"] = param__333,
[".emitted"] = false,
[".simple"] = false,
}
--@ unknown
return table__66
end
local fn__269 = function (param__334)
--@ compiler/value.luma:9:22
local table__67
--@ compiler/value.luma:12:18
table__67 = {
["index"] = _value__1,
[".id"] = param__334,
[".emitted"] = false,
[".simple"] = true,
}
--@ unknown
return table__67
end
local fn__270 = function (param__335)
--@ compiler/value.luma:14:15
local list_result__117
--@ compiler/value.luma:15:9
local result__143
--@ compiler/value.luma:15:24
local result__144 = invoke (not__0, 1, invoke_symbol (param__335, ".simple", 0))
if result__144 then
--@ compiler/value.luma:15:37
result__144 = invoke_symbol (param__335, ".emitted", 0)
end
if result__144 then
--@ compiler/value.luma:16:74
local assert_result__17 = assert(false, invoke (combine_strings__0, 2, "value emitted multiple times: ", invoke_symbol (param__335, ".id", 0)))
result__143 = assert_result__17
else
result__143 = false
end
--@ compiler/value.luma:17:13
param__335 [".emitted"] = true
list_result__117 = true
--@ unknown
return list_result__117
end
table__65 = {
functions = {
[".?"] = fn__267,
[1] = fn__268,
[".simple"] = fn__269,
},
methods = {
[".emit"] = fn__270,
},
}
_value__1 = table__65
--@ compiler/value.luma:19:2
local table__68
--@ compiler/value.luma:20:18
table__68 = {
[".#value"] = _value__1,
}
--@ unknown
list_result__116 = table__68
_modules_compiler_value__0 = list_result__116
_value__0 = invoke_symbol (_modules_compiler_value__0, ".#value", 0)
local list_result__118
local _lua_emitter__1
--@ compiler/lua-emitter.luma:1:16
local table__69
local fn__271 = function ()
--@ compiler/lua-emitter.luma:2:9
local table__70
--@ compiler/lua-emitter.luma:5:20
table__70 = {
["index"] = _lua_emitter__1,
[".last-location"] = false,
[".location-to-emit"] = false,
[".buffer"] = invoke (_list__0, 0),
}
--@ unknown
return table__70
end
local fn__272 = function (param__336, param__337)
--@ compiler/lua-emitter.luma:8:13
param__336 [".location-to-emit"] = param__337
return true
end
local fn__273 = function (...)
local param__338 = ...
local param__339 = { n = select ("#", ...) - 1, select (2, ...) }
assert (param__339.n >= 0, "not enough arguments to function")
--@ compiler/lua-emitter.luma:10:22
local list_result__119
--@ compiler/lua-emitter.luma:11:9
local result__145
--@ compiler/lua-emitter.luma:11:19
local result__146 = invoke_symbol (param__338, ".location-to-emit", 0)
if result__146 then
--@ compiler/lua-emitter.luma:12:28
local result__147 = invoke (not__0, 1, invoke_symbol (param__338, ".last-location", 0))
if not result__147 then
--@ compiler/lua-emitter.luma:13:50
result__147 = invoke_symbol (invoke_symbol (param__338, ".location-to-emit", 0), ".~=", 1, invoke_symbol (param__338, ".last-location", 0))
end
result__146 = result__147
end
if result__146 then
--@ compiler/lua-emitter.luma:13:68
local list_result__120
--@ compiler/lua-emitter.luma:14:84
invoke_symbol (invoke_symbol (param__338, ".buffer", 0), ".push", 1, invoke (combine_strings__0, 3, "--@ ", invoke_symbol (invoke_symbol (param__338, ".location-to-emit", 0), ".to-string", 0), "\
"))
--@ compiler/lua-emitter.luma:15:15
param__338 [".last-location"] = invoke_symbol (param__338, ".location-to-emit", 0)
--@ compiler/lua-emitter.luma:16:15
param__338 [".location-to-emit"] = false
list_result__120 = true
--@ unknown
result__145 = list_result__120
else
result__145 = false
end
--@ compiler/lua-emitter.luma:17:35
local fn__274 = function (param__340)
--@ compiler/lua-emitter.luma:18:11
local result__148
--@ compiler/lua-emitter.luma:19:24
if invoke_symbol (_string__0, ".?", 1, param__340) then
--@ compiler/lua-emitter.luma:20:32
result__148 = invoke_symbol (invoke_symbol (param__338, ".buffer", 0), ".push", 1, param__340)
else
--@ compiler/lua-emitter.luma:21:23
if invoke_symbol (_value__0, ".?", 1, param__340) then
--@ compiler/lua-emitter.luma:21:25
local list_result__121
--@ compiler/lua-emitter.luma:22:15
invoke_symbol (param__340, ".emit", 0)
--@ compiler/lua-emitter.luma:23:32
list_result__121 = invoke_symbol (invoke_symbol (param__338, ".buffer", 0), ".push", 1, invoke_symbol (param__340, ".id", 0))
--@ unknown
result__148 = list_result__121
else
--@ compiler/lua-emitter.luma:24:13
if else__0 then
--@ compiler/lua-emitter.luma:25:27
local fn__275 = function (param__341)
--@ compiler/lua-emitter.luma:25:39
return invoke_symbol (param__338, ".put", 1, param__341)
end
result__148 = invoke_symbol (param__340, ".each", 1, fn__275)
else
result__148 = false
end
end
end
return result__148
end
list_result__119 = invoke_symbol (invoke (_list__0, 0 + param__339.n, unpack (param__339, 1, param__339.n)), ".each", 1, fn__274)
--@ unknown
return list_result__119
end
local fn__276 = function (param__342)
--@ compiler/lua-emitter.luma:28:9
return invoke_symbol (invoke_symbol (param__342, ".buffer", 0), ".concat", 0)
end
table__69 = {
functions = {
[0] = fn__271,
},
methods = {
[".set-location"] = fn__272,
[".put"] = fn__273,
[".concat-result"] = fn__276,
},
}
--@ unknown
_lua_emitter__1 = table__69
--@ compiler/lua-emitter.luma:30:2
local table__71
--@ compiler/lua-emitter.luma:31:30
table__71 = {
[".#lua-emitter"] = _lua_emitter__1,
}
--@ unknown
list_result__118 = table__71
_modules_compiler_lua_emitter__0 = list_result__118
_lua_emitter__0 = invoke_symbol (_modules_compiler_lua_emitter__0, ".#lua-emitter", 0)
local list_result__122
local seq__0, comma_separate__0, is_function_vararg___0, compile__1
--@ compiler/compile.luma:1:15
local fn__277 = function (...)
local param__343 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__343.n >= 0, "not enough arguments to function")
local list_result__123
local inputs__0, result__149
--@ compiler/compile.luma:3:17
inputs__0 = invoke (_list__0, 0 + param__343.n, unpack (param__343, 1, param__343.n))
--@ compiler/compile.luma:4:17
result__149 = invoke (_list__0, 0)
--@ compiler/compile.luma:5:24
local fn__278 = function (param__344)
--@ compiler/compile.luma:6:21
local result__150
if invoke_symbol (_list__0, ".?", 1, param__344) then
--@ compiler/compile.luma:7:29
result__150 = invoke_symbol (result__149, ".push-items", 1, param__344)
else
--@ compiler/compile.luma:8:23
result__150 = invoke_symbol (result__149, ".push", 1, param__344)
end
return result__150
end
invoke_symbol (inputs__0, ".each", 1, fn__278)
--@ compiler/compile.luma:9:9
list_result__123 = result__149
--@ unknown
return list_result__123
end
seq__0 = fn__277
--@ compiler/compile.luma:11:24
local fn__279 = function (param__345)
local list_result__124
local out__2, iter__2
--@ compiler/compile.luma:12:14
out__2 = invoke (_list__0, 0)
--@ compiler/compile.luma:13:14
iter__2 = invoke_symbol (param__345, ".iterator", 0)
--@ compiler/compile.luma:14:7
local result__151
--@ compiler/compile.luma:14:17
if invoke (not__0, 1, invoke_symbol (iter__2, ".empty?", 0)) then
--@ compiler/compile.luma:14:26
local list_result__125
--@ compiler/compile.luma:15:18
invoke_symbol (out__2, ".push", 1, invoke_symbol (iter__2, ".item", 0))
--@ compiler/compile.luma:16:9
list_result__125 = invoke_symbol (iter__2, ".advance", 0)
--@ unknown
result__151 = list_result__125
else
result__151 = false
end
--@ compiler/compile.luma:17:22
local fn__280 = function (param__346)
local list_result__126
--@ compiler/compile.luma:18:18
invoke_symbol (out__2, ".push", 1, ", ")
--@ compiler/compile.luma:19:18
list_result__126 = invoke_symbol (out__2, ".push", 1, param__346)
--@ unknown
return list_result__126
end
invoke_symbol (iter__2, ".each", 1, fn__280)
--@ compiler/compile.luma:20:6
list_result__124 = out__2
--@ unknown
return list_result__124
end
comma_separate__0 = fn__279
--@ compiler/compile.luma:22:25
local fn__281 = function (param__347)
local list_result__127
local last_arg__0
--@ compiler/compile.luma:23:38
local result__152 = invoke_symbol (invoke_symbol (invoke_symbol (param__347, ".params", 0), ".length", 0), ".>", 1, 0)
if result__152 then
--@ compiler/compile.luma:23:41
result__152 = invoke_symbol (invoke_symbol (param__347, ".params", 0), ".last", 0)
end
last_arg__0 = result__152
--@ compiler/compile.luma:24:15
local result__153 = last_arg__0
if result__153 then
--@ compiler/compile.luma:24:40
result__153 = invoke_symbol (last_arg__0, ".contains?", 1, "..")
end
list_result__127 = result__153
--@ unknown
return list_result__127
end
is_function_vararg___0 = fn__281
--@ compiler/compile.luma:26:15
local fn__282 = function (param__348)
local list_result__128
(function ()
local emitter__0, name_counts__0, emit__1, set_location__0, gensym__0, compile_number__0, compile_string__0, compile_word__0, compile_args__0, prepare_args__0, compile_apply__0, compile_list__0, compile_function__0, compile_table__0, compile_exp__0, base_context__0
--@ compiler/compile.luma:27:25
emitter__0 = invoke (_lua_emitter__0, 0)
--@ compiler/compile.luma:28:33
invoke_symbol (emitter__0, ".set-location", 1, invoke_symbol (_location__0, ".unknown", 0))
--@ compiler/compile.luma:29:23
name_counts__0 = invoke (_table__0, 0)
--@ compiler/compile.luma:31:18
local fn__283 = function (...)
local param__349 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__349.n >= 0, "not enough arguments to function")
--@ compiler/compile.luma:32:12
return invoke_symbol (emitter__0, ".put", 0 + param__349.n, unpack (param__349, 1, param__349.n))
end
emit__1 = fn__283
--@ compiler/compile.luma:34:27
local fn__284 = function (param__350)
--@ compiler/compile.luma:35:34
return invoke_symbol (emitter__0, ".set-location", 1, param__350)
end
set_location__0 = fn__284
--@ compiler/compile.luma:37:17
local fn__285 = function (param__351)
local list_result__129
local safe_name__0, count__0, id__0
--@ compiler/compile.luma:38:37
safe_name__0 = invoke (safe_identifier__0, 1, param__351)
--@ compiler/compile.luma:39:42
count__0 = invoke_symbol (name_counts__0, ".get-or", 2, safe_name__0, 0)
--@ compiler/compile.luma:40:45
id__0 = invoke (combine_strings__0, 3, safe_name__0, "__", invoke_symbol (count__0, ".to-string", 0))
--@ compiler/compile.luma:41:42
invoke_symbol (name_counts__0, ".set", 2, safe_name__0, invoke_symbol (count__0, ".+", 1, 1))
--@ compiler/compile.luma:42:21
list_result__129 = invoke_symbol (_value__0, ".simple", 1, id__0)
--@ unknown
return list_result__129
end
gensym__0 = fn__285
--@ compiler/compile.luma:44:32
local fn__286 = function (param__352, param__353)
--@ compiler/compile.luma:45:22
return invoke_symbol (_value__0, ".simple", 1, invoke_symbol (invoke_symbol (param__352, ".value", 0), ".to-string", 0))
end
compile_number__0 = fn__286
--@ compiler/compile.luma:47:32
local fn__287 = function (param__354, param__355)
--@ compiler/compile.luma:48:36
return invoke_symbol (_value__0, ".simple", 1, invoke (quote_string__0, 1, invoke_symbol (param__354, ".value", 0)))
end
compile_string__0 = fn__287
--@ compiler/compile.luma:50:30
local fn__288 = function (param__356, param__357)
--@ compiler/compile.luma:51:30
return invoke_symbol (param__357, ".lookup", 2, invoke_symbol (param__356, ".id", 0), invoke_symbol (param__356, ".location", 0))
end
compile_word__0 = fn__288
--@ compiler/compile.luma:53:31
local fn__289 = function (param__358, param__359)
--@ compiler/compile.luma:54:22
local fn__290 = function (param__360)
--@ compiler/compile.luma:55:30
return invoke (compile_exp__0, 2, param__360, param__359)
end
return invoke_symbol (param__358, ".map", 1, fn__290)
end
compile_args__0 = fn__289
--@ compiler/compile.luma:57:31
local fn__291 = function (param__361, param__362)
--@ compiler/compile.luma:58:9
local result__154
--@ compiler/compile.luma:59:24
if invoke_symbol (invoke_symbol (param__361, ".length", 0), ".=", 1, 0) then
--@ compiler/compile.luma:60:10
local table__72
--@ compiler/compile.luma:63:22
table__72 = {
[".n"] = "0",
[".static-n"] = 0,
[".args"] = param__361,
}
--@ unknown
result__154 = table__72
else
--@ compiler/compile.luma:64:11
if else__0 then
--@ compiler/compile.luma:64:12
local list_result__130
local last_arg__1
--@ compiler/compile.luma:65:23
last_arg__1 = invoke_symbol (param__361, ".last", 0)
--@ compiler/compile.luma:66:13
local result__155
--@ compiler/compile.luma:67:35
if invoke_symbol (_vararg_node__0, ".?", 1, last_arg__1) then
--@ compiler/compile.luma:67:37
local list_result__131
local vararg__0, list_without_vararg__0, n__1, arg_strings__0
--@ compiler/compile.luma:68:57
vararg__0 = invoke_symbol (param__362, ".lookup", 2, invoke_symbol (last_arg__1, ".id", 0), invoke_symbol (last_arg__1, ".location", 0))
--@ compiler/compile.luma:69:50
list_without_vararg__0 = invoke_symbol (param__361, ".drop-last", 1, 1)
--@ compiler/compile.luma:70:89
n__1 = invoke (combine_strings__0, 4, invoke_symbol (invoke_symbol (list_without_vararg__0, ".length", 0), ".to-string", 0), " + ", invoke_symbol (vararg__0, ".id", 0), ".n")
--@ compiler/compile.luma:72:108
arg_strings__0 = invoke_symbol (_list__0, ".append", 2, invoke (compile_args__0, 2, invoke_symbol (param__361, ".drop-last", 1, 1), param__362), invoke (_list__0, 1, invoke (combine_strings__0, 5, "unpack (", invoke_symbol (vararg__0, ".id", 0), ", 1, ", invoke_symbol (vararg__0, ".id", 0), ".n)")))
--@ compiler/compile.luma:73:14
local table__73
--@ compiler/compile.luma:76:33
table__73 = {
[".n"] = n__1,
[".static-n"] = false,
[".args"] = arg_strings__0,
}
--@ unknown
list_result__131 = table__73
result__155 = list_result__131
else
--@ compiler/compile.luma:77:15
if else__0 then
--@ compiler/compile.luma:78:14
local table__74
--@ compiler/compile.luma:81:47
table__74 = {
[".n"] = invoke_symbol (invoke_symbol (param__361, ".length", 0), ".to-string", 0),
[".static-n"] = invoke_symbol (param__361, ".length", 0),
[".args"] = invoke (compile_args__0, 2, param__361, param__362),
}
--@ unknown
result__155 = table__74
else
result__155 = false
end
end
list_result__130 = result__155
result__154 = list_result__130
else
result__154 = false
end
end
return result__154
end
prepare_args__0 = fn__291
--@ compiler/compile.luma:83:31
local fn__292 = function (param__363, param__364)
local list_result__132
local fn__293, args__1, fn_val__0
--@ compiler/compile.luma:84:24
fn__293 = invoke_symbol (invoke_symbol (param__363, ".items", 0), ".get", 1, 0)
--@ compiler/compile.luma:85:27
args__1 = invoke_symbol (invoke_symbol (param__363, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:88:35
fn_val__0 = invoke (compile_exp__0, 2, fn__293, param__364)
--@ compiler/compile.luma:90:9
local result__156
--@ compiler/compile.luma:91:32
if invoke_symbol (_primitive_node__0, ".?", 1, fn_val__0) then
--@ compiler/compile.luma:92:32
result__156 = invoke (invoke_symbol (fn_val__0, ".fn", 0), 2, param__363, param__364)
else
--@ compiler/compile.luma:94:29
local result__157 = invoke_symbol (invoke_symbol (args__1, ".length", 0), ".>", 1, 0)
if result__157 then
--@ compiler/compile.luma:94:58
result__157 = invoke_symbol (_symbol_node__0, ".?", 1, invoke_symbol (args__1, ".get", 1, 0))
end
if result__157 then
--@ compiler/compile.luma:94:62
local list_result__133
(function ()
local symbol_id__0, quoted_symbol__0, compiled_args__0, buffer__0
--@ compiler/compile.luma:95:31
symbol_id__0 = invoke_symbol (invoke_symbol (args__1, ".get", 1, 0), ".id", 0)
--@ compiler/compile.luma:96:46
quoted_symbol__0 = invoke (quote_string__0, 1, symbol_id__0)
--@ compiler/compile.luma:98:58
compiled_args__0 = invoke (prepare_args__0, 2, invoke_symbol (args__1, ".drop", 1, 1), param__364)
--@ compiler/compile.luma:100:30
buffer__0 = invoke (_lua_emitter__0, 0)
--@ compiler/compile.luma:101:37
invoke_symbol (buffer__0, ".put", 1, "invoke_symbol (")
--@ compiler/compile.luma:102:91
invoke_symbol (buffer__0, ".put", 1, invoke (comma_separate__0, 1, invoke (seq__0, 4, fn_val__0, quoted_symbol__0, invoke_symbol (compiled_args__0, ".n", 0), invoke_symbol (compiled_args__0, ".args", 0))))
--@ compiler/compile.luma:103:23
invoke_symbol (buffer__0, ".put", 1, ")")
--@ compiler/compile.luma:104:22
list_result__133 = invoke (_value__0, 1, invoke_symbol (buffer__0, ".concat-result", 0))
--@ unknown
end)()
result__156 = list_result__133
else
--@ compiler/compile.luma:106:11
if else__0 then
--@ compiler/compile.luma:106:12
local list_result__134
(function ()
local compiled_args__1, buffer__1
--@ compiler/compile.luma:108:49
compiled_args__1 = invoke (prepare_args__0, 2, args__1, param__364)
--@ compiler/compile.luma:110:30
buffer__1 = invoke (_lua_emitter__0, 0)
--@ compiler/compile.luma:111:30
invoke_symbol (buffer__1, ".put", 1, "invoke (")
--@ compiler/compile.luma:112:77
invoke_symbol (buffer__1, ".put", 1, invoke (comma_separate__0, 1, invoke (seq__0, 3, fn_val__0, invoke_symbol (compiled_args__1, ".n", 0), invoke_symbol (compiled_args__1, ".args", 0))))
--@ compiler/compile.luma:113:23
invoke_symbol (buffer__1, ".put", 1, ")")
--@ compiler/compile.luma:114:22
list_result__134 = invoke (_value__0, 1, invoke_symbol (buffer__1, ".concat-result", 0))
--@ unknown
end)()
result__156 = list_result__134
else
result__156 = false
end
end
end
list_result__132 = result__156
return list_result__132
end
compile_apply__0 = fn__292
--@ compiler/compile.luma:116:30
local fn__294 = function (param__365, param__366)
local list_result__135
(function ()
local new_context__0, result_id__0, items__7, length_threshold__0, locals__0
--@ compiler/compile.luma:117:34
new_context__0 = invoke (_context__0, 1, param__366)
--@ compiler/compile.luma:118:36
result_id__0 = invoke (gensym__0, 1, "list_result")
--@ compiler/compile.luma:121:15
items__7 = invoke_symbol (param__365, ".items", 0)
--@ compiler/compile.luma:124:33
invoke (emit__1, 3, "local ", result_id__0, "\
")
--@ compiler/compile.luma:127:24
length_threshold__0 = 5
--@ compiler/compile.luma:128:9
local result__158
--@ compiler/compile.luma:128:43
if invoke_symbol (invoke_symbol (items__7, ".length", 0), ".>", 1, length_threshold__0) then
--@ compiler/compile.luma:129:28
result__158 = invoke (emit__1, 1, "(function ()\
")
else
result__158 = false
end
--@ compiler/compile.luma:132:19
locals__0 = invoke (_list__0, 0)
--@ compiler/compile.luma:133:25
local fn__295 = function (param__367)
--@ compiler/compile.luma:134:11
local result__159
--@ compiler/compile.luma:134:33
if invoke_symbol (_binding_node__0, ".?", 1, param__367) then
--@ compiler/compile.luma:134:35
local list_result__136
local id__1
--@ compiler/compile.luma:135:25
id__1 = invoke (gensym__0, 1, invoke_symbol (param__367, ".id", 0))
--@ compiler/compile.luma:136:15
id__1 [".simple"] = true
--@ compiler/compile.luma:137:23
invoke_symbol (locals__0, ".push", 1, id__1)
--@ compiler/compile.luma:138:35
list_result__136 = invoke_symbol (new_context__0, ".add", 2, invoke_symbol (param__367, ".id", 0), id__1)
--@ unknown
result__159 = list_result__136
else
result__159 = false
end
return result__159
end
invoke_symbol (items__7, ".each", 1, fn__295)
--@ compiler/compile.luma:139:9
local result__160
--@ compiler/compile.luma:139:21
if invoke (not__0, 1, invoke_symbol (locals__0, ".empty?", 0)) then
--@ compiler/compile.luma:140:49
result__160 = invoke (emit__1, 3, "local ", invoke (comma_separate__0, 1, locals__0), "\
")
else
result__160 = false
end
--@ compiler/compile.luma:143:9
local result__161
--@ compiler/compile.luma:143:28
if invoke_symbol (invoke_symbol (items__7, ".length", 0), ".>", 1, 0) then
--@ compiler/compile.luma:143:30
local list_result__137
local last_item__0, compiled_value__0
--@ compiler/compile.luma:144:41
local fn__296 = function (param__368)
--@ compiler/compile.luma:145:13
local result__162
--@ compiler/compile.luma:146:32
if invoke_symbol (_binding_node__0, ".?", 1, param__368) then
--@ compiler/compile.luma:146:34
local list_result__138
local id__2, compiled_value__1
--@ compiler/compile.luma:147:49
id__2 = invoke_symbol (new_context__0, ".lookup", 2, invoke_symbol (param__368, ".id", 0), invoke_symbol (param__368, ".location", 0))
--@ compiler/compile.luma:148:64
compiled_value__1 = invoke (compile_exp__0, 2, invoke_symbol (param__368, ".value", 0), new_context__0)
--@ compiler/compile.luma:149:46
invoke (emit__1, 4, id__2, " = ", compiled_value__1, "\
")
--@ compiler/compile.luma:151:17
local result__163
--@ compiler/compile.luma:152:32
if invoke (___4, 2, "#number", invoke_symbol (param__368, ".id", 0)) then
--@ compiler/compile.luma:152:67
result__163 = invoke (emit__1, 3, "ops.number = ", id__2, "\
")
else
--@ compiler/compile.luma:153:32
if invoke (___4, 2, "#string", invoke_symbol (param__368, ".id", 0)) then
--@ compiler/compile.luma:153:67
result__163 = invoke (emit__1, 3, "ops.string = ", id__2, "\
")
else
--@ compiler/compile.luma:154:32
if invoke (___4, 2, "#bool", invoke_symbol (param__368, ".id", 0)) then
--@ compiler/compile.luma:154:70
result__163 = invoke (emit__1, 3, "ops.boolean = ", id__2, "\
")
else
result__163 = false
end
end
end
list_result__138 = result__163
--@ unknown
result__162 = list_result__138
else
--@ compiler/compile.luma:155:15
if else__0 then
--@ compiler/compile.luma:155:16
local list_result__139
local value__2
--@ compiler/compile.luma:157:49
value__2 = invoke (compile_exp__0, 2, param__368, new_context__0)
--@ compiler/compile.luma:158:17
local result__164
--@ compiler/compile.luma:158:28
if invoke (not__0, 1, invoke_symbol (value__2, ".simple", 0)) then
--@ compiler/compile.luma:159:30
result__164 = invoke (emit__1, 2, value__2, "\
")
else
result__164 = false
end
list_result__139 = result__164
--@ unknown
result__162 = list_result__139
else
result__162 = false
end
end
return result__162
end
invoke_symbol (invoke_symbol (items__7, ".drop-last", 1, 1), ".each", 1, fn__296)
--@ compiler/compile.luma:160:23
last_item__0 = invoke_symbol (items__7, ".last", 0)
--@ compiler/compile.luma:161:90
invoke (assert_at__0, 3, invoke (not__0, 1, invoke_symbol (_binding_node__0, ".?", 1, last_item__0)), last_item__0, "lists cant end in a binding")
--@ compiler/compile.luma:162:57
compiled_value__0 = invoke (compile_exp__0, 2, last_item__0, new_context__0)
--@ compiler/compile.luma:163:47
list_result__137 = invoke (emit__1, 4, result_id__0, " = ", compiled_value__0, "\
")
--@ unknown
result__161 = list_result__137
else
result__161 = false
end
--@ compiler/compile.luma:165:27
invoke (set_location__0, 1, invoke_symbol (_location__0, ".unknown", 0))
--@ compiler/compile.luma:166:9
local result__165
--@ compiler/compile.luma:166:43
if invoke_symbol (invoke_symbol (items__7, ".length", 0), ".>", 1, length_threshold__0) then
--@ compiler/compile.luma:167:22
result__165 = invoke (emit__1, 1, "end)()\
")
else
result__165 = false
end
--@ compiler/compile.luma:168:14
list_result__135 = result_id__0
--@ unknown
end)()
return list_result__135
end
compile_list__0 = fn__294
--@ compiler/compile.luma:170:34
local fn__297 = function (param__369, param__370)
local list_result__140
(function ()
local fn_id__0, new_context__1, params__0, index__0, return_value__0
--@ compiler/compile.luma:171:23
fn_id__0 = invoke (gensym__0, 1, "fn")
--@ compiler/compile.luma:172:35
new_context__1 = invoke (_context__0, 1, param__370)
--@ compiler/compile.luma:173:19
params__0 = invoke (_list__0, 0)
--@ compiler/compile.luma:174:31
local fn__298 = function (param__371)
local list_result__141
local param_id__0
--@ compiler/compile.luma:175:32
param_id__0 = invoke (gensym__0, 1, "param")
--@ compiler/compile.luma:176:19
param_id__0 [".simple"] = true
--@ compiler/compile.luma:177:27
invoke_symbol (params__0, ".push", 1, param_id__0)
--@ compiler/compile.luma:178:37
list_result__141 = invoke_symbol (new_context__1, ".add", 2, param__371, param_id__0)
--@ unknown
return list_result__141
end
invoke_symbol (invoke_symbol (param__369, ".params", 0), ".each", 1, fn__298)
--@ compiler/compile.luma:179:17
index__0 = false
--@ compiler/compile.luma:180:9
local result__166
--@ compiler/compile.luma:181:31
if invoke (is_function_vararg___0, 1, param__369) then
--@ compiler/compile.luma:181:33
local list_result__142
(function ()
local vararg__1, adjusted_params__0, fixed_param_count__0
--@ compiler/compile.luma:182:23
vararg__1 = invoke_symbol (params__0, ".last", 0)
--@ compiler/compile.luma:183:44
adjusted_params__0 = invoke_symbol (params__0, ".drop-last", 1, 1)
--@ compiler/compile.luma:184:43
fixed_param_count__0 = invoke_symbol (adjusted_params__0, ".length", 0)
--@ compiler/compile.luma:185:50
invoke (emit__1, 3, "local ", fn_id__0, " = function (...)\
")
--@ compiler/compile.luma:186:13
local result__167
--@ compiler/compile.luma:186:36
if invoke (___5, 2, 0, fixed_param_count__0) then
--@ compiler/compile.luma:187:68
result__167 = invoke (emit__1, 3, "local ", invoke (comma_separate__0, 1, adjusted_params__0), " = ...\
")
else
result__167 = false
end
--@ compiler/compile.luma:188:149
invoke (emit__1, 7, "local ", vararg__1, " = { n = select (\"#\", ...) - ", invoke_symbol (fixed_param_count__0, ".to-string", 0), ", select (", invoke_symbol (invoke (___0, 2, 1, fixed_param_count__0), ".to-string", 0), ", ...) }\
")
--@ compiler/compile.luma:189:80
invoke (emit__1, 3, "assert (", vararg__1, ".n >= 0, \"not enough arguments to function\")\
")
--@ compiler/compile.luma:190:23
index__0 = ".."
list_result__142 = true
--@ unknown
end)()
result__166 = list_result__142
else
--@ compiler/compile.luma:191:11
if else__0 then
--@ compiler/compile.luma:191:12
local list_result__143
--@ compiler/compile.luma:192:74
invoke (emit__1, 5, "local ", fn_id__0, " = function (", invoke (comma_separate__0, 1, params__0), ")\
")
--@ compiler/compile.luma:193:25
index__0 = invoke_symbol (params__0, ".length", 0)
list_result__143 = true
--@ unknown
result__166 = list_result__143
else
result__166 = false
end
end
--@ compiler/compile.luma:194:52
return_value__0 = invoke (compile_exp__0, 2, invoke_symbol (param__369, ".body", 0), new_context__1)
--@ compiler/compile.luma:195:37
invoke (emit__1, 3, "return ", return_value__0, "\
")
--@ compiler/compile.luma:196:17
invoke (emit__1, 1, "end\
")
--@ compiler/compile.luma:197:10
list_result__140 = fn_id__0
--@ unknown
end)()
return list_result__140
end
compile_function__0 = fn__297
--@ compiler/compile.luma:199:31
local fn__299 = function (param__372, param__373)
local list_result__144
(function ()
local new_context__2, items__8, table_id__0, locals__1, fields__0, functions__0, methods__0, has_index__0
--@ compiler/compile.luma:200:34
new_context__2 = invoke (_context__0, 1, param__373)
--@ compiler/compile.luma:202:15
items__8 = invoke_symbol (param__372, ".items", 0)
--@ compiler/compile.luma:205:29
table_id__0 = invoke (gensym__0, 1, "table")
--@ compiler/compile.luma:207:32
invoke (emit__1, 3, "local ", table_id__0, "\
")
--@ compiler/compile.luma:209:19
locals__1 = invoke (_list__0, 0)
--@ compiler/compile.luma:210:25
local fn__300 = function (param__374)
--@ compiler/compile.luma:211:11
local result__168
--@ compiler/compile.luma:211:33
if invoke_symbol (_binding_node__0, ".?", 1, param__374) then
--@ compiler/compile.luma:211:35
local list_result__145
local id__3
--@ compiler/compile.luma:212:25
id__3 = invoke (gensym__0, 1, invoke_symbol (param__374, ".id", 0))
--@ compiler/compile.luma:213:23
invoke_symbol (locals__1, ".push", 1, id__3)
--@ compiler/compile.luma:214:35
list_result__145 = invoke_symbol (new_context__2, ".add", 2, invoke_symbol (param__374, ".id", 0), id__3)
--@ unknown
result__168 = list_result__145
else
result__168 = false
end
return result__168
end
invoke_symbol (items__8, ".each", 1, fn__300)
--@ compiler/compile.luma:215:9
local result__169
--@ compiler/compile.luma:215:21
if invoke (not__0, 1, invoke_symbol (locals__1, ".empty?", 0)) then
--@ compiler/compile.luma:216:49
result__169 = invoke (emit__1, 3, "local ", invoke (comma_separate__0, 1, locals__1), "\
")
else
result__169 = false
end
--@ compiler/compile.luma:219:19
fields__0 = invoke (_list__0, 0)
--@ compiler/compile.luma:220:22
functions__0 = invoke (_list__0, 0)
--@ compiler/compile.luma:221:20
methods__0 = invoke (_list__0, 0)
--@ compiler/compile.luma:222:21
has_index__0 = false
--@ compiler/compile.luma:223:25
local fn__301 = function (param__375)
--@ compiler/compile.luma:224:11
local result__170
--@ compiler/compile.luma:225:30
if invoke_symbol (_binding_node__0, ".?", 1, param__375) then
--@ compiler/compile.luma:225:32
local list_result__146
local id__4, compiled_value__2
--@ compiler/compile.luma:226:47
id__4 = invoke_symbol (new_context__2, ".lookup", 2, invoke_symbol (param__375, ".id", 0), invoke_symbol (param__375, ".location", 0))
--@ compiler/compile.luma:227:62
compiled_value__2 = invoke (compile_exp__0, 2, invoke_symbol (param__375, ".value", 0), new_context__2)
--@ compiler/compile.luma:228:44
list_result__146 = invoke (emit__1, 4, id__4, " = ", compiled_value__2, "\
")
--@ unknown
result__170 = list_result__146
else
--@ compiler/compile.luma:229:28
if invoke_symbol (_field_node__0, ".?", 1, param__375) then
--@ compiler/compile.luma:229:30
local list_result__147
local id__5
--@ compiler/compile.luma:230:49
id__5 = invoke (compile_exp__0, 2, invoke_symbol (param__375, ".value", 0), new_context__2)
--@ compiler/compile.luma:231:72
list_result__147 = invoke_symbol (fields__0, ".push", 1, invoke (_list__0, 5, "[", invoke (quote_string__0, 1, invoke_symbol (param__375, ".id", 0)), "] = ", id__5, ",\
"))
--@ unknown
result__170 = list_result__147
else
--@ compiler/compile.luma:232:31
if invoke_symbol (_function_node__0, ".?", 1, param__375) then
--@ compiler/compile.luma:232:33
local list_result__148
local fn_id__1, num_params__0
--@ compiler/compile.luma:233:51
fn_id__1 = invoke (compile_function__0, 2, param__375, new_context__2)
--@ compiler/compile.luma:234:27
num_params__0 = invoke_symbol (invoke_symbol (param__375, ".params", 0), ".length", 0)
--@ compiler/compile.luma:235:15
local result__171
--@ compiler/compile.luma:236:38
if invoke (is_function_vararg___0, 1, param__375) then
--@ compiler/compile.luma:237:60
result__171 = invoke_symbol (functions__0, ".push", 1, invoke (_list__0, 3, "[\"..\"] = ", fn_id__1, ",\
"))
else
--@ compiler/compile.luma:238:17
if else__0 then
--@ compiler/compile.luma:239:80
result__171 = invoke_symbol (functions__0, ".push", 1, invoke (_list__0, 5, "[", invoke_symbol (num_params__0, ".to-string", 0), "] = ", fn_id__1, ",\
"))
else
result__171 = false
end
end
list_result__148 = result__171
--@ unknown
result__170 = list_result__148
else
--@ compiler/compile.luma:240:38
if invoke_symbol (_symbol_function_node__0, ".?", 1, param__375) then
--@ compiler/compile.luma:240:40
local list_result__149
local fn_id__2
--@ compiler/compile.luma:241:51
fn_id__2 = invoke (compile_function__0, 2, param__375, new_context__2)
--@ compiler/compile.luma:242:82
list_result__149 = invoke_symbol (functions__0, ".push", 1, invoke (_list__0, 5, "[", invoke (quote_string__0, 1, invoke_symbol (param__375, ".symbol", 0)), "] = ", fn_id__2, ",\
"))
--@ unknown
result__170 = list_result__149
else
--@ compiler/compile.luma:243:36
if invoke_symbol (_symbol_method_node__0, ".?", 1, param__375) then
--@ compiler/compile.luma:243:38
local list_result__150
local fn_id__3
--@ compiler/compile.luma:244:51
fn_id__3 = invoke (compile_function__0, 2, param__375, new_context__2)
--@ compiler/compile.luma:245:80
list_result__150 = invoke_symbol (methods__0, ".push", 1, invoke (_list__0, 5, "[", invoke (quote_string__0, 1, invoke_symbol (param__375, ".symbol", 0)), "] = ", fn_id__3, ",\
"))
--@ unknown
result__170 = list_result__150
else
--@ compiler/compile.luma:246:13
if else__0 then
--@ compiler/compile.luma:246:14
local list_result__151
local index_id__0
--@ compiler/compile.luma:247:81
invoke (assert_at__0, 3, invoke (not__0, 1, has_index__0), param__375, "table cant have multiple index values")
--@ compiler/compile.luma:248:29
has_index__0 = true
--@ compiler/compile.luma:249:49
index_id__0 = invoke (compile_exp__0, 2, param__375, new_context__2)
--@ compiler/compile.luma:250:59
list_result__151 = invoke_symbol (fields__0, ".push", 1, invoke (_list__0, 3, "[\"index\"] = ", index_id__0, ",\
"))
--@ unknown
result__170 = list_result__151
else
result__170 = false
end
end
end
end
end
end
return result__170
end
invoke_symbol (items__8, ".each", 1, fn__301)
--@ compiler/compile.luma:253:27
invoke (emit__1, 2, table_id__0, " = {\
")
--@ compiler/compile.luma:254:16
invoke (emit__1, 1, fields__0)
--@ compiler/compile.luma:255:9
local result__172
--@ compiler/compile.luma:255:24
if invoke (not__0, 1, invoke_symbol (functions__0, ".empty?", 0)) then
--@ compiler/compile.luma:256:46
result__172 = invoke (emit__1, 3, "functions = {\
", functions__0, "},\
")
else
result__172 = false
end
--@ compiler/compile.luma:257:9
local result__173
--@ compiler/compile.luma:257:22
if invoke (not__0, 1, invoke_symbol (methods__0, ".empty?", 0)) then
--@ compiler/compile.luma:258:42
result__173 = invoke (emit__1, 3, "methods = {\
", methods__0, "},\
")
else
result__173 = false
end
--@ compiler/compile.luma:259:15
invoke (emit__1, 1, "}\
")
--@ compiler/compile.luma:260:27
invoke (set_location__0, 1, invoke_symbol (_location__0, ".unknown", 0))
--@ compiler/compile.luma:261:13
list_result__144 = table_id__0
--@ unknown
end)()
return list_result__144
end
compile_table__0 = fn__299
--@ compiler/compile.luma:263:29
local fn__302 = function (param__376, param__377)
local list_result__152
local result__174
--@ compiler/compile.luma:264:21
invoke (set_location__0, 1, invoke_symbol (param__376, ".location", 0))
--@ compiler/compile.luma:266:11
local result__175
--@ compiler/compile.luma:267:30
if invoke_symbol (_number_node__0, ".?", 1, param__376) then
--@ compiler/compile.luma:267:62
result__175 = invoke (compile_number__0, 2, param__376, param__377)
else
--@ compiler/compile.luma:268:30
if invoke_symbol (_string_node__0, ".?", 1, param__376) then
--@ compiler/compile.luma:268:62
result__175 = invoke (compile_string__0, 2, param__376, param__377)
else
--@ compiler/compile.luma:269:30
if invoke_symbol (_word_node__0, ".?", 1, param__376) then
--@ compiler/compile.luma:269:62
result__175 = invoke (compile_word__0, 2, param__376, param__377)
else
--@ compiler/compile.luma:270:30
if invoke_symbol (_apply_node__0, ".?", 1, param__376) then
--@ compiler/compile.luma:270:62
result__175 = invoke (compile_apply__0, 2, param__376, param__377)
else
--@ compiler/compile.luma:271:30
if invoke_symbol (_list_node__0, ".?", 1, param__376) then
--@ compiler/compile.luma:271:62
result__175 = invoke (compile_list__0, 2, param__376, param__377)
else
--@ compiler/compile.luma:272:30
if invoke_symbol (_function_node__0, ".?", 1, param__376) then
--@ compiler/compile.luma:272:62
result__175 = invoke (compile_function__0, 2, param__376, param__377)
else
--@ compiler/compile.luma:273:30
if invoke_symbol (_table_node__0, ".?", 1, param__376) then
--@ compiler/compile.luma:273:62
result__175 = invoke (compile_table__0, 2, param__376, param__377)
else
--@ compiler/compile.luma:274:13
if else__0 then
--@ compiler/compile.luma:274:79
result__175 = invoke (error_at__0, 2, param__376, invoke (combine_strings__0, 2, "unknown exp in compile-exp: ", invoke_symbol (param__376, ".to-string", 0)))
else
result__175 = false
end
end
end
end
end
end
end
end
result__174 = result__175
--@ compiler/compile.luma:275:9
local result__176
--@ compiler/compile.luma:275:35
local result__177 = invoke_symbol (_value__0, ".?", 1, result__174)
if not result__177 then
--@ compiler/compile.luma:275:62
result__177 = invoke_symbol (_primitive_node__0, ".?", 1, result__174)
end
if invoke (not__0, 1, result__177) then
--@ compiler/compile.luma:276:54
result__176 = invoke (error_at__0, 2, param__376, "compile-exp should return #value")
else
result__176 = false
end
--@ compiler/compile.luma:277:11
list_result__152 = result__174
--@ unknown
return list_result__152
end
compile_exp__0 = fn__302
--@ compiler/compile.luma:279:16
local list_result__153
(function ()
local context__0, add_macro__0, add_fn__0, add_lua_fn__0, add_type_check__0, add_binop__0
--@ compiler/compile.luma:280:23
context__0 = invoke (_context__0, 0)
--@ compiler/compile.luma:282:43
local fn__303 = function (param__378, param__379, param__380)
--@ compiler/compile.luma:285:27
local fn__304 = function (param__381, param__382)
local list_result__154
local args__2
--@ compiler/compile.luma:286:35
args__2 = invoke_symbol (invoke_symbol (param__381, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:287:38
local result__178 = invoke (not__0, 1, param__379)
if not result__178 then
--@ compiler/compile.luma:287:54
result__178 = invoke (___4, 2, param__379, invoke_symbol (args__2, ".length", 0))
end
--@ compiler/compile.luma:287:108
invoke (assert_at__0, 3, result__178, param__381, "wrong number of arguments to primitive")
--@ compiler/compile.luma:288:38
list_result__154 = invoke (param__380, 2, param__381, param__382)
--@ unknown
return list_result__154
end
return invoke_symbol (context__0, ".add", 2, param__378, invoke (_primitive_node__0, 1, fn__304))
end
add_macro__0 = fn__303
--@ compiler/compile.luma:290:37
local fn__305 = function (param__383, param__384, param__385)
--@ compiler/compile.luma:291:45
local fn__306 = function (param__386, param__387)
local list_result__155
local args__3, arg_values__0
--@ compiler/compile.luma:292:31
args__3 = invoke_symbol (invoke_symbol (param__386, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:293:38
local fn__307 = function (param__388)
--@ compiler/compile.luma:294:34
return invoke (compile_exp__0, 2, param__388, param__387)
end
arg_values__0 = invoke_symbol (args__3, ".map", 1, fn__307)
--@ compiler/compile.luma:295:30
list_result__155 = invoke (param__385, 1, arg_values__0)
--@ unknown
return list_result__155
end
return invoke (add_macro__0, 3, param__383, param__384, fn__306)
end
add_fn__0 = fn__305
--@ compiler/compile.luma:297:37
local fn__308 = function (param__389, param__390, param__391)
--@ compiler/compile.luma:298:36
local fn__309 = function (param__392)
local list_result__156
local result_id__1
--@ compiler/compile.luma:299:58
result_id__1 = invoke (gensym__0, 1, invoke (combine_strings__0, 2, param__389, "_result"))
--@ compiler/compile.luma:300:78
invoke (emit__1, 7, "local ", result_id__1, " = ", param__391, "(", invoke (comma_separate__0, 1, param__392), ")\
")
--@ compiler/compile.luma:301:18
list_result__156 = result_id__1
--@ unknown
return list_result__156
end
return invoke (add_fn__0, 3, param__389, param__390, fn__309)
end
add_lua_fn__0 = fn__308
--@ compiler/compile.luma:303:33
local fn__310 = function (param__393)
--@ compiler/compile.luma:304:27
return invoke_symbol (_value__0, ".simple", 1, "true")
end
invoke (add_fn__0, 3, "import", 1, fn__310)
--@ compiler/compile.luma:306:47
local fn__311 = function (param__394, param__395)
--@ compiler/compile.luma:307:27
return invoke_symbol (_value__0, ".simple", 1, "true")
end
invoke (add_macro__0, 3, "provide", false, fn__311)
--@ compiler/compile.luma:309:36
local fn__312 = function (param__396, param__397)
--@ compiler/compile.luma:310:31
local fn__313 = function (param__398)
local list_result__157
local result_id__2
--@ compiler/compile.luma:311:57
result_id__2 = invoke (gensym__0, 1, invoke (combine_strings__0, 2, param__396, "result"))
--@ compiler/compile.luma:312:82
invoke (emit__1, 7, "local ", result_id__2, " = type (", invoke_symbol (param__398, ".get", 1, 0), ") == \"", param__397, "\"\
")
--@ compiler/compile.luma:313:18
list_result__157 = result_id__2
--@ unknown
return list_result__157
end
return invoke (add_fn__0, 3, param__396, 1, fn__313)
end
add_type_check__0 = fn__312
--@ compiler/compile.luma:315:39
invoke (add_type_check__0, 2, "&string?", "string")
--@ compiler/compile.luma:316:39
invoke (add_type_check__0, 2, "&number?", "number")
--@ compiler/compile.luma:317:40
invoke (add_type_check__0, 2, "&bool?", "boolean")
--@ compiler/compile.luma:319:47
invoke (add_lua_fn__0, 3, "&value-to-string", 1, "tostring")
--@ compiler/compile.luma:320:48
invoke (add_lua_fn__0, 3, "&string-to-number", 1, "tonumber")
--@ compiler/compile.luma:322:41
local fn__314 = function (param__399)
local list_result__158
local result_id__3
--@ compiler/compile.luma:323:40
result_id__3 = invoke (gensym__0, 1, "concat_result")
--@ compiler/compile.luma:324:76
invoke (emit__1, 7, "local ", result_id__3, " = ", invoke_symbol (param__399, ".get", 1, 0), " .. ", invoke_symbol (param__399, ".get", 1, 1), "\
")
--@ compiler/compile.luma:325:16
list_result__158 = result_id__3
--@ unknown
return list_result__158
end
invoke (add_fn__0, 3, "&string-concat", 2, fn__314)
--@ compiler/compile.luma:327:41
local fn__315 = function (param__400)
local list_result__159
local result_id__4
--@ compiler/compile.luma:328:40
result_id__4 = invoke (gensym__0, 1, "length_result")
--@ compiler/compile.luma:329:56
invoke (emit__1, 5, "local ", result_id__4, " = #", invoke_symbol (param__400, ".get", 1, 0), "\
")
--@ compiler/compile.luma:330:16
list_result__159 = result_id__4
--@ unknown
return list_result__159
end
invoke (add_fn__0, 3, "&string-length", 1, fn__315)
--@ compiler/compile.luma:332:44
local fn__316 = function (param__401)
local list_result__160
local result_id__5
--@ compiler/compile.luma:333:43
result_id__5 = invoke (gensym__0, 1, "substring_result")
--@ compiler/compile.luma:334:102
invoke (emit__1, 9, "local ", result_id__5, " = ", invoke_symbol (param__401, ".get", 1, 0), ":sub (", invoke_symbol (param__401, ".get", 1, 1), " + 1, ", invoke_symbol (param__401, ".get", 1, 2), ")\
")
--@ compiler/compile.luma:335:16
list_result__160 = result_id__5
--@ unknown
return list_result__160
end
invoke (add_fn__0, 3, "&string-substring", 3, fn__316)
--@ compiler/compile.luma:337:40
local fn__317 = function (param__402)
local list_result__161
local result_id__6, char_pattern__0
--@ compiler/compile.luma:338:41
result_id__6 = invoke (gensym__0, 1, "char_at_result")
--@ compiler/compile.luma:339:65
char_pattern__0 = "\"^[%z\\01-\\127\\194-\\244][\\128-\\191]*\""
--@ compiler/compile.luma:340:103
invoke (emit__1, 9, "local ", result_id__6, " = ", invoke_symbol (param__402, ".get", 1, 0), ":match (", char_pattern__0, ", ", invoke_symbol (param__402, ".get", 1, 1), " + 1)\
")
--@ compiler/compile.luma:341:84
invoke (emit__1, 3, "assert (", result_id__6, ", \"couldnt find next utf8 character in string\")\
")
--@ compiler/compile.luma:342:16
list_result__161 = result_id__6
--@ unknown
return list_result__161
end
invoke (add_fn__0, 3, "&utf8-char-at", 2, fn__317)
--@ compiler/compile.luma:344:44
local fn__318 = function (param__403)
local list_result__162
local result_id__7
--@ compiler/compile.luma:345:42
result_id__7 = invoke (gensym__0, 1, "contains_result")
--@ compiler/compile.luma:346:96
invoke (emit__1, 7, "local ", result_id__7, " = ", invoke_symbol (param__403, ".get", 1, 0), ":find (", invoke_symbol (param__403, ".get", 1, 1), ", 1, true) ~= nil\
")
--@ compiler/compile.luma:347:16
list_result__162 = result_id__7
--@ unknown
return list_result__162
end
invoke (add_fn__0, 3, "&string-contains?", 2, fn__318)
--@ compiler/compile.luma:349:40
local fn__319 = function (param__404)
local list_result__163
local result_id__8
--@ compiler/compile.luma:350:39
result_id__8 = invoke (gensym__0, 1, "quote_result")
--@ compiler/compile.luma:351:77
invoke (emit__1, 5, "local ", result_id__8, " = string.format (\"%q\", ", invoke_symbol (param__404, ".get", 1, 0), ")\
")
--@ compiler/compile.luma:352:16
list_result__163 = result_id__8
--@ unknown
return list_result__163
end
invoke (add_fn__0, 3, "&quote-string", 1, fn__319)
--@ compiler/compile.luma:354:43
local fn__320 = function (param__405)
local list_result__164
local result_id__9
--@ compiler/compile.luma:355:41
result_id__9 = invoke (gensym__0, 1, "safe_id_result")
--@ compiler/compile.luma:356:91
invoke (emit__1, 5, "local ", result_id__9, " = string.gsub (", invoke_symbol (param__405, ".get", 1, 0), ", \"[^a-zA-Z0-9_]\", \"_\")\
")
--@ compiler/compile.luma:357:95
invoke (emit__1, 7, "if ", result_id__9, ":match (\"^[0-9]\") then ", result_id__9, " = \"_\" .. ", result_id__9, " end\
")
--@ compiler/compile.luma:358:16
list_result__164 = result_id__9
--@ unknown
return list_result__164
end
invoke (add_fn__0, 3, "&safe-identifier", 1, fn__320)
--@ compiler/compile.luma:360:37
local fn__321 = function (param__406)
local list_result__165
(function ()
local file_id__0, result_id__10
--@ compiler/compile.luma:361:29
file_id__0 = invoke (gensym__0, 1, "file")
--@ compiler/compile.luma:362:38
result_id__10 = invoke (gensym__0, 1, "read_result")
--@ compiler/compile.luma:363:77
invoke (emit__1, 5, "local ", file_id__0, " = assert (io.open (", invoke_symbol (param__406, ".get", 1, 0), ", \"r\"))\
")
--@ compiler/compile.luma:364:61
invoke (emit__1, 5, "local ", result_id__10, " = ", file_id__0, ":read (\"*a\")\
")
--@ compiler/compile.luma:365:33
invoke (emit__1, 2, file_id__0, ":close ()\
")
--@ compiler/compile.luma:366:16
list_result__165 = result_id__10
--@ unknown
end)()
return list_result__165
end
invoke (add_fn__0, 3, "&read-file", 1, fn__321)
--@ compiler/compile.luma:368:38
local fn__322 = function (param__407)
local list_result__166
(function ()
local file_id__1, result_id__11
--@ compiler/compile.luma:369:29
file_id__1 = invoke (gensym__0, 1, "file")
--@ compiler/compile.luma:370:38
result_id__11 = invoke (gensym__0, 1, "read_result")
--@ compiler/compile.luma:371:77
invoke (emit__1, 5, "local ", file_id__1, " = assert (io.open (", invoke_symbol (param__407, ".get", 1, 0), ", \"w\"))\
")
--@ compiler/compile.luma:372:50
invoke (emit__1, 4, file_id__1, ":write (", invoke_symbol (param__407, ".get", 1, 1), ")\
")
--@ compiler/compile.luma:373:33
invoke (emit__1, 2, file_id__1, ":close ()\
")
--@ compiler/compile.luma:374:27
list_result__166 = invoke_symbol (_value__0, ".simple", 1, "true")
--@ unknown
end)()
return list_result__166
end
invoke (add_fn__0, 3, "&write-file", 2, fn__322)
--@ compiler/compile.luma:376:27
local fn__323 = function (param__408, param__409)
--@ compiler/compile.luma:377:29
local fn__324 = function (param__410)
local list_result__167
local id__6
--@ compiler/compile.luma:378:32
id__6 = invoke (gensym__0, 1, "op_result")
--@ compiler/compile.luma:379:79
invoke (emit__1, 9, "local ", id__6, " = ", invoke_symbol (param__410, ".get", 1, 0), " ", param__409, " ", invoke_symbol (param__410, ".get", 1, 1), "\
")
--@ compiler/compile.luma:380:11
list_result__167 = id__6
--@ unknown
return list_result__167
end
return invoke (add_fn__0, 3, param__408, 2, fn__324)
end
add_binop__0 = fn__323
--@ compiler/compile.luma:382:23
invoke (add_binop__0, 2, "&+", "+")
--@ compiler/compile.luma:383:23
invoke (add_binop__0, 2, "&-", "-")
--@ compiler/compile.luma:384:23
invoke (add_binop__0, 2, "&*", "*")
--@ compiler/compile.luma:385:23
invoke (add_binop__0, 2, "&/", "/")
--@ compiler/compile.luma:386:24
invoke (add_binop__0, 2, "&=", "==")
--@ compiler/compile.luma:387:25
invoke (add_binop__0, 2, "&~=", "~=")
--@ compiler/compile.luma:388:23
invoke (add_binop__0, 2, "&<", "<")
--@ compiler/compile.luma:389:23
invoke (add_binop__0, 2, "&>", ">")
--@ compiler/compile.luma:390:25
invoke (add_binop__0, 2, "&<=", "<=")
--@ compiler/compile.luma:391:25
invoke (add_binop__0, 2, "&>=", ">=")
--@ compiler/compile.luma:393:45
invoke_symbol (context__0, ".add", 2, "true", invoke_symbol (_value__0, ".simple", 1, "true"))
--@ compiler/compile.luma:394:47
invoke_symbol (context__0, ".add", 2, "false", invoke_symbol (_value__0, ".simple", 1, "false"))
--@ compiler/compile.luma:396:47
invoke_symbol (context__0, ".add", 2, "print", invoke_symbol (_value__0, ".simple", 1, "print"))
--@ compiler/compile.luma:398:25
invoke (add_binop__0, 2, "is?", "==")
--@ compiler/compile.luma:400:39
local fn__325 = function (param__411, param__412)
local list_result__168
local args__4, target__0, val_exp__0, value_id__0
--@ compiler/compile.luma:401:29
args__4 = invoke_symbol (invoke_symbol (param__411, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:402:25
target__0 = invoke_symbol (args__4, ".get", 1, 0)
--@ compiler/compile.luma:403:26
val_exp__0 = invoke_symbol (args__4, ".get", 1, 1)
--@ compiler/compile.luma:404:44
value_id__0 = invoke (compile_exp__0, 2, val_exp__0, param__412)
--@ compiler/compile.luma:405:11
local result__179
--@ compiler/compile.luma:406:29
if invoke_symbol (_word_node__0, ".?", 1, target__0) then
--@ compiler/compile.luma:406:31
local list_result__169
local target_id__0
--@ compiler/compile.luma:408:53
target_id__0 = invoke_symbol (param__412, ".lookup", 2, invoke_symbol (target__0, ".id", 0), invoke_symbol (target__0, ".location", 0))
--@ compiler/compile.luma:409:45
invoke (emit__1, 4, target_id__0, " = ", value_id__0, "\
")
--@ compiler/compile.luma:410:31
list_result__169 = invoke_symbol (_value__0, ".simple", 1, "true")
--@ unknown
result__179 = list_result__169
else
--@ compiler/compile.luma:411:35
local result__180 = invoke_symbol (_apply_node__0, ".?", 1, target__0)
if result__180 then
--@ compiler/compile.luma:411:53
local result__181 = invoke (___4, 2, 2, invoke_symbol (invoke_symbol (target__0, ".items", 0), ".length", 0))
if result__181 then
--@ compiler/compile.luma:411:103
result__181 = invoke_symbol (_symbol_node__0, ".?", 1, invoke_symbol (invoke_symbol (target__0, ".items", 0), ".get", 1, 1))
end
result__180 = result__181
end
if result__180 then
--@ compiler/compile.luma:411:108
local list_result__170
local target_obj_id__0, sym_id__0
--@ compiler/compile.luma:413:66
target_obj_id__0 = invoke (compile_exp__0, 2, invoke_symbol (invoke_symbol (target__0, ".items", 0), ".get", 1, 0), param__412)
--@ compiler/compile.luma:414:38
sym_id__0 = invoke_symbol (invoke_symbol (invoke_symbol (target__0, ".items", 0), ".get", 1, 1), ".id", 0)
--@ compiler/compile.luma:415:64
invoke (emit__1, 6, target_obj_id__0, " [\"", sym_id__0, "\"] = ", value_id__0, "\
")
--@ compiler/compile.luma:416:31
list_result__170 = invoke_symbol (_value__0, ".simple", 1, "true")
--@ unknown
result__179 = list_result__170
else
--@ compiler/compile.luma:418:13
if else__0 then
--@ compiler/compile.luma:418:80
result__179 = invoke (error_at__0, 2, target__0, invoke (combine_strings__0, 2, "unknown target in set: ", invoke_symbol (target__0, ".to-string", 0)))
else
result__179 = false
end
end
end
list_result__168 = result__179
--@ unknown
return list_result__168
end
invoke (add_macro__0, 3, "set", 2, fn__325)
--@ compiler/compile.luma:420:38
local fn__326 = function (param__413, param__414)
local list_result__171
(function ()
local args__5, num_args__0, condition_id__0, result_id__12
--@ compiler/compile.luma:421:29
args__5 = invoke_symbol (invoke_symbol (param__413, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:422:21
num_args__0 = invoke_symbol (args__5, ".length", 0)
--@ compiler/compile.luma:423:53
condition_id__0 = invoke (compile_exp__0, 2, invoke_symbol (args__5, ".get", 1, 0), param__414)
--@ compiler/compile.luma:424:33
result_id__12 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:425:35
invoke (emit__1, 3, "local ", result_id__12, "\
")
--@ compiler/compile.luma:426:40
invoke (emit__1, 3, "if ", condition_id__0, " then\
")
--@ compiler/compile.luma:427:67
invoke (emit__1, 4, result_id__12, " = ", invoke (compile_exp__0, 2, invoke_symbol (args__5, ".get", 1, 1), param__414), "\
")
--@ compiler/compile.luma:428:20
invoke (emit__1, 1, "else\
")
--@ compiler/compile.luma:429:67
invoke (emit__1, 4, result_id__12, " = ", invoke (compile_exp__0, 2, invoke_symbol (args__5, ".get", 1, 2), param__414), "\
")
--@ compiler/compile.luma:430:19
invoke (emit__1, 1, "end\
")
--@ compiler/compile.luma:431:16
list_result__171 = result_id__12
--@ unknown
end)()
return list_result__171
end
invoke (add_macro__0, 3, "if", 3, fn__326)
--@ compiler/compile.luma:433:44
local fn__327 = function (param__415, param__416)
local list_result__172
(function ()
local args__6, result_id__13, compile_branch__0
--@ compiler/compile.luma:434:29
args__6 = invoke_symbol (invoke_symbol (param__415, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:435:33
result_id__13 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:436:35
invoke (emit__1, 3, "local ", result_id__13, "\
")
--@ compiler/compile.luma:437:52
invoke (assert_at__0, 3, invoke_symbol (invoke_symbol (args__6, ".length", 0), ".>", 1, 0), param__415, "empty when")
--@ compiler/compile.luma:438:29
local fn__328 = function (param__417)
local list_result__173
(function ()
local first__4, condition_id__1
--@ compiler/compile.luma:439:20
first__4 = invoke_symbol (param__417, ".item", 0)
--@ compiler/compile.luma:440:13
invoke_symbol (param__417, ".advance", 0)
--@ compiler/compile.luma:441:66
invoke (assert_at__0, 3, invoke_symbol (_pair_node__0, ".?", 1, first__4), first__4, "when expects pairs")
--@ compiler/compile.luma:442:52
condition_id__1 = invoke (compile_exp__0, 2, invoke_symbol (first__4, ".key", 0), param__416)
--@ compiler/compile.luma:443:42
invoke (emit__1, 3, "if ", condition_id__1, " then\
")
--@ compiler/compile.luma:444:68
invoke (emit__1, 4, result_id__13, " = ", invoke (compile_exp__0, 2, invoke_symbol (first__4, ".value", 0), param__416), "\
")
--@ compiler/compile.luma:445:22
invoke (emit__1, 1, "else\
")
--@ compiler/compile.luma:446:21
local result__182
if invoke (not__0, 1, invoke_symbol (param__417, ".empty?", 0)) then
--@ compiler/compile.luma:447:30
result__182 = invoke (compile_branch__0, 1, param__417)
else
--@ compiler/compile.luma:448:38
result__182 = invoke (emit__1, 2, result_id__13, " = false\
")
end
--@ compiler/compile.luma:449:21
list_result__173 = invoke (emit__1, 1, "end\
")
--@ unknown
end)()
return list_result__173
end
compile_branch__0 = fn__328
--@ compiler/compile.luma:450:27
invoke (compile_branch__0, 1, invoke_symbol (args__6, ".iterator", 0))
--@ compiler/compile.luma:451:16
list_result__172 = result_id__13
--@ unknown
end)()
return list_result__172
end
invoke (add_macro__0, 3, "when", false, fn__327)
--@ compiler/compile.luma:453:56
invoke_symbol (context__0, ".add", 2, "cond", invoke_symbol (context__0, ".lookup", 2, "when", invoke_symbol (_location__0, ".unknown", 0)))
--@ compiler/compile.luma:455:41
local fn__329 = function (param__418, param__419)
local list_result__174
(function ()
local args__7, condition_id__2, first__5
--@ compiler/compile.luma:456:29
args__7 = invoke_symbol (invoke_symbol (param__418, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:457:45
condition_id__2 = invoke (gensym__0, 1, "while_condition")
--@ compiler/compile.luma:458:53
invoke (assert_at__0, 3, invoke_symbol (invoke_symbol (args__7, ".length", 0), ".>", 1, 0), param__418, "empty while")
--@ compiler/compile.luma:459:24
first__5 = invoke_symbol (args__7, ".get", 1, 0)
--@ compiler/compile.luma:460:66
invoke (assert_at__0, 3, invoke_symbol (_pair_node__0, ".?", 1, first__5), first__5, "while expects a pair")
--@ compiler/compile.luma:461:76
invoke (emit__1, 5, "local ", condition_id__2, " = ", invoke (compile_exp__0, 2, invoke_symbol (first__5, ".key", 0), param__419), "\
")
--@ compiler/compile.luma:462:41
invoke (emit__1, 3, "while ", condition_id__2, " do\
")
--@ compiler/compile.luma:463:63
invoke (emit__1, 3, "local _ = ", invoke (compile_exp__0, 2, invoke_symbol (first__5, ".value", 0), param__419), "\
")
--@ compiler/compile.luma:464:67
invoke (emit__1, 4, condition_id__2, " = ", invoke (compile_exp__0, 2, invoke_symbol (first__5, ".key", 0), param__419), "\
")
--@ compiler/compile.luma:465:19
invoke (emit__1, 1, "end\
")
--@ compiler/compile.luma:466:28
list_result__174 = invoke_symbol (_value__0, ".simple", 1, "false")
--@ unknown
end)()
return list_result__174
end
invoke (add_macro__0, 3, "while", 1, fn__329)
--@ compiler/compile.luma:468:39
local fn__330 = function (param__420, param__421)
local list_result__175
(function ()
local args__8, condition_id__3, result_id__14, second_condition_id__0
--@ compiler/compile.luma:469:29
args__8 = invoke_symbol (invoke_symbol (param__420, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:470:53
condition_id__3 = invoke (compile_exp__0, 2, invoke_symbol (args__8, ".get", 1, 0), param__421)
--@ compiler/compile.luma:471:33
result_id__14 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:472:54
invoke (emit__1, 5, "local ", result_id__14, " = ", condition_id__3, "\
")
--@ compiler/compile.luma:473:37
invoke (emit__1, 3, "if ", result_id__14, " then\
")
--@ compiler/compile.luma:474:60
second_condition_id__0 = invoke (compile_exp__0, 2, invoke_symbol (args__8, ".get", 1, 1), param__421)
--@ compiler/compile.luma:475:52
invoke (emit__1, 4, result_id__14, " = ", second_condition_id__0, "\
")
--@ compiler/compile.luma:476:19
invoke (emit__1, 1, "end\
")
--@ compiler/compile.luma:477:16
list_result__175 = result_id__14
--@ unknown
end)()
return list_result__175
end
invoke (add_macro__0, 3, "and", 2, fn__330)
--@ compiler/compile.luma:479:38
local fn__331 = function (param__422, param__423)
local list_result__176
(function ()
local args__9, condition_id__4, result_id__15, second_condition_id__1
--@ compiler/compile.luma:480:29
args__9 = invoke_symbol (invoke_symbol (param__422, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:481:53
condition_id__4 = invoke (compile_exp__0, 2, invoke_symbol (args__9, ".get", 1, 0), param__423)
--@ compiler/compile.luma:482:33
result_id__15 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:483:54
invoke (emit__1, 5, "local ", result_id__15, " = ", condition_id__4, "\
")
--@ compiler/compile.luma:484:41
invoke (emit__1, 3, "if not ", result_id__15, " then\
")
--@ compiler/compile.luma:485:60
second_condition_id__1 = invoke (compile_exp__0, 2, invoke_symbol (args__9, ".get", 1, 1), param__423)
--@ compiler/compile.luma:486:52
invoke (emit__1, 4, result_id__15, " = ", second_condition_id__1, "\
")
--@ compiler/compile.luma:487:19
invoke (emit__1, 1, "end\
")
--@ compiler/compile.luma:488:16
list_result__176 = result_id__15
--@ unknown
end)()
return list_result__176
end
invoke (add_macro__0, 3, "or", 2, fn__331)
--@ compiler/compile.luma:490:40
local fn__332 = function (param__424, param__425)
local list_result__177
(function ()
local args__10, table__75, item__0, result_id__16
--@ compiler/compile.luma:494:29
args__10 = invoke_symbol (invoke_symbol (param__424, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:495:46
table__75 = invoke (compile_exp__0, 2, invoke_symbol (args__10, ".get", 1, 0), param__425)
--@ compiler/compile.luma:497:45
item__0 = invoke (compile_exp__0, 2, invoke_symbol (args__10, ".get", 1, 1), param__425)
--@ compiler/compile.luma:498:33
result_id__16 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:499:129
invoke (emit__1, 13, "local ", result_id__16, " = type (", table__75, ") == \"table\" and (", table__75, ".index == ", item__0, " or ", table__75, "[", item__0, "] ~= nil)\
")
--@ compiler/compile.luma:500:16
list_result__177 = result_id__16
--@ unknown
end)()
return list_result__177
end
invoke (add_macro__0, 3, "has?", 2, fn__332)
--@ compiler/compile.luma:502:37
invoke (add_lua_fn__0, 3, "&sqrt", 1, "math.sqrt")
--@ compiler/compile.luma:503:39
invoke (add_lua_fn__0, 3, "assert", false, "assert")
--@ compiler/compile.luma:504:54
invoke (add_lua_fn__0, 3, "&get-time", false, "love.timer.getTime")
--@ compiler/compile.luma:506:45
local fn__333 = function (param__426, param__427)
local list_result__178
local args__11, result_id__17
--@ compiler/compile.luma:507:29
args__11 = invoke_symbol (invoke_symbol (param__426, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:508:33
result_id__17 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:509:36
invoke (emit__1, 3, "local ", result_id__17, " = ")
--@ compiler/compile.luma:510:11
local result__183
--@ compiler/compile.luma:511:26
if invoke_symbol (invoke_symbol (args__11, ".length", 0), ".=", 1, 0) then
--@ compiler/compile.luma:512:24
result__183 = invoke (emit__1, 1, "#arg\
")
else
--@ compiler/compile.luma:513:13
if else__0 then
--@ compiler/compile.luma:513:14
local list_result__179
local index__1
--@ compiler/compile.luma:514:50
index__1 = invoke (compile_exp__0, 2, invoke_symbol (args__11, ".get", 1, 0), param__427)
--@ compiler/compile.luma:515:44
list_result__179 = invoke (emit__1, 3, "arg [", index__1, "] or false\
")
--@ unknown
result__183 = list_result__179
else
result__183 = false
end
end
--@ compiler/compile.luma:516:16
list_result__178 = result_id__17
--@ unknown
return list_result__178
end
invoke (add_macro__0, 3, "&args", false, fn__333)
--@ compiler/compile.luma:518:44
local fn__334 = function (param__428, param__429)
local list_result__180
local args__12, str__1
--@ compiler/compile.luma:519:29
args__12 = invoke_symbol (invoke_symbol (param__428, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:520:22
str__1 = invoke_symbol (args__12, ".get", 1, 0)
--@ compiler/compile.luma:521:75
invoke (assert_at__0, 3, invoke_symbol (_string_node__0, ".?", 1, str__1), str__1, "&lua-get expects string literal")
--@ compiler/compile.luma:522:17
list_result__180 = invoke (_value__0, 1, invoke_symbol (str__1, ".value", 0))
--@ unknown
return list_result__180
end
invoke (add_macro__0, 3, "&lua-get", 1, fn__334)
--@ compiler/compile.luma:524:44
local fn__335 = function (param__430, param__431)
local list_result__181
(function ()
local args__13, str__2, val__0
--@ compiler/compile.luma:525:29
args__13 = invoke_symbol (invoke_symbol (param__430, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:526:22
str__2 = invoke_symbol (args__13, ".get", 1, 0)
--@ compiler/compile.luma:527:22
val__0 = invoke_symbol (args__13, ".get", 1, 1)
--@ compiler/compile.luma:528:75
invoke (assert_at__0, 3, invoke_symbol (_string_node__0, ".?", 1, str__2), str__2, "&lua-set expects string literal")
--@ compiler/compile.luma:529:58
invoke (emit__1, 4, invoke_symbol (str__2, ".value", 0), " = ", invoke (compile_exp__0, 2, val__0, param__431), "\
")
--@ compiler/compile.luma:530:28
list_result__181 = invoke_symbol (_value__0, ".simple", 1, "false")
--@ unknown
end)()
return list_result__181
end
invoke (add_macro__0, 3, "&lua-set", 2, fn__335)
--@ compiler/compile.luma:532:51
local fn__336 = function (param__432, param__433)
local list_result__182
(function ()
local args__14, table__76, index__2, result_id__18
--@ compiler/compile.luma:533:29
args__14 = invoke_symbol (invoke_symbol (param__432, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:534:47
table__76 = invoke (compile_exp__0, 2, invoke_symbol (args__14, ".get", 1, 0), param__433)
--@ compiler/compile.luma:535:47
index__2 = invoke (compile_exp__0, 2, invoke_symbol (args__14, ".get", 1, 1), param__433)
--@ compiler/compile.luma:536:33
result_id__18 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:537:66
invoke (emit__1, 7, "local ", result_id__18, " = ", table__76, " [", index__2, "] ~= nil\
")
--@ compiler/compile.luma:538:16
list_result__182 = result_id__18
--@ unknown
end)()
return list_result__182
end
invoke (add_macro__0, 3, "&lua-has-index?", 2, fn__336)
--@ compiler/compile.luma:540:50
local fn__337 = function (param__434, param__435)
local list_result__183
(function ()
local args__15, table__77, index__3, result_id__19
--@ compiler/compile.luma:541:29
args__15 = invoke_symbol (invoke_symbol (param__434, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:542:47
table__77 = invoke (compile_exp__0, 2, invoke_symbol (args__15, ".get", 1, 0), param__435)
--@ compiler/compile.luma:543:47
index__3 = invoke (compile_exp__0, 2, invoke_symbol (args__15, ".get", 1, 1), param__435)
--@ compiler/compile.luma:544:33
result_id__19 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:545:59
invoke (emit__1, 7, "local ", result_id__19, " = ", table__77, " [", index__3, "]\
")
--@ compiler/compile.luma:546:70
invoke (emit__1, 3, "assert (", result_id__19, " ~= nil, \"getting invalid index\")\
")
--@ compiler/compile.luma:547:16
list_result__183 = result_id__19
--@ unknown
end)()
return list_result__183
end
invoke (add_macro__0, 3, "&lua-get-index", 2, fn__337)
--@ compiler/compile.luma:549:50
local fn__338 = function (param__436, param__437)
local list_result__184
(function ()
local args__16, table__78, index__4, value__3
--@ compiler/compile.luma:550:29
args__16 = invoke_symbol (invoke_symbol (param__436, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:551:47
table__78 = invoke (compile_exp__0, 2, invoke_symbol (args__16, ".get", 1, 0), param__437)
--@ compiler/compile.luma:552:47
index__4 = invoke (compile_exp__0, 2, invoke_symbol (args__16, ".get", 1, 1), param__437)
--@ compiler/compile.luma:553:47
value__3 = invoke (compile_exp__0, 2, invoke_symbol (args__16, ".get", 1, 2), param__437)
--@ compiler/compile.luma:554:46
invoke (emit__1, 6, table__78, " [", index__4, "] = ", value__3, "\
")
--@ compiler/compile.luma:555:28
list_result__184 = invoke_symbol (_value__0, ".simple", 1, "false")
--@ unknown
end)()
return list_result__184
end
invoke (add_macro__0, 3, "&lua-set-index", 3, fn__338)
--@ compiler/compile.luma:557:53
local fn__339 = function (param__438, param__439)
local list_result__185
local args__17, table__79, index__5
--@ compiler/compile.luma:558:29
args__17 = invoke_symbol (invoke_symbol (param__438, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:559:47
table__79 = invoke (compile_exp__0, 2, invoke_symbol (args__17, ".get", 1, 0), param__439)
--@ compiler/compile.luma:560:47
index__5 = invoke (compile_exp__0, 2, invoke_symbol (args__17, ".get", 1, 1), param__439)
--@ compiler/compile.luma:561:40
invoke (emit__1, 4, table__79, " [", index__5, "] = nil\
")
--@ compiler/compile.luma:562:28
list_result__185 = invoke_symbol (_value__0, ".simple", 1, "false")
--@ unknown
return list_result__185
end
invoke (add_macro__0, 3, "&lua-remove-index", 2, fn__339)
--@ compiler/compile.luma:564:60
local fn__340 = function (param__440, param__441)
local list_result__186
(function ()
local args__18, table__80, result_id__20, index__6
--@ compiler/compile.luma:565:29
args__18 = invoke_symbol (invoke_symbol (param__440, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:566:47
table__80 = invoke (compile_exp__0, 2, invoke_symbol (args__18, ".get", 1, 0), param__441)
--@ compiler/compile.luma:567:33
result_id__20 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:568:34
local result__184
if invoke_symbol (invoke_symbol (args__18, ".length", 0), ".=", 1, 1) then
--@ compiler/compile.luma:569:14
result__184 = "nil"
else
--@ compiler/compile.luma:570:42
result__184 = invoke (compile_exp__0, 2, invoke_symbol (args__18, ".get", 1, 1), param__441)
end
index__6 = result__184
--@ compiler/compile.luma:571:72
invoke (emit__1, 7, "local ", result_id__20, " = next (", table__80, ", ", index__6, ") ~= nil\
")
--@ compiler/compile.luma:572:16
list_result__186 = result_id__20
--@ unknown
end)()
return list_result__186
end
invoke (add_macro__0, 3, "&lua-has-next-index?", false, fn__340)
--@ compiler/compile.luma:574:55
local fn__341 = function (param__442, param__443)
local list_result__187
(function ()
local args__19, table__81, result_id__21, index__7
--@ compiler/compile.luma:575:29
args__19 = invoke_symbol (invoke_symbol (param__442, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:576:47
table__81 = invoke (compile_exp__0, 2, invoke_symbol (args__19, ".get", 1, 0), param__443)
--@ compiler/compile.luma:577:33
result_id__21 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:578:34
local result__185
if invoke_symbol (invoke_symbol (args__19, ".length", 0), ".=", 1, 1) then
--@ compiler/compile.luma:579:14
result__185 = "nil"
else
--@ compiler/compile.luma:580:42
result__185 = invoke (compile_exp__0, 2, invoke_symbol (args__19, ".get", 1, 1), param__443)
end
index__7 = result__185
--@ compiler/compile.luma:581:65
invoke (emit__1, 7, "local ", result_id__21, " = next (", table__81, ", ", index__7, ")\
")
--@ compiler/compile.luma:582:60
invoke (emit__1, 3, "assert (", result_id__21, " ~= nil, \"no next index\")")
--@ compiler/compile.luma:583:16
list_result__187 = result_id__21
--@ unknown
end)()
return list_result__187
end
invoke (add_macro__0, 3, "&lua-next-index", false, fn__341)
--@ compiler/compile.luma:585:47
local fn__342 = function (param__444, param__445)
local list_result__188
(function ()
local arg__0, table__82, result_id__22
--@ compiler/compile.luma:586:27
arg__0 = invoke_symbol (invoke_symbol (param__444, ".items", 0), ".get", 1, 1)
--@ compiler/compile.luma:587:38
table__82 = invoke (compile_exp__0, 2, arg__0, param__445)
--@ compiler/compile.luma:588:33
result_id__22 = invoke (gensym__0, 1, "result")
--@ compiler/compile.luma:589:35
invoke (emit__1, 3, "local ", result_id__22, "\
")
--@ compiler/compile.luma:590:43
invoke (emit__1, 3, "if ", table__82, "[0] == nil then\
")
--@ compiler/compile.luma:591:31
invoke (emit__1, 2, result_id__22, " = \"\"\
")
--@ compiler/compile.luma:592:20
invoke (emit__1, 1, "else\
")
--@ compiler/compile.luma:593:70
invoke (emit__1, 6, result_id__22, " = ", table__82, " [0] .. table.concat (", table__82, ")\
")
--@ compiler/compile.luma:594:19
invoke (emit__1, 1, "end\
")
--@ compiler/compile.luma:595:16
list_result__188 = result_id__22
--@ unknown
end)()
return list_result__188
end
invoke (add_macro__0, 3, "&lua-concat", 1, fn__342)
--@ compiler/compile.luma:597:47
local fn__343 = function (param__446, param__447)
local list_result__189
local arg__1, result_id__23
--@ compiler/compile.luma:598:27
arg__1 = invoke_symbol (invoke_symbol (param__446, ".items", 0), ".get", 1, 1)
--@ compiler/compile.luma:599:81
invoke (assert_at__0, 3, invoke_symbol (_string_node__0, ".?", 1, arg__1), arg__1, "&embed expects string literal as path")
--@ compiler/compile.luma:600:42
result_id__23 = invoke (gensym__0, 1, "embedded_string")
--@ compiler/compile.luma:601:78
invoke (emit__1, 5, "local ", result_id__23, " = ", invoke (quote_string__0, 1, invoke (read_file__0, 1, invoke_symbol (arg__1, ".value", 0))), "\
")
--@ compiler/compile.luma:602:16
list_result__189 = result_id__23
--@ unknown
return list_result__189
end
invoke (add_macro__0, 3, "&embed-file", 1, fn__343)
--@ compiler/compile.luma:604:43
local fn__344 = function (param__448, param__449)
local list_result__190
(function ()
local items__9, fields__1
--@ compiler/compile.luma:606:78
invoke (assert_at__0, 3, invoke (____1, 2, 2, invoke_symbol (invoke_symbol (param__448, ".items", 0), ".length", 0)), param__448, "new takes at least one argument")
--@ compiler/compile.luma:607:20
items__9 = invoke (_list__0, 0)
--@ compiler/compile.luma:608:31
fields__1 = invoke_symbol (invoke_symbol (param__448, ".items", 0), ".drop", 1, 1)
--@ compiler/compile.luma:609:11
local result__186
--@ compiler/compile.luma:609:44
if invoke (not__0, 1, invoke_symbol (_pair_node__0, ".?", 1, invoke_symbol (fields__1, ".get", 1, 0))) then
--@ compiler/compile.luma:609:48
local list_result__191
--@ compiler/compile.luma:610:33
invoke_symbol (items__9, ".push", 1, invoke_symbol (fields__1, ".get", 1, 0))
--@ compiler/compile.luma:611:34
fields__1 = invoke_symbol (fields__1, ".drop", 1, 1)
list_result__191 = true
--@ unknown
result__186 = list_result__191
else
result__186 = false
end
--@ compiler/compile.luma:613:29
local fn__345 = function (param__450)
local list_result__192
--@ compiler/compile.luma:614:84
invoke (assert_at__0, 3, invoke_symbol (_pair_node__0, ".?", 1, param__450), param__450, "new takes pairs after first argument")
--@ compiler/compile.luma:616:13
local result__187
--@ compiler/compile.luma:617:30
if invoke_symbol (_word_node__0, ".?", 1, invoke_symbol (param__450, ".key", 0)) then
--@ compiler/compile.luma:618:77
result__187 = invoke_symbol (items__9, ".push", 1, invoke (_field_node__0, 2, invoke (combine_strings__0, 2, ".", invoke_symbol (invoke_symbol (param__450, ".key", 0), ".id", 0)), invoke_symbol (param__450, ".value", 0)))
else
--@ compiler/compile.luma:619:32
if invoke_symbol (_symbol_node__0, ".?", 1, invoke_symbol (param__450, ".key", 0)) then
--@ compiler/compile.luma:620:55
result__187 = invoke_symbol (items__9, ".push", 1, invoke (_field_node__0, 2, invoke_symbol (invoke_symbol (param__450, ".key", 0), ".id", 0), invoke_symbol (param__450, ".value", 0)))
else
--@ compiler/compile.luma:621:15
if else__0 then
--@ compiler/compile.luma:622:70
result__187 = invoke (error_at__0, 2, invoke_symbol (param__450, ".key", 0), "new takes word-or-symbol-keyed pairs")
else
result__187 = false
end
end
end
list_result__192 = result__187
--@ unknown
return list_result__192
end
invoke_symbol (fields__1, ".each", 1, fn__345)
--@ compiler/compile.luma:625:46
list_result__190 = invoke (compile_exp__0, 2, invoke (_table_node__0, 1, items__9), param__449)
--@ unknown
end)()
return list_result__190
end
invoke (add_macro__0, 3, "new", false, fn__344)
--@ compiler/compile.luma:627:12
list_result__153 = context__0
--@ unknown
end)()
base_context__0 = list_result__153
--@ compiler/compile.luma:629:20
local embedded_string__0 = "local ops = {}\
local function get_ops (self)\
  return ops [type(self)] or error (\"tried to apply unknown value \" .. tostring (self))\
end\
\
local function invoke (self, num, ...)\
  if type (self) == \"function\" then\
    return self (...)\
  elseif self.functions then\
    if self.functions [num] then\
      return self.functions [num] (...)\
    elseif self.functions [\"..\"] then\
      return self.functions [\"..\"] (...)\
    end\
    error \"cant invoke this value with this number of arguments\"\
  else\
    error \"cant invoke this value\"\
  end\
end\
\
local function invoke_method (tbl, self, sym, ...)\
  if tbl.methods and tbl.methods[sym] then\
    return tbl.methods[sym](self, ...)\
  elseif tbl.index then\
    return invoke_method (tbl.index, self, sym, ...)\
  else\
    error (\"symbol not found in table: \" .. sym)\
  end\
end\
\
local function invoke_symbol (self, sym, num, ...)\
  if type (self) == \"table\" then\
    if self[sym] ~= nil then\
      if num == 0 then\
        return self[sym]\
      else\
        return invoke (self[sym], num, ...)\
      end\
    elseif self.functions and self.functions[sym] then\
      return invoke (self.functions[sym], num, ...)\
    elseif self.index then\
      return (invoke_method (self.index, self, sym, ...))\
    else\
      error (\"symbol not found in table: \" .. sym)\
    end\
  else\
    local ops = get_ops (self)\
    return invoke_method (ops, self, sym, ...)\
  end\
end\
\
local function assign_values_to_array (array, ...)\
  local len = select ('#', ...)\
  for i = 1, len do\
    array [i-1] = select (i, ...)\
  end\
  array[\".length\"] = len\
end\
\
local function read_module_src (path)\
  if rawget (_G, 'love') then\
    return love.filesystem.read (path)\
  else\
    local file = assert (io.open (path, 'r'))\
    local src = file:read '*a'\
    file:close ()\
    return src\
  end\
end\
\
local function get_source_map (src)\
  local path = src:match ('@(.*)')\
  if path then\
    src = read_module_src (path)\
  end\
  local source_map = {}\
  local current_index = 1\
  local current_line = 1\
  local last_location\
  while current_index < #src do\
    local line = src:match ('([^\\n]*)\\n?', current_index)\
    if line:match ('^%-%-@ ') then\
      last_location = line:match ('^%-%-@ (.*)')\
      if last_location == 'unknown' then\
        last_location = nil\
      end\
    end\
    source_map [current_line] = last_location\
    current_line = current_line + 1\
    current_index = current_index + #line + 1\
  end\
  return source_map\
end\
\
local function error_handler (msg)\
  local trace = { msg, '\\n' }\
\
  local level = 3\
  while true do\
    local raw = debug.getinfo (level)\
    if not raw then\
      break\
    end\
    local line = raw.currentline\
    local source_map = get_source_map (raw.source)\
    if raw.short_src:sub(1, 1) ~= '[' then\
      table.insert (trace, '\\t')\
      table.insert (trace, raw.short_src .. ':' .. raw.currentline)\
      if source_map [line] then\
        table.insert (trace, '\\t(' .. tostring (source_map [line]) .. ')')\
      end\
      table.insert (trace, '\\n')\
    end\
    level = level + 1\
  end\
\
  return table.concat (trace)\
end\
\
local function run_with_error_handler (fn)\
  local success, return_value = xpcall (fn, error_handler)\
  if not success then\
    error (return_value)\
  end\
  return return_value\
end\
\
"
invoke (emit__1, 1, embedded_string__0)
--@ compiler/compile.luma:630:39
invoke (emit__1, 1, "local function top_level ()\
")
--@ compiler/compile.luma:631:53
invoke (emit__1, 3, "return ", invoke (compile_exp__0, 2, param__348, base_context__0), "\
")
--@ compiler/compile.luma:632:15
invoke (emit__1, 1, "end\
")
--@ compiler/compile.luma:633:53
invoke (emit__1, 1, "return run_with_error_handler (top_level)\
")
--@ compiler/compile.luma:634:10
list_result__128 = invoke_symbol (emitter__0, ".concat-result", 0)
--@ unknown
end)()
return list_result__128
end
compile__1 = fn__282
--@ compiler/compile.luma:636:2
local table__83
--@ compiler/compile.luma:637:20
table__83 = {
[".compile"] = compile__1,
}
--@ unknown
list_result__122 = table__83
_modules_compiler_compile__0 = list_result__122
compile__0 = invoke_symbol (_modules_compiler_compile__0, ".compile", 0)
local list_result__193
(function ()
local in_file__0, out_file__0, src__0, compiled__0
--@ compiler/command.luma:13:74
local assert_result__18 = assert(invoke (___4, 2, 2, invoke_symbol (command_line_args__0, ".length", 0)), "usage: compile <infile> <outfile>")
--@ compiler/command.luma:15:33
in_file__0 = invoke_symbol (command_line_args__0, ".get", 1, 0)
--@ compiler/command.luma:16:34
out_file__0 = invoke_symbol (command_line_args__0, ".get", 1, 1)
--@ compiler/command.luma:18:23
src__0 = invoke (read_file__0, 1, in_file__0)
--@ compiler/command.luma:20:58
compiled__0 = invoke (compile__0, 1, invoke (link__0, 1, invoke (resolve__0, 1, invoke (parse__0, 1, invoke (read__0, 2, src__0, in_file__0)))))
--@ compiler/command.luma:22:29
list_result__193 = invoke (write_file__0, 2, out_file__0, compiled__0)
--@ unknown
end)()
list_result__0 = list_result__193
end)()
return list_result__0
end
return run_with_error_handler (top_level)
