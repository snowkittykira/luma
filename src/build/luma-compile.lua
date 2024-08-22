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

local function top_level ()
--@ unknown:-1:-1
local list_result__0
(function ()
local _modules_prelude__0, _bool__0, _string__0, _number__0, else__0, not__0, ___0, ___1, ___2, ___3, ___4, ____0, ___5, ___6, ____1, ____2, _collection__0, _list__0, _array__0, _hash__0, _pair__0, read_file__0, write_file__0, quote_string__0, safe_identifier__0, combine_strings__0, command_line_args__0, get_time__0, _modules_compiler_errors__0, error_at__0, assert_at__0, _modules_compiler_ast__0, _location__0, _token_node__0, _number_node__0, _apply_node__0, _list_node__0, _word_node__0, _vararg_node__0, _string_node__0, _binding_node__0, _field_node__0, _function_node__0, _symbol_function_node__0, _symbol_method_node__0, _symbol_node__0, _table_node__0, _primitive_node__0, _pair_node__0, _modules_compiler_read__0, read__0, _modules_compiler_context__0, _context__0, _modules_compiler_parse__0, parse__0, _modules_compiler_resolve__0, resolve__0, _modules_compiler_link__0, link__0, _modules_compiler_compile__0, compile__0
--@ unknown:-1:-1
local list_result__1
(function ()
local _string__1, _bool__1, _number__1, else__1, not__1, ___7, ___8, ___9, ___10, ___11, ____3, ___12, ___13, ____4, ____5, _collection__1, _list__1, nil__0, _iterator__0, _list_iterator__0, _array__1, _array_iterator__0, _hash__1, _hash_key_iterator__0, _pair__1, read_file__1, write_file__1, quote_string__1, safe_identifier__1, combine_strings__1, get_args__0, get_time__1, command_line_args__1
--@ prelude.luma:1:11
local table__0
(function ()
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
--@ prelude.luma:12:45
local length_result__0 = #param__15
return length_result__0
end
local fn__9 = function (param__16, param__17, param__18)
--@ prelude.luma:13:52
local substring_result__0 = param__16:sub (param__17 + 1, param__18)
return substring_result__0
end
local fn__10 = function (param__19, param__20)
--@ prelude.luma:14:55
local contains_result__0 = param__19:find (param__20, 1, true) ~= nil
return contains_result__0
end
local fn__11 = function (param__21, param__22)
--@ prelude.luma:15:51
local concat_result__0 = param__21 .. param__22
return concat_result__0
end
local fn__12 = function (param__23, param__24)
--@ prelude.luma:16:46
local char_at_result__0 = param__23:match ("^[%z\01-\127\194-\244][\128-\191]*", param__24 + 1)
assert (char_at_result__0, "couldnt find next utf8 character in string")
return char_at_result__0
end
local fn__13 = function (param__25)
--@ prelude.luma:17:20
local list_result__2
(function ()
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
--@ unknown:-1:-1
end)()
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
--@ unknown:-1:-1
end)()
_string__1 = table__0
ops.string = _string__1
--@ prelude.luma:22:9
local table__1
(function ()
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
--@ unknown:-1:-1
end)()
_bool__1 = table__1
ops.boolean = _bool__1
--@ prelude.luma:27:11
local table__2
(function ()
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
--@ unknown:-1:-1
end)()
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
local apply_result__0 = invoke_symbol (param__55, ".+", 1, param__56)
return apply_result__0
end
___7 = fn__32
--@ prelude.luma:49:10
local fn__33 = function (param__57, param__58)
--@ prelude.luma:49:18
local apply_result__1 = invoke_symbol (param__57, ".-", 1, param__58)
return apply_result__1
end
___8 = fn__33
--@ prelude.luma:50:10
local fn__34 = function (param__59, param__60)
--@ prelude.luma:50:18
local apply_result__2 = invoke_symbol (param__59, ".*", 1, param__60)
return apply_result__2
end
___9 = fn__34
--@ prelude.luma:51:10
local fn__35 = function (param__61, param__62)
--@ prelude.luma:51:18
local apply_result__3 = invoke_symbol (param__61, "./", 1, param__62)
return apply_result__3
end
___10 = fn__35
--@ prelude.luma:52:10
local fn__36 = function (param__63, param__64)
--@ prelude.luma:52:18
local apply_result__4 = invoke_symbol (param__63, ".=", 1, param__64)
return apply_result__4
end
___11 = fn__36
--@ prelude.luma:53:10
local fn__37 = function (param__65, param__66)
--@ prelude.luma:53:18
local apply_result__5 = invoke_symbol (param__65, ".~=", 1, param__66)
return apply_result__5
end
____3 = fn__37
--@ prelude.luma:54:10
local fn__38 = function (param__67, param__68)
--@ prelude.luma:54:18
local apply_result__6 = invoke_symbol (param__67, ".<", 1, param__68)
return apply_result__6
end
___12 = fn__38
--@ prelude.luma:55:10
local fn__39 = function (param__69, param__70)
--@ prelude.luma:55:18
local apply_result__7 = invoke_symbol (param__69, ".>", 1, param__70)
return apply_result__7
end
___13 = fn__39
--@ prelude.luma:56:10
local fn__40 = function (param__71, param__72)
--@ prelude.luma:56:18
local apply_result__8 = invoke_symbol (param__71, ".<=", 1, param__72)
return apply_result__8
end
____4 = fn__40
--@ prelude.luma:57:10
local fn__41 = function (param__73, param__74)
--@ prelude.luma:57:18
local apply_result__9 = invoke_symbol (param__73, ".>=", 1, param__74)
return apply_result__9
end
____5 = fn__41
--@ prelude.luma:59:15
local table__3
(function ()
local fn__42 = function (param__75, param__76)
--@ prelude.luma:60:22
local apply_result__10 = invoke_symbol (param__75, ".iterator", 0)
--@ prelude.luma:60:38
local apply_result__11 = invoke_symbol (apply_result__10, ".each", 1, param__76)
return apply_result__11
end
local fn__43 = function (param__77, param__78)
--@ prelude.luma:61:22
local apply_result__12 = invoke_symbol (param__77, ".iterator", 0)
--@ prelude.luma:61:38
local apply_result__13 = invoke_symbol (apply_result__12, ".all?", 1, param__78)
return apply_result__13
end
table__3 = {
methods = {
[".each"] = fn__42,
[".all?"] = fn__43,
},
}
--@ unknown:-1:-1
end)()
_collection__1 = table__3
--@ prelude.luma:63:9
local table__4
(function ()
local append__0
--@ prelude.luma:63:21
local fn__44 = function (param__79)
--@ prelude.luma:64:25
local result__2 = type (param__79) == "table" and (param__79.index == _list__1 or param__79[_list__1] ~= nil)
return result__2
end
local fn__45 = function ()
--@ prelude.luma:66:13
local apply_result__14 = invoke_symbol (_list__1, ".nil", 0)
return apply_result__14
end
local fn__46 = function (...)
local param__80 = ...
local param__81 = { n = select ("#", ...) - 1, select (2, ...) }
assert (param__81.n >= 0, "not enough arguments to function")
--@ prelude.luma:67:33
local apply_result__15 = invoke (_list__1, 0 + param__81.n, unpack (param__81, 1, param__81.n))
local apply_result__16 = invoke_symbol (_list__1, ".link", 2, param__80, apply_result__15)
return apply_result__16
end
local fn__47 = function (param__82, param__83)
--@ prelude.luma:69:24
local list_result__3
(function ()
--@ prelude.luma:70:25
local apply_result__17 = invoke_symbol (_list__1, ".?", 1, param__83)
--@ prelude.luma:70:54
local assert_result__0 = assert(apply_result__17, "tried to link to non-list")
--@ prelude.luma:71:6
local table__5
(function ()
--@ prelude.luma:73:18
table__5 = {
["index"] = _list__1,
[".first"] = param__82,
[".rest"] = param__83,
}
--@ unknown:-1:-1
end)()
list_result__3 = table__5
--@ unknown:-1:-1
end)()
return list_result__3
end
local fn__48 = function ()
--@ prelude.luma:75:16
return nil__0
end
local fn__49 = function (param__84)
--@ prelude.luma:77:39
local apply_result__18 = invoke (_list_iterator__0, 1, param__84)
return apply_result__18
end
local fn__50 = function (param__85)
--@ prelude.luma:78:30
local op_result__18 = param__85 == nil__0
return op_result__18
end
local fn__51 = function (param__86, param__87)
--@ prelude.luma:80:16
local list_result__4
(function ()
--@ prelude.luma:81:21
local apply_result__19 = invoke_symbol (param__86, ".empty?", 0)
local apply_result__20 = not__1 (apply_result__19)
--@ prelude.luma:81:74
local assert_result__1 = assert(apply_result__20, "tried to get element from past end of list")
--@ prelude.luma:82:15
local apply_result__21 = invoke_symbol (param__87, ".>", 1, 0)
local result__3
if apply_result__21 then
--@ prelude.luma:83:11
local apply_result__22 = invoke_symbol (param__86, ".rest", 0)
--@ prelude.luma:83:28
local apply_result__23 = invoke_symbol (param__87, ".-", 1, 1)
local apply_result__24 = invoke_symbol (apply_result__22, ".get", 1, apply_result__23)
result__3 = apply_result__24
else
--@ prelude.luma:84:11
local apply_result__25 = invoke_symbol (param__86, ".first", 0)
result__3 = apply_result__25
end
list_result__4 = result__3
--@ unknown:-1:-1
end)()
return list_result__4
end
local fn__52 = function (param__88, param__89)
--@ prelude.luma:86:17
local list_result__5
(function ()
--@ prelude.luma:87:23
local apply_result__26 = invoke_symbol (param__89, ".=", 1, 0)
local result__4 = apply_result__26
if not result__4 then
--@ prelude.luma:87:34
local apply_result__27 = invoke_symbol (param__88, ".empty?", 0)
local apply_result__28 = not__1 (apply_result__27)
result__4 = apply_result__28
end
--@ prelude.luma:87:86
local assert_result__2 = assert(result__4, "tried to drop more elements than in list")
--@ prelude.luma:88:15
local apply_result__29 = invoke_symbol (param__89, ".>", 1, 0)
local result__5
if apply_result__29 then
--@ prelude.luma:89:11
local apply_result__30 = invoke_symbol (param__88, ".rest", 0)
--@ prelude.luma:89:29
local apply_result__31 = invoke_symbol (param__89, ".-", 1, 1)
local apply_result__32 = invoke_symbol (apply_result__30, ".drop", 1, apply_result__31)
result__5 = apply_result__32
else
--@ prelude.luma:90:11
result__5 = param__88
end
list_result__5 = result__5
--@ unknown:-1:-1
end)()
return list_result__5
end
local fn__53 = function (param__90)
--@ prelude.luma:93:12
local apply_result__33 = invoke_symbol (param__90, ".empty?", 0)
local result__6
if apply_result__33 then
--@ prelude.luma:94:8
result__6 = 0
else
--@ prelude.luma:95:15
local apply_result__34 = invoke_symbol (param__90, ".rest", 0)
local apply_result__35 = invoke_symbol (apply_result__34, ".length", 0)
local apply_result__36 = ___7 (1, apply_result__35)
result__6 = apply_result__36
end
return result__6
end
local fn__54 = function (param__91, param__92)
--@ prelude.luma:97:22
local apply_result__37 = invoke_symbol (param__91, ".iterator", 0)
--@ prelude.luma:97:37
local apply_result__38 = invoke_symbol (apply_result__37, ".map", 1, param__92)
local apply_result__39 = invoke_symbol (apply_result__38, ".to-list", 0)
return apply_result__39
end
--@ prelude.luma:99:12
local table__6
(function ()
local fn__55 = function (param__93)
--@ prelude.luma:100:14
local list_result__6
(function ()
--@ prelude.luma:101:27
local apply_result__40 = invoke_symbol (_list__1, ".?", 1, param__93)
--@ prelude.luma:101:55
local assert_result__3 = assert(apply_result__40, "tried to append non-list")
--@ prelude.luma:102:11
list_result__6 = param__93
--@ unknown:-1:-1
end)()
return list_result__6
end
local fn__56 = function (...)
local param__94 = ...
local param__95 = { n = select ("#", ...) - 1, select (2, ...) }
assert (param__95.n >= 0, "not enough arguments to function")
--@ prelude.luma:103:22
local list_result__7
(function ()
--@ prelude.luma:104:27
local apply_result__41 = invoke_symbol (_list__1, ".?", 1, param__94)
--@ prelude.luma:104:55
local assert_result__4 = assert(apply_result__41, "tried to append non-list")
--@ prelude.luma:105:14
local apply_result__42 = invoke_symbol (param__94, ".empty?", 0)
local result__7
if apply_result__42 then
--@ prelude.luma:106:15
local apply_result__43 = invoke (append__0, 0 + param__95.n, unpack (param__95, 1, param__95.n))
result__7 = apply_result__43
else
--@ prelude.luma:107:25
local apply_result__44 = invoke_symbol (param__94, ".first", 0)
--@ prelude.luma:107:44
local apply_result__45 = invoke_symbol (param__94, ".rest", 0)
local apply_result__46 = invoke (append__0, 1 + param__95.n, apply_result__45, unpack (param__95, 1, param__95.n))
local apply_result__47 = invoke_symbol (_list__1, ".link", 2, apply_result__44, apply_result__46)
result__7 = apply_result__47
end
list_result__7 = result__7
--@ unknown:-1:-1
end)()
return list_result__7
end
table__6 = {
functions = {
[1] = fn__55,
[".."] = fn__56,
},
}
--@ unknown:-1:-1
end)()
append__0 = table__6
local fn__57 = function (...)
local param__96 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__96.n >= 0, "not enough arguments to function")
--@ prelude.luma:110:30
local apply_result__48 = append__0.functions[".."] (unpack (param__96, 1, param__96.n))
return apply_result__48
end
local fn__58 = function (param__97)
--@ prelude.luma:112:15
local list_result__8
(function ()
--@ prelude.luma:113:21
local apply_result__49 = invoke_symbol (param__97, ".empty?", 0)
local apply_result__50 = not__1 (apply_result__49)
--@ prelude.luma:113:64
local assert_result__5 = assert(apply_result__50, "cant get last item of empty list")
--@ prelude.luma:114:12
local apply_result__51 = invoke_symbol (param__97, ".rest", 0)
local apply_result__52 = invoke_symbol (apply_result__51, ".empty?", 0)
local result__8
if apply_result__52 then
--@ prelude.luma:115:11
local apply_result__53 = invoke_symbol (param__97, ".first", 0)
result__8 = apply_result__53
else
--@ prelude.luma:116:11
local apply_result__54 = invoke_symbol (param__97, ".rest", 0)
local apply_result__55 = invoke_symbol (apply_result__54, ".last", 0)
result__8 = apply_result__55
end
list_result__8 = result__8
--@ unknown:-1:-1
end)()
return list_result__8
end
local fn__59 = function (param__98)
--@ prelude.luma:118:23
local list_result__9
(function ()
--@ prelude.luma:119:21
local apply_result__56 = invoke_symbol (param__98, ".empty?", 0)
local apply_result__57 = not__1 (apply_result__56)
--@ prelude.luma:119:67
local assert_result__6 = assert(apply_result__57, "cant remove last item of empty list")
--@ prelude.luma:120:12
local apply_result__58 = invoke_symbol (param__98, ".rest", 0)
local apply_result__59 = invoke_symbol (apply_result__58, ".empty?", 0)
local result__9
if apply_result__59 then
--@ prelude.luma:121:12
local apply_result__60 = invoke_symbol (_list__1, ".nil", 0)
result__9 = apply_result__60
else
--@ prelude.luma:122:22
local apply_result__61 = invoke_symbol (param__98, ".first", 0)
--@ prelude.luma:122:33
local apply_result__62 = invoke_symbol (param__98, ".rest", 0)
local apply_result__63 = invoke_symbol (apply_result__62, ".without-last", 0)
local apply_result__64 = invoke_symbol (_list__1, ".link", 2, apply_result__61, apply_result__63)
result__9 = apply_result__64
end
list_result__9 = result__9
--@ unknown:-1:-1
end)()
return list_result__9
end
local fn__60 = function (param__99)
--@ prelude.luma:124:18
local list_result__10
(function ()
local result__10
--@ prelude.luma:125:19
local apply_result__65 = invoke (_list__1, 0)
result__10 = apply_result__65
--@ prelude.luma:126:21
local fn__61 = function (param__100)
--@ prelude.luma:127:38
local apply_result__66 = invoke_symbol (_list__1, ".link", 2, param__100, result__10)
result__10 = apply_result__66
return true
end
local apply_result__67 = invoke_symbol (param__99, ".each", 1, fn__61)
--@ prelude.luma:128:11
list_result__10 = result__10
--@ unknown:-1:-1
end)()
return list_result__10
end
table__4 = {
["index"] = _collection__1,
functions = {
[".?"] = fn__44,
[0] = fn__45,
[".."] = fn__46,
[".link"] = fn__47,
[".nil"] = fn__48,
[".append"] = fn__57,
},
methods = {
[".iterator"] = fn__49,
[".empty?"] = fn__50,
[".get"] = fn__51,
[".drop"] = fn__52,
[".length"] = fn__53,
[".map"] = fn__54,
[".last"] = fn__58,
[".without-last"] = fn__59,
[".reverse"] = fn__60,
},
}
--@ unknown:-1:-1
end)()
_list__1 = table__4
--@ prelude.luma:132:7
local table__7
(function ()
--@ prelude.luma:132:13
table__7 = {
["index"] = _list__1,
}
--@ unknown:-1:-1
end)()
nil__0 = table__7
--@ prelude.luma:134:13
local table__8
(function ()
local fn__62 = function (param__101, param__102)
--@ prelude.luma:135:18
local table__9
(function ()
--@ prelude.luma:135:28
local fn__63 = function ()
--@ prelude.luma:136:22
local apply_result__68 = invoke_symbol (param__101, ".empty?", 0)
return apply_result__68
end
local fn__64 = function ()
--@ prelude.luma:137:22
local apply_result__69 = invoke_symbol (param__101, ".item", 0)
local apply_result__70 = invoke (param__102, 1, apply_result__69)
return apply_result__70
end
local fn__65 = function ()
--@ prelude.luma:138:23
local apply_result__71 = invoke_symbol (param__101, ".advance", 0)
return apply_result__71
end
table__9 = {
["index"] = _iterator__0,
functions = {
[".empty?"] = fn__63,
[".item"] = fn__64,
[".advance"] = fn__65,
},
}
--@ unknown:-1:-1
end)()
return table__9
end
local fn__66 = function (param__103, param__104)
--@ prelude.luma:141:20
local apply_result__72 = invoke_symbol (param__103, ".empty?", 0)
local apply_result__73 = not__1 (apply_result__72)
local while_condition__0 = apply_result__73
while while_condition__0 do
--@ prelude.luma:141:29
local list_result__11
(function ()
--@ prelude.luma:142:13
local apply_result__74 = invoke_symbol (param__103, ".item", 0)
local apply_result__75 = invoke (param__104, 1, apply_result__74)
--@ prelude.luma:143:11
local apply_result__76 = invoke_symbol (param__103, ".advance", 0)
list_result__11 = apply_result__76
--@ unknown:-1:-1
end)()
local _ = list_result__11
--@ prelude.luma:141:20
local apply_result__77 = invoke_symbol (param__103, ".empty?", 0)
local apply_result__78 = not__1 (apply_result__77)
while_condition__0 = apply_result__78
end
return false
end
local fn__67 = function (param__105)
--@ prelude.luma:145:18
local list_result__12
(function ()
local loop__0
--@ prelude.luma:146:12
local fn__68 = function ()
--@ prelude.luma:147:11
local result__11
--@ prelude.luma:148:13
local apply_result__79 = invoke_symbol (param__105, ".empty?", 0)
if apply_result__79 then
--@ prelude.luma:149:16
local apply_result__80 = _list__1.functions[".nil"] ()
result__11 = apply_result__80
else
--@ prelude.luma:150:13
if else__1 then
--@ prelude.luma:150:14
local list_result__13
(function ()
local first__0
--@ prelude.luma:151:22
local apply_result__81 = invoke_symbol (param__105, ".item", 0)
first__0 = apply_result__81
--@ prelude.luma:152:15
local apply_result__82 = invoke_symbol (param__105, ".advance", 0)
--@ prelude.luma:153:33
local apply_result__83 = invoke (loop__0, 0)
local apply_result__84 = _list__1.functions[".link"] (first__0, apply_result__83)
list_result__13 = apply_result__84
--@ unknown:-1:-1
end)()
result__11 = list_result__13
else
result__11 = false 
end
end
return result__11
end
loop__0 = fn__68
--@ prelude.luma:154:10
local apply_result__85 = loop__0 ()
list_result__12 = apply_result__85
--@ unknown:-1:-1
end)()
return list_result__12
end
local fn__69 = function (param__106)
--@ prelude.luma:156:19
local list_result__14
(function ()
local array__0
--@ prelude.luma:157:19
local apply_result__86 = invoke (_array__1, 0)
array__0 = apply_result__86
--@ prelude.luma:158:20
local apply_result__87 = invoke_symbol (param__106, ".empty?", 0)
local apply_result__88 = not__1 (apply_result__87)
local while_condition__1 = apply_result__88
while while_condition__1 do
--@ prelude.luma:158:29
local list_result__15
(function ()
--@ prelude.luma:159:22
local apply_result__89 = invoke_symbol (param__106, ".item", 0)
local apply_result__90 = invoke_symbol (array__0, ".push", 1, apply_result__89)
--@ prelude.luma:160:11
local apply_result__91 = invoke_symbol (param__106, ".advance", 0)
list_result__15 = apply_result__91
--@ unknown:-1:-1
end)()
local _ = list_result__15
--@ prelude.luma:158:20
local apply_result__92 = invoke_symbol (param__106, ".empty?", 0)
local apply_result__93 = not__1 (apply_result__92)
while_condition__1 = apply_result__93
end
--@ prelude.luma:161:10
list_result__14 = array__0
--@ unknown:-1:-1
end)()
return list_result__14
end
local fn__70 = function (param__107, param__108)
--@ prelude.luma:163:17
local list_result__16
(function ()
--@ prelude.luma:164:18
local apply_result__94 = invoke_symbol (0, ".<", 1, param__108)
local while_condition__2 = apply_result__94
while while_condition__2 do
--@ prelude.luma:164:20
local list_result__17
(function ()
--@ prelude.luma:165:20
local apply_result__95 = invoke_symbol (param__108, ".-", 1, 1)
param__108 = apply_result__95
--@ prelude.luma:166:11
local apply_result__96 = invoke_symbol (param__107, ".advance", 0)
list_result__17 = apply_result__96
--@ unknown:-1:-1
end)()
local _ = list_result__17
--@ prelude.luma:164:18
local apply_result__97 = invoke_symbol (0, ".<", 1, param__108)
while_condition__2 = apply_result__97
end
--@ prelude.luma:167:9
list_result__16 = param__107
--@ unknown:-1:-1
end)()
return list_result__16
end
local fn__71 = function (param__109, param__110)
--@ prelude.luma:169:17
local list_result__18
(function ()
local result__12
--@ prelude.luma:170:17
result__12 = true
--@ prelude.luma:171:22
local result__13 = result__12
if result__13 then
--@ prelude.luma:171:32
local apply_result__98 = invoke_symbol (param__109, ".empty?", 0)
local apply_result__99 = not__1 (apply_result__98)
result__13 = apply_result__99
end
local while_condition__3 = result__13
while while_condition__3 do
--@ prelude.luma:171:42
local list_result__19
(function ()
--@ prelude.luma:172:25
local apply_result__100 = invoke_symbol (param__109, ".item", 0)
local apply_result__101 = invoke (param__110, 1, apply_result__100)
result__12 = apply_result__101
--@ prelude.luma:173:11
local apply_result__102 = invoke_symbol (param__109, ".advance", 0)
list_result__19 = apply_result__102
--@ unknown:-1:-1
end)()
local _ = list_result__19
--@ prelude.luma:171:22
local result__14 = result__12
if result__14 then
--@ prelude.luma:171:32
local apply_result__103 = invoke_symbol (param__109, ".empty?", 0)
local apply_result__104 = not__1 (apply_result__103)
result__14 = apply_result__104
end
while_condition__3 = result__14
end
--@ prelude.luma:174:11
list_result__18 = result__12
--@ unknown:-1:-1
end)()
return list_result__18
end
table__8 = {
methods = {
[".map"] = fn__62,
[".each"] = fn__66,
[".to-list"] = fn__67,
[".to-array"] = fn__69,
[".skip"] = fn__70,
[".all?"] = fn__71,
},
}
--@ unknown:-1:-1
end)()
_iterator__0 = table__8
--@ prelude.luma:176:18
local table__10
(function ()
--@ prelude.luma:176:28
local fn__72 = function (param__111)
--@ prelude.luma:177:14
local table__11
(function ()
--@ prelude.luma:178:16
table__11 = {
["index"] = _list_iterator__0,
[".list"] = param__111,
}
--@ unknown:-1:-1
end)()
return table__11
end
local fn__73 = function (param__112)
--@ prelude.luma:179:23
local apply_result__105 = invoke_symbol (param__112, ".list", 0)
local apply_result__106 = invoke_symbol (apply_result__105, ".empty?", 0)
return apply_result__106
end
local fn__74 = function (param__113)
--@ prelude.luma:180:23
local apply_result__107 = invoke_symbol (param__113, ".list", 0)
local apply_result__108 = invoke_symbol (apply_result__107, ".first", 0)
return apply_result__108
end
local fn__75 = function (param__114)
--@ prelude.luma:181:37
local apply_result__109 = invoke_symbol (param__114, ".list", 0)
local apply_result__110 = invoke_symbol (apply_result__109, ".rest", 0)
--@ prelude.luma:181:27
param__114 [".list"] = apply_result__110
return true
end
table__10 = {
["index"] = _iterator__0,
functions = {
[1] = fn__72,
},
methods = {
[".empty?"] = fn__73,
[".item"] = fn__74,
[".advance"] = fn__75,
},
}
--@ unknown:-1:-1
end)()
_list_iterator__0 = table__10
--@ prelude.luma:183:10
local table__12
(function ()
--@ prelude.luma:183:22
local fn__76 = function (param__115)
--@ prelude.luma:184:26
local result__15 = type (param__115) == "table" and (param__115.index == _array__1 or param__115[_array__1] ~= nil)
return result__15
end
local fn__77 = function ()
--@ prelude.luma:186:9
local table__13
(function ()
--@ prelude.luma:187:15
table__13 = {
["index"] = _array__1,
[".length"] = 0,
}
--@ unknown:-1:-1
end)()
return table__13
end
local fn__78 = function (...)
local param__116 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__116.n >= 0, "not enough arguments to function")
--@ prelude.luma:189:11
local list_result__20
(function ()
local array__1, loop__1
--@ prelude.luma:190:19
local apply_result__111 = invoke (_array__1, 0)
array__1 = apply_result__111
--@ prelude.luma:191:12
local table__14
(function ()
local fn__79 = function ()
--@ prelude.luma:192:17
return false
end
local fn__80 = function (...)
local param__117 = ...
local param__118 = { n = select ("#", ...) - 1, select (2, ...) }
assert (param__118.n >= 0, "not enough arguments to function")
--@ prelude.luma:193:17
local list_result__21
(function ()
--@ prelude.luma:194:21
local apply_result__112 = invoke_symbol (array__1, ".push", 1, param__117)
--@ prelude.luma:195:13
local apply_result__113 = invoke (loop__1, 0 + param__118.n, unpack (param__118, 1, param__118.n))
list_result__21 = apply_result__113
--@ unknown:-1:-1
end)()
return list_result__21
end
table__14 = {
functions = {
[0] = fn__79,
[".."] = fn__80,
},
}
--@ unknown:-1:-1
end)()
loop__1 = table__14
--@ prelude.luma:196:10
local apply_result__114 = loop__1.functions[".."] (unpack (param__116, 1, param__116.n))
--@ prelude.luma:197:10
list_result__20 = array__1
--@ unknown:-1:-1
end)()
return list_result__20
end
local fn__81 = function (...)
local param__119 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__119.n >= 0, "not enough arguments to function")
--@ prelude.luma:199:23
local list_result__22
(function ()
local result__16
--@ prelude.luma:200:20
local apply_result__115 = invoke (_array__1, 0)
result__16 = apply_result__115
--@ prelude.luma:201:12
local apply_result__116 = invoke (_array__1, 0 + param__119.n, unpack (param__119, 1, param__119.n))
--@ prelude.luma:201:33
local fn__82 = function (param__120)
--@ prelude.luma:202:26
local apply_result__117 = invoke_symbol (result__16, ".push-items", 1, param__120)
return apply_result__117
end
local apply_result__118 = invoke_symbol (apply_result__116, ".each", 1, fn__82)
--@ prelude.luma:203:11
list_result__22 = result__16
--@ unknown:-1:-1
end)()
return list_result__22
end
local fn__83 = function (param__121, param__122)
--@ prelude.luma:206:26
local result__17 = param__121 [param__122]
assert (result__17 ~= nil, "getting invalid index")return result__17
end
local fn__84 = function (param__123, param__124, param__125)
--@ prelude.luma:208:18
local list_result__23
(function ()
--@ prelude.luma:209:20
local apply_result__119 = invoke_symbol (0, ".<=", 1, param__124)
--@ prelude.luma:209:42
local assert_result__7 = assert(apply_result__119, "index out of range")
--@ prelude.luma:210:22
local apply_result__120 = invoke_symbol (param__123, ".length", 0)
local apply_result__121 = invoke_symbol (param__124, ".<", 1, apply_result__120)
--@ prelude.luma:210:51
local assert_result__8 = assert(apply_result__121, "index out of range")
--@ prelude.luma:211:28
param__123 [param__124] = param__125
list_result__23 = false
--@ unknown:-1:-1
end)()
return list_result__23
end
local fn__85 = function (param__126, param__127)
--@ prelude.luma:213:17
local list_result__24
(function ()
--@ prelude.luma:214:29
local apply_result__122 = invoke_symbol (param__126, ".length", 0)
--@ prelude.luma:214:38
param__126 [apply_result__122] = param__127
--@ prelude.luma:215:26
local apply_result__123 = invoke_symbol (param__126, ".length", 0)
--@ prelude.luma:215:38
local apply_result__124 = invoke_symbol (apply_result__123, ".+", 1, 1)
--@ prelude.luma:215:13
param__126 [".length"] = apply_result__124
list_result__24 = true
--@ unknown:-1:-1
end)()
return list_result__24
end
local fn__86 = function (param__128)
--@ prelude.luma:217:14
local list_result__25
(function ()
local value__0
--@ prelude.luma:218:22
local apply_result__125 = invoke_symbol (param__128, ".length", 0)
local apply_result__126 = invoke_symbol (0, ".<", 1, apply_result__125)
--@ prelude.luma:218:53
local assert_result__9 = assert(apply_result__126, "cant pop empty array")
--@ prelude.luma:219:26
local apply_result__127 = invoke_symbol (param__128, ".length", 0)
--@ prelude.luma:219:38
local apply_result__128 = invoke_symbol (apply_result__127, ".-", 1, 1)
--@ prelude.luma:219:13
param__128 [".length"] = apply_result__128
--@ prelude.luma:220:36
local apply_result__129 = invoke_symbol (param__128, ".length", 0)
local result__18 = param__128 [apply_result__129]
assert (result__18 ~= nil, "getting invalid index")value__0 = result__18
--@ prelude.luma:221:32
local apply_result__130 = invoke_symbol (param__128, ".length", 0)
param__128 [apply_result__130] = nil
--@ prelude.luma:222:10
list_result__25 = value__0
--@ unknown:-1:-1
end)()
return list_result__25
end
local fn__87 = function (param__129)
--@ prelude.luma:224:15
local list_result__26
(function ()
--@ prelude.luma:225:22
local apply_result__131 = invoke_symbol (param__129, ".length", 0)
local apply_result__132 = invoke_symbol (0, ".<", 1, apply_result__131)
--@ prelude.luma:225:54
local assert_result__10 = assert(apply_result__132, "cant peek empty array")
--@ prelude.luma:226:19
local apply_result__133 = invoke_symbol (param__129, ".length", 0)
--@ prelude.luma:226:31
local apply_result__134 = invoke_symbol (apply_result__133, ".-", 1, 1)
local apply_result__135 = invoke_symbol (param__129, ".get", 1, apply_result__134)
list_result__26 = apply_result__135
--@ unknown:-1:-1
end)()
return list_result__26
end
local fn__88 = function (param__130, param__131)
--@ prelude.luma:229:22
local fn__89 = function (param__132)
--@ prelude.luma:229:35
local apply_result__136 = invoke_symbol (param__130, ".push", 1, param__132)
return apply_result__136
end
local apply_result__137 = invoke_symbol (param__131, ".each", 1, fn__89)
return apply_result__137
end
local fn__90 = function (param__133)
--@ prelude.luma:231:40
local apply_result__138 = invoke (_array_iterator__0, 1, param__133)
return apply_result__138
end
local fn__91 = function (param__134, param__135)
--@ prelude.luma:233:23
local apply_result__139 = invoke_symbol (param__134, ".iterator", 0)
--@ prelude.luma:233:39
local apply_result__140 = invoke_symbol (apply_result__139, ".skip", 1, param__135)
local apply_result__141 = invoke_symbol (apply_result__140, ".to-array", 0)
return apply_result__141
end
local fn__92 = function (param__136, param__137)
--@ prelude.luma:235:22
local list_result__27
(function ()
local result__19, i__0, end__0
--@ prelude.luma:236:20
local apply_result__142 = invoke (_array__1, 0)
result__19 = apply_result__142
--@ prelude.luma:237:9
i__0 = 0
--@ prelude.luma:238:14
local apply_result__143 = invoke_symbol (param__136, ".length", 0)
--@ prelude.luma:238:26
local apply_result__144 = invoke_symbol (apply_result__143, ".-", 1, param__137)
end__0 = apply_result__144
--@ prelude.luma:239:20
local apply_result__145 = invoke_symbol (i__0, ".<", 1, end__0)
local while_condition__4 = apply_result__145
while while_condition__4 do
--@ prelude.luma:239:22
local list_result__28
(function ()
--@ prelude.luma:240:30
local apply_result__146 = invoke_symbol (param__136, ".get", 1, i__0)
local apply_result__147 = invoke_symbol (result__19, ".push", 1, apply_result__146)
--@ prelude.luma:241:20
local apply_result__148 = invoke_symbol (i__0, ".+", 1, 1)
i__0 = apply_result__148
list_result__28 = true
--@ unknown:-1:-1
end)()
local _ = list_result__28
--@ prelude.luma:239:20
local apply_result__149 = invoke_symbol (i__0, ".<", 1, end__0)
while_condition__4 = apply_result__149
end
--@ prelude.luma:242:11
list_result__27 = result__19
--@ unknown:-1:-1
end)()
return list_result__27
end
local fn__93 = function (param__138)
--@ prelude.luma:245:19
local apply_result__150 = invoke_symbol (param__138, ".length", 0)
--@ prelude.luma:245:31
local apply_result__151 = invoke_symbol (apply_result__150, ".-", 1, 1)
local apply_result__152 = invoke_symbol (param__138, ".get", 1, apply_result__151)
return apply_result__152
end
local fn__94 = function (param__139, param__140)
--@ prelude.luma:247:16
local list_result__29
(function ()
local result__20, i__1, len__0
--@ prelude.luma:248:20
local apply_result__153 = invoke (_array__1, 0)
result__20 = apply_result__153
--@ prelude.luma:249:9
i__1 = 0
--@ prelude.luma:250:14
local apply_result__154 = invoke_symbol (param__139, ".length", 0)
len__0 = apply_result__154
--@ prelude.luma:251:20
local apply_result__155 = invoke_symbol (i__1, ".<", 1, len__0)
local while_condition__5 = apply_result__155
while while_condition__5 do
--@ prelude.luma:251:22
local list_result__30
(function ()
--@ prelude.luma:252:33
local apply_result__156 = invoke_symbol (param__139, ".get", 1, i__1)
local apply_result__157 = invoke (param__140, 1, apply_result__156)
local apply_result__158 = invoke_symbol (result__20, ".push", 1, apply_result__157)
--@ prelude.luma:253:20
local apply_result__159 = invoke_symbol (i__1, ".+", 1, 1)
i__1 = apply_result__159
list_result__30 = true
--@ unknown:-1:-1
end)()
local _ = list_result__30
--@ prelude.luma:251:20
local apply_result__160 = invoke_symbol (i__1, ".<", 1, len__0)
while_condition__5 = apply_result__160
end
--@ prelude.luma:254:11
list_result__29 = result__20
--@ unknown:-1:-1
end)()
return list_result__29
end
local fn__95 = function (param__141)
--@ prelude.luma:258:21
local result__21
if param__141[0] == nil then
result__21 = ""
else
result__21 = param__141 [0] .. table.concat (param__141)
end
return result__21
end
local fn__96 = function (param__142, param__143)
--@ prelude.luma:260:21
local list_result__31
(function ()
local sorted__0
--@ prelude.luma:261:14
sorted__0 = 1
--@ prelude.luma:262:26
local apply_result__161 = invoke_symbol (param__142, ".length", 0)
local apply_result__162 = invoke_symbol (sorted__0, ".<", 1, apply_result__161)
local while_condition__6 = apply_result__162
while while_condition__6 do
--@ prelude.luma:262:35
local list_result__32
(function ()
local value__1, i__2
--@ prelude.luma:263:29
local apply_result__163 = invoke_symbol (param__142, ".get", 1, sorted__0)
value__1 = apply_result__163
--@ prelude.luma:264:16
i__2 = sorted__0
--@ prelude.luma:265:25
local apply_result__164 = invoke_symbol (0, ".<", 1, i__2)
local result__22 = apply_result__164
if result__22 then
--@ prelude.luma:265:56
local apply_result__165 = invoke_symbol (i__2, ".-", 1, 1)
local apply_result__166 = invoke_symbol (param__142, ".get", 1, apply_result__165)
--@ prelude.luma:265:64
local apply_result__167 = invoke (param__143, 2, apply_result__166, value__1)
local apply_result__168 = not__1 (apply_result__167)
result__22 = apply_result__168
end
local while_condition__7 = result__22
while while_condition__7 do
--@ prelude.luma:265:68
local list_result__33
(function ()
--@ prelude.luma:266:37
local apply_result__169 = invoke_symbol (i__2, ".-", 1, 1)
local apply_result__170 = invoke_symbol (param__142, ".get", 1, apply_result__169)
local apply_result__171 = invoke_symbol (param__142, ".set", 2, i__2, apply_result__170)
--@ prelude.luma:267:22
local apply_result__172 = invoke_symbol (i__2, ".-", 1, 1)
i__2 = apply_result__172
list_result__33 = true
--@ unknown:-1:-1
end)()
local _ = list_result__33
--@ prelude.luma:265:25
local apply_result__173 = invoke_symbol (0, ".<", 1, i__2)
local result__23 = apply_result__173
if result__23 then
--@ prelude.luma:265:56
local apply_result__174 = invoke_symbol (i__2, ".-", 1, 1)
local apply_result__175 = invoke_symbol (param__142, ".get", 1, apply_result__174)
--@ prelude.luma:265:64
local apply_result__176 = invoke (param__143, 2, apply_result__175, value__1)
local apply_result__177 = not__1 (apply_result__176)
result__23 = apply_result__177
end
while_condition__7 = result__23
end
--@ prelude.luma:268:23
local apply_result__178 = invoke_symbol (param__142, ".set", 2, i__2, value__1)
--@ prelude.luma:269:30
local apply_result__179 = invoke_symbol (sorted__0, ".+", 1, 1)
sorted__0 = apply_result__179
list_result__32 = true
--@ unknown:-1:-1
end)()
local _ = list_result__32
--@ prelude.luma:262:26
local apply_result__180 = invoke_symbol (param__142, ".length", 0)
local apply_result__181 = invoke_symbol (sorted__0, ".<", 1, apply_result__180)
while_condition__6 = apply_result__181
end
list_result__31 = false
--@ unknown:-1:-1
end)()
return list_result__31
end
local fn__97 = function (param__144, param__145)
--@ prelude.luma:272:17
local list_result__34
(function ()
local i__3, end__1
--@ prelude.luma:273:9
i__3 = 0
--@ prelude.luma:274:14
local apply_result__182 = invoke_symbol (param__144, ".length", 0)
end__1 = apply_result__182
--@ prelude.luma:275:20
local apply_result__183 = invoke_symbol (i__3, ".<", 1, end__1)
local while_condition__8 = apply_result__183
while while_condition__8 do
--@ prelude.luma:275:22
local list_result__35
(function ()
--@ prelude.luma:276:20
local apply_result__184 = invoke_symbol (param__144, ".get", 1, i__3)
local apply_result__185 = invoke (param__145, 1, apply_result__184)
--@ prelude.luma:277:20
local apply_result__186 = invoke_symbol (i__3, ".+", 1, 1)
i__3 = apply_result__186
list_result__35 = true
--@ unknown:-1:-1
end)()
local _ = list_result__35
--@ prelude.luma:275:20
local apply_result__187 = invoke_symbol (i__3, ".<", 1, end__1)
while_condition__8 = apply_result__187
end
list_result__34 = false
--@ unknown:-1:-1
end)()
return list_result__34
end
table__12 = {
["index"] = _collection__1,
functions = {
[".?"] = fn__76,
[0] = fn__77,
[".."] = fn__78,
[".append"] = fn__81,
},
methods = {
[".get"] = fn__83,
[".set"] = fn__84,
[".push"] = fn__85,
[".pop"] = fn__86,
[".peek"] = fn__87,
[".push-items"] = fn__88,
[".iterator"] = fn__90,
[".drop"] = fn__91,
[".drop-last"] = fn__92,
[".last"] = fn__93,
[".map"] = fn__94,
[".concat"] = fn__95,
[".sort"] = fn__96,
[".each"] = fn__97,
},
}
--@ unknown:-1:-1
end)()
_array__1 = table__12
--@ prelude.luma:279:19
local table__15
(function ()
--@ prelude.luma:279:29
local fn__98 = function (param__146)
--@ prelude.luma:280:15
local table__16
(function ()
--@ prelude.luma:282:14
table__16 = {
["index"] = _array_iterator__0,
[".array"] = param__146,
[".index"] = 0,
}
--@ unknown:-1:-1
end)()
return table__16
end
local fn__99 = function (param__147)
--@ prelude.luma:283:23
local apply_result__188 = invoke_symbol (param__147, ".array", 0)
local apply_result__189 = invoke_symbol (apply_result__188, ".length", 0)
--@ prelude.luma:283:45
local apply_result__190 = invoke_symbol (param__147, ".index", 0)
local apply_result__191 = invoke_symbol (apply_result__189, ".<=", 1, apply_result__190)
return apply_result__191
end
local fn__100 = function (param__148)
--@ prelude.luma:284:23
local apply_result__192 = invoke_symbol (param__148, ".array", 0)
--@ prelude.luma:284:38
local apply_result__193 = invoke_symbol (param__148, ".index", 0)
local apply_result__194 = invoke_symbol (apply_result__192, ".get", 1, apply_result__193)
return apply_result__194
end
local fn__101 = function (param__149)
--@ prelude.luma:285:18
local list_result__36
(function ()
--@ prelude.luma:286:21
local apply_result__195 = invoke_symbol (param__149, ".empty?", 0)
local apply_result__196 = not__1 (apply_result__195)
local assert_result__11 = assert(apply_result__196)
--@ prelude.luma:287:25
local apply_result__197 = invoke_symbol (param__149, ".index", 0)
--@ prelude.luma:287:36
local apply_result__198 = invoke_symbol (apply_result__197, ".+", 1, 1)
--@ prelude.luma:287:13
param__149 [".index"] = apply_result__198
list_result__36 = true
--@ unknown:-1:-1
end)()
return list_result__36
end
table__15 = {
["index"] = _iterator__0,
functions = {
[1] = fn__98,
},
methods = {
[".empty?"] = fn__99,
[".item"] = fn__100,
[".advance"] = fn__101,
},
}
--@ unknown:-1:-1
end)()
_array_iterator__0 = table__15
--@ prelude.luma:289:9
local table__17
(function ()
local fn__102 = function (param__150)
--@ prelude.luma:290:25
local result__24 = type (param__150) == "table" and (param__150.index == _hash__1 or param__150[_hash__1] ~= nil)
return result__24
end
local fn__103 = function ()
--@ prelude.luma:292:9
local table__18
(function ()
--@ prelude.luma:293:16
local table__19
(function ()
table__19 = {
}
--@ unknown:-1:-1
end)()
table__18 = {
["index"] = _hash__1,
[".%index"] = table__19,
}
--@ unknown:-1:-1
end)()
return table__18
end
local fn__104 = function (...)
local param__151 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__151.n >= 0, "not enough arguments to function")
--@ prelude.luma:295:15
local list_result__37
(function ()
local hash__0, loop__2
--@ prelude.luma:296:17
local apply_result__199 = invoke (_hash__1, 0)
hash__0 = apply_result__199
--@ prelude.luma:297:12
local table__20
(function ()
local fn__105 = function ()
--@ prelude.luma:298:17
return false
end
local fn__106 = function (...)
local param__152 = ...
local param__153 = { n = select ("#", ...) - 1, select (2, ...) }
assert (param__153.n >= 0, "not enough arguments to function")
--@ prelude.luma:299:24
local list_result__38
(function ()
--@ prelude.luma:300:22
local apply_result__200 = invoke_symbol (param__152, ".key", 0)
--@ prelude.luma:300:31
local apply_result__201 = invoke_symbol (param__152, ".value", 0)
local apply_result__202 = invoke_symbol (hash__0, ".set", 2, apply_result__200, apply_result__201)
--@ prelude.luma:301:13
local apply_result__203 = invoke (loop__2, 0 + param__153.n, unpack (param__153, 1, param__153.n))
list_result__38 = apply_result__203
--@ unknown:-1:-1
end)()
return list_result__38
end
table__20 = {
functions = {
[0] = fn__105,
[".."] = fn__106,
},
}
--@ unknown:-1:-1
end)()
loop__2 = table__20
--@ prelude.luma:302:10
local apply_result__204 = loop__2.functions[".."] (unpack (param__151, 1, param__151.n))
--@ prelude.luma:303:9
list_result__37 = hash__0
--@ unknown:-1:-1
end)()
return list_result__37
end
local fn__107 = function (param__154, param__155)
--@ prelude.luma:306:25
local apply_result__205 = invoke_symbol (param__154, ".%index", 0)
--@ prelude.luma:306:36
local result__25 = apply_result__205 [param__155] ~= nil
return result__25
end
local fn__108 = function (param__156, param__157, param__158)
--@ prelude.luma:309:24
local apply_result__206 = invoke_symbol (param__156, ".%index", 0)
--@ prelude.luma:309:41
apply_result__206 [param__157] = param__158
return false
end
local fn__109 = function (param__159, param__160)
--@ prelude.luma:312:24
local apply_result__207 = invoke_symbol (param__159, ".%index", 0)
--@ prelude.luma:312:35
local result__26 = apply_result__207 [param__160]
assert (result__26 ~= nil, "getting invalid index")return result__26
end
local fn__110 = function (param__161, param__162, param__163)
--@ prelude.luma:315:22
local apply_result__208 = invoke_symbol (param__161, ".has?", 1, param__162)
local result__27
if apply_result__208 then
--@ prelude.luma:316:26
local apply_result__209 = invoke_symbol (param__161, ".%index", 0)
--@ prelude.luma:316:37
local result__28 = apply_result__209 [param__162]
assert (result__28 ~= nil, "getting invalid index")result__27 = result__28
else
--@ prelude.luma:317:14
result__27 = param__163
end
return result__27
end
local fn__111 = function (param__164, param__165)
--@ prelude.luma:320:27
local apply_result__210 = invoke_symbol (param__164, ".%index", 0)
--@ prelude.luma:320:38
apply_result__210 [param__165] = nil
return false
end
local fn__112 = function (param__166)
--@ prelude.luma:323:28
local apply_result__211 = invoke (_hash_key_iterator__0, 1, param__166)
return apply_result__211
end
local fn__113 = function (param__167)
--@ prelude.luma:326:9
local apply_result__212 = invoke_symbol (param__167, ".key-iterator", 0)
--@ prelude.luma:326:35
local fn__114 = function (param__168)
--@ prelude.luma:327:30
local apply_result__213 = invoke_symbol (param__167, ".get", 1, param__168)
local apply_result__214 = invoke (_pair__1, 2, param__168, apply_result__213)
return apply_result__214
end
local apply_result__215 = invoke_symbol (apply_result__212, ".map", 1, fn__114)
return apply_result__215
end
table__17 = {
functions = {
[".?"] = fn__102,
[0] = fn__103,
[".."] = fn__104,
},
methods = {
[".has?"] = fn__107,
[".set"] = fn__108,
[".get"] = fn__109,
[".get-or"] = fn__110,
[".remove"] = fn__111,
[".key-iterator"] = fn__112,
[".pair-iterator"] = fn__113,
},
}
--@ unknown:-1:-1
end)()
_hash__1 = table__17
--@ prelude.luma:329:22
local table__21
(function ()
--@ prelude.luma:329:32
local fn__115 = function (param__169)
--@ prelude.luma:330:14
local table__22
(function ()
--@ prelude.luma:333:16
table__22 = {
["index"] = _hash_key_iterator__0,
[".hash"] = param__169,
[".first?"] = true,
[".key"] = false,
}
--@ unknown:-1:-1
end)()
return table__22
end
local fn__116 = function (param__170)
--@ prelude.luma:336:25
local apply_result__216 = invoke_symbol (param__170, ".first?", 0)
local result__29
if apply_result__216 then
--@ prelude.luma:337:35
local apply_result__217 = invoke_symbol (param__170, ".hash", 0)
local apply_result__218 = invoke_symbol (apply_result__217, ".%index", 0)
local result__30 = next (apply_result__218, nil) ~= nil
local apply_result__219 = not__1 (result__30)
result__29 = apply_result__219
else
--@ prelude.luma:338:35
local apply_result__220 = invoke_symbol (param__170, ".hash", 0)
local apply_result__221 = invoke_symbol (apply_result__220, ".%index", 0)
--@ prelude.luma:338:52
local apply_result__222 = invoke_symbol (param__170, ".key", 0)
local result__31 = next (apply_result__221, apply_result__222) ~= nil
local apply_result__223 = not__1 (result__31)
result__29 = apply_result__223
end
return result__29
end
local fn__117 = function (param__171)
--@ prelude.luma:339:23
local apply_result__224 = invoke_symbol (param__171, ".first?", 0)
local result__32
if apply_result__224 then
--@ prelude.luma:340:25
local apply_result__225 = invoke_symbol (param__171, ".hash", 0)
local apply_result__226 = invoke_symbol (apply_result__225, ".%index", 0)
local result__33 = next (apply_result__226, nil)
assert (result__33 ~= nil, "no next index")result__32 = result__33
else
--@ prelude.luma:341:25
local apply_result__227 = invoke_symbol (param__171, ".hash", 0)
local apply_result__228 = invoke_symbol (apply_result__227, ".%index", 0)
--@ prelude.luma:341:42
local apply_result__229 = invoke_symbol (param__171, ".key", 0)
local result__34 = next (apply_result__228, apply_result__229)
assert (result__34 ~= nil, "no next index")result__32 = result__34
end
return result__32
end
local fn__118 = function (param__172)
--@ prelude.luma:342:18
local list_result__39
(function ()
--@ prelude.luma:343:21
local apply_result__230 = invoke_symbol (param__172, ".empty?", 0)
local apply_result__231 = not__1 (apply_result__230)
local assert_result__12 = assert(apply_result__231)
--@ prelude.luma:344:22
local apply_result__232 = invoke_symbol (param__172, ".item", 0)
--@ prelude.luma:344:13
param__172 [".key"] = apply_result__232
--@ prelude.luma:345:13
param__172 [".first?"] = false
list_result__39 = true
--@ unknown:-1:-1
end)()
return list_result__39
end
table__21 = {
["index"] = _iterator__0,
functions = {
[1] = fn__115,
},
methods = {
[".empty?"] = fn__116,
[".item"] = fn__117,
[".advance"] = fn__118,
},
}
--@ unknown:-1:-1
end)()
_hash_key_iterator__0 = table__21
--@ prelude.luma:347:9
local table__23
(function ()
local fn__119 = function (param__173)
--@ prelude.luma:348:25
local result__35 = type (param__173) == "table" and (param__173.index == _pair__1 or param__173[_pair__1] ~= nil)
return result__35
end
local fn__120 = function (param__174, param__175)
--@ prelude.luma:350:19
local table__24
(function ()
--@ prelude.luma:352:18
table__24 = {
["index"] = _pair__1,
[".key"] = param__174,
[".value"] = param__175,
}
--@ unknown:-1:-1
end)()
return table__24
end
table__23 = {
functions = {
[".?"] = fn__119,
[2] = fn__120,
},
}
--@ unknown:-1:-1
end)()
_pair__1 = table__23
--@ prelude.luma:354:18
local fn__121 = function (param__176)
--@ prelude.luma:355:18
local file__0 = assert (io.open (param__176, "r"))
local read_result__0 = file__0:read ("*a")
file__0:close ()
return read_result__0
end
read_file__1 = fn__121
--@ prelude.luma:357:24
local fn__122 = function (param__177, param__178)
--@ prelude.luma:358:25
local file__1 = assert (io.open (param__177, "w"))
file__1:write (param__178)
file__1:close ()
return true
end
write_file__1 = fn__122
--@ prelude.luma:360:20
local fn__123 = function (param__179)
--@ prelude.luma:361:20
local quote_result__0 = string.format ("%q", param__179)
return quote_result__0
end
quote_string__1 = fn__123
--@ prelude.luma:363:23
local fn__124 = function (param__180)
--@ prelude.luma:364:23
local safe_id_result__0 = string.gsub (param__180, "[^a-zA-Z0-9_]", "_")
if safe_id_result__0:match ("^[0-9]") then safe_id_result__0 = "_" .. safe_id_result__0 end
return safe_id_result__0
end
safe_identifier__1 = fn__124
--@ prelude.luma:366:27
local fn__125 = function (...)
local param__181 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__181.n >= 0, "not enough arguments to function")
--@ prelude.luma:366:27
local list_result__40
(function ()
local flatten_to_array__0
--@ prelude.luma:368:27
local fn__126 = function (param__182)
--@ prelude.luma:368:27
local list_result__41
(function ()
local flat_array__0, flatten_loop__0
--@ prelude.luma:369:24
local apply_result__233 = _array__1.functions[0] ()
flat_array__0 = apply_result__233
--@ prelude.luma:370:26
local fn__127 = function (param__183)
--@ prelude.luma:371:12
local apply_result__234 = invoke_symbol (param__183, ".iterator", 0)
--@ prelude.luma:371:36
local fn__128 = function (param__184)
--@ prelude.luma:372:27
local apply_result__235 = _string__1.functions[".?"] (param__184)
local result__36
if apply_result__235 then
--@ prelude.luma:373:31
local apply_result__236 = invoke_symbol (flat_array__0, ".push", 1, param__184)
result__36 = apply_result__236
else
--@ prelude.luma:374:28
local apply_result__237 = invoke (flatten_loop__0, 1, param__184)
result__36 = apply_result__237
end
return result__36
end
local apply_result__238 = invoke_symbol (apply_result__234, ".each", 1, fn__128)
return apply_result__238
end
flatten_loop__0 = fn__127
--@ prelude.luma:375:23
local apply_result__239 = flatten_loop__0 (param__182)
--@ prelude.luma:376:15
list_result__41 = flat_array__0
--@ unknown:-1:-1
end)()
return list_result__41
end
flatten_to_array__0 = fn__126
--@ prelude.luma:377:28
local apply_result__240 = _array__1.functions[".."] (unpack (param__181, 1, param__181.n))
local apply_result__241 = flatten_to_array__0 (apply_result__240)
local apply_result__242 = invoke_symbol (apply_result__241, ".concat", 0)
list_result__40 = apply_result__242
--@ unknown:-1:-1
end)()
return list_result__40
end
combine_strings__1 = fn__125
--@ prelude.luma:379:14
local fn__129 = function (param__185)
--@ prelude.luma:379:14
local list_result__42
(function ()
local arg__0
--@ prelude.luma:380:14
local result__37 = --@ prelude.luma:380:16
arg [param__185] or false
arg__0 = result__37
--@ prelude.luma:381:9
local result__38
if arg__0 then
--@ prelude.luma:382:36
local apply_result__243 = ___7 (param__185, 1)
local apply_result__244 = invoke (get_args__0, 1, apply_result__243)
local apply_result__245 = _list__1.functions[".link"] (arg__0, apply_result__244)
result__38 = apply_result__245
else
--@ prelude.luma:383:11
local apply_result__246 = _list__1.functions[0] ()
result__38 = apply_result__246
end
list_result__42 = result__38
--@ unknown:-1:-1
end)()
return list_result__42
end
get_args__0 = fn__129
--@ prelude.luma:385:12
local fn__130 = function ()
--@ prelude.luma:386:13
local _get_time_result__0 = love.timer.getTime()
return _get_time_result__0
end
get_time__1 = fn__130
--@ prelude.luma:388:30
local apply_result__247 = get_args__0 (1)
command_line_args__1 = apply_result__247
--@ prelude.luma:390:2
local table__25
(function ()
--@ prelude.luma:417:22
table__25 = {
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
[".#array"] = _array__1,
[".#hash"] = _hash__1,
[".#pair"] = _pair__1,
[".read-file"] = read_file__1,
[".write-file"] = write_file__1,
[".quote-string"] = quote_string__1,
[".safe-identifier"] = safe_identifier__1,
[".combine-strings"] = combine_strings__1,
[".command-line-args"] = command_line_args__1,
[".get-time"] = get_time__1,
}
--@ unknown:-1:-1
end)()
list_result__1 = table__25
--@ unknown:-1:-1
end)()
_modules_prelude__0 = list_result__1
--@ unknown:-1:-1
local apply_result__248 = _modules_prelude__0[".#bool"]
_bool__0 = apply_result__248
ops.boolean = _bool__0
--@ unknown:-1:-1
local apply_result__249 = _modules_prelude__0[".#string"]
_string__0 = apply_result__249
ops.string = _string__0
--@ unknown:-1:-1
local apply_result__250 = _modules_prelude__0[".#number"]
_number__0 = apply_result__250
ops.number = _number__0
--@ unknown:-1:-1
local apply_result__251 = _modules_prelude__0[".else"]
else__0 = apply_result__251
--@ unknown:-1:-1
local apply_result__252 = _modules_prelude__0[".not"]
not__0 = apply_result__252
--@ unknown:-1:-1
local apply_result__253 = _modules_prelude__0[".+"]
___0 = apply_result__253
--@ unknown:-1:-1
local apply_result__254 = _modules_prelude__0[".-"]
___1 = apply_result__254
--@ unknown:-1:-1
local apply_result__255 = _modules_prelude__0[".*"]
___2 = apply_result__255
--@ unknown:-1:-1
local apply_result__256 = _modules_prelude__0["./"]
___3 = apply_result__256
--@ unknown:-1:-1
local apply_result__257 = _modules_prelude__0[".="]
___4 = apply_result__257
--@ unknown:-1:-1
local apply_result__258 = _modules_prelude__0[".~="]
____0 = apply_result__258
--@ unknown:-1:-1
local apply_result__259 = _modules_prelude__0[".<"]
___5 = apply_result__259
--@ unknown:-1:-1
local apply_result__260 = _modules_prelude__0[".>"]
___6 = apply_result__260
--@ unknown:-1:-1
local apply_result__261 = _modules_prelude__0[".<="]
____1 = apply_result__261
--@ unknown:-1:-1
local apply_result__262 = _modules_prelude__0[".>="]
____2 = apply_result__262
--@ unknown:-1:-1
local apply_result__263 = _modules_prelude__0[".#collection"]
_collection__0 = apply_result__263
--@ unknown:-1:-1
local apply_result__264 = _modules_prelude__0[".#list"]
_list__0 = apply_result__264
--@ unknown:-1:-1
local apply_result__265 = _modules_prelude__0[".#array"]
_array__0 = apply_result__265
--@ unknown:-1:-1
local apply_result__266 = _modules_prelude__0[".#hash"]
_hash__0 = apply_result__266
--@ unknown:-1:-1
local apply_result__267 = _modules_prelude__0[".#pair"]
_pair__0 = apply_result__267
--@ unknown:-1:-1
local apply_result__268 = _modules_prelude__0[".read-file"]
read_file__0 = apply_result__268
--@ unknown:-1:-1
local apply_result__269 = _modules_prelude__0[".write-file"]
write_file__0 = apply_result__269
--@ unknown:-1:-1
local apply_result__270 = _modules_prelude__0[".quote-string"]
quote_string__0 = apply_result__270
--@ unknown:-1:-1
local apply_result__271 = _modules_prelude__0[".safe-identifier"]
safe_identifier__0 = apply_result__271
--@ unknown:-1:-1
local apply_result__272 = _modules_prelude__0[".combine-strings"]
combine_strings__0 = apply_result__272
--@ unknown:-1:-1
local apply_result__273 = _modules_prelude__0[".command-line-args"]
command_line_args__0 = apply_result__273
--@ unknown:-1:-1
local apply_result__274 = _modules_prelude__0[".get-time"]
get_time__0 = apply_result__274
--@ unknown:-1:-1
local list_result__43
(function ()
local error_at__1, assert_at__1
--@ compiler/errors.luma:1:25
local fn__131 = function (param__186, param__187)
--@ compiler/errors.luma:2:52
local apply_result__275 = invoke_symbol (param__186, ".location", 0)
local apply_result__276 = invoke_symbol (apply_result__275, ".to-string", 0)
local apply_result__277 = invoke (combine_strings__0, 3, param__187, " at ", apply_result__276)
local assert_result__13 = assert(false, apply_result__277)
return assert_result__13
end
error_at__1 = fn__131
--@ compiler/errors.luma:4:36
local fn__132 = function (param__188, param__189, param__190)
--@ compiler/errors.luma:5:7
local result__39
--@ compiler/errors.luma:5:22
local apply_result__278 = invoke (not__0, 1, param__188)
if apply_result__278 then
--@ compiler/errors.luma:5:47
local apply_result__279 = error_at__1 (param__189, param__190)
result__39 = apply_result__279
else
result__39 = false 
end
return result__39
end
assert_at__1 = fn__132
--@ compiler/errors.luma:7:2
local table__26
(function ()
--@ compiler/errors.luma:9:24
table__26 = {
[".error-at"] = error_at__1,
[".assert-at"] = assert_at__1,
}
--@ unknown:-1:-1
end)()
list_result__43 = table__26
--@ unknown:-1:-1
end)()
_modules_compiler_errors__0 = list_result__43
--@ unknown:-1:-1
local apply_result__280 = _modules_compiler_errors__0[".error-at"]
error_at__0 = apply_result__280
--@ unknown:-1:-1
local apply_result__281 = _modules_compiler_errors__0[".assert-at"]
assert_at__0 = apply_result__281
--@ unknown:-1:-1
local list_result__44
(function ()
local space_separate__0, _location__1, _token_node__1, _number_node__1, _apply_node__1, _list_node__1, _word_node__1, _vararg_node__1, _string_node__1, _binding_node__1, _field_node__1, _function_node__1, _symbol_function_node__1, _symbol_method_node__1, _symbol_node__1, _table_node__1, _primitive_node__1, _pair_node__1
--@ compiler/ast.luma:1:24
local fn__133 = function (param__191)
--@ compiler/ast.luma:1:24
local list_result__45
(function ()
local out__0, iter__0
--@ compiler/ast.luma:2:15
local apply_result__282 = invoke (_array__0, 0)
out__0 = apply_result__282
--@ compiler/ast.luma:3:14
local apply_result__283 = invoke_symbol (param__191, ".iterator", 0)
iter__0 = apply_result__283
--@ compiler/ast.luma:4:7
local result__40
--@ compiler/ast.luma:4:17
local apply_result__284 = invoke_symbol (iter__0, ".empty?", 0)
local apply_result__285 = invoke (not__0, 1, apply_result__284)
if apply_result__285 then
--@ compiler/ast.luma:4:26
local list_result__46
(function ()
--@ compiler/ast.luma:5:18
local apply_result__286 = invoke_symbol (iter__0, ".item", 0)
local apply_result__287 = invoke_symbol (out__0, ".push", 1, apply_result__286)
--@ compiler/ast.luma:6:9
local apply_result__288 = invoke_symbol (iter__0, ".advance", 0)
list_result__46 = apply_result__288
--@ unknown:-1:-1
end)()
result__40 = list_result__46
else
result__40 = false 
end
--@ compiler/ast.luma:7:22
local fn__134 = function (param__192)
--@ compiler/ast.luma:7:22
local list_result__47
(function ()
--@ compiler/ast.luma:8:17
local apply_result__289 = invoke_symbol (out__0, ".push", 1, " ")
--@ compiler/ast.luma:9:18
local apply_result__290 = invoke_symbol (out__0, ".push", 1, param__192)
list_result__47 = apply_result__290
--@ unknown:-1:-1
end)()
return list_result__47
end
local apply_result__291 = invoke_symbol (iter__0, ".each", 1, fn__134)
--@ compiler/ast.luma:10:6
list_result__45 = out__0
--@ unknown:-1:-1
end)()
return list_result__45
end
space_separate__0 = fn__133
--@ compiler/ast.luma:12:13
local table__27
(function ()
local fn__135 = function (param__193)
--@ compiler/ast.luma:13:29
local result__41 = type (param__193) == "table" and (param__193.index == _location__1 or param__193[_location__1] ~= nil)
return result__41
end
local fn__136 = function (param__194, param__195, param__196)
--@ compiler/ast.luma:14:27
local table__28
(function ()
--@ compiler/ast.luma:18:14
table__28 = {
["index"] = _location__1,
[".filename"] = param__194,
[".line"] = param__195,
[".col"] = param__196,
}
--@ unknown:-1:-1
end)()
return table__28
end
local fn__137 = function ()
--@ compiler/ast.luma:19:42
local apply_result__292 = invoke (_location__1, 3, "unknown", -1, -1)
return apply_result__292
end
local fn__138 = function (param__197)
--@ compiler/ast.luma:21:25
local apply_result__293 = invoke_symbol (param__197, ".filename", 0)
--@ compiler/ast.luma:21:43
local apply_result__294 = invoke_symbol (param__197, ".line", 0)
local apply_result__295 = invoke_symbol (apply_result__294, ".to-string", 0)
--@ compiler/ast.luma:21:67
local apply_result__296 = invoke_symbol (param__197, ".col", 0)
local apply_result__297 = invoke_symbol (apply_result__296, ".to-string", 0)
local apply_result__298 = invoke (combine_strings__0, 5, apply_result__293, ":", apply_result__295, ":", apply_result__297)
return apply_result__298
end
table__27 = {
functions = {
[".?"] = fn__135,
[3] = fn__136,
[".unknown"] = fn__137,
},
methods = {
[".to-string"] = fn__138,
},
}
--@ unknown:-1:-1
end)()
_location__1 = table__27
--@ compiler/ast.luma:23:15
local table__29
(function ()
local fn__139 = function (param__198)
--@ compiler/ast.luma:24:31
local result__42 = type (param__198) == "table" and (param__198.index == _token_node__1 or param__198[_token_node__1] ~= nil)
return result__42
end
local fn__140 = function (param__199)
--@ compiler/ast.luma:25:35
local apply_result__299 = _location__1.functions[".unknown"] ()
local apply_result__300 = invoke (_token_node__1, 2, param__199, apply_result__299)
return apply_result__300
end
local fn__141 = function (param__200, param__201)
--@ compiler/ast.luma:26:21
local table__30
(function ()
--@ compiler/ast.luma:29:24
table__30 = {
["index"] = _token_node__1,
[".id"] = param__200,
[".location"] = param__201,
}
--@ unknown:-1:-1
end)()
return table__30
end
local fn__142 = function (param__202)
--@ compiler/ast.luma:30:51
local apply_result__301 = invoke_symbol (param__202, ".id", 0)
--@ compiler/ast.luma:30:58
local apply_result__302 = invoke (combine_strings__0, 3, "[token ", apply_result__301, "]")
return apply_result__302
end
table__29 = {
functions = {
[".?"] = fn__139,
[1] = fn__140,
[2] = fn__141,
},
methods = {
[".to-string"] = fn__142,
},
}
--@ unknown:-1:-1
end)()
_token_node__1 = table__29
--@ compiler/ast.luma:32:16
local table__31
(function ()
local fn__143 = function (param__203)
--@ compiler/ast.luma:33:32
local result__43 = type (param__203) == "table" and (param__203.index == _number_node__1 or param__203[_number_node__1] ~= nil)
return result__43
end
local fn__144 = function (param__204)
--@ compiler/ast.luma:34:42
local apply_result__303 = _location__1.functions[".unknown"] ()
local apply_result__304 = invoke (_number_node__1, 2, param__204, apply_result__303)
return apply_result__304
end
local fn__145 = function (param__205, param__206)
--@ compiler/ast.luma:35:24
local table__32
(function ()
--@ compiler/ast.luma:38:24
table__32 = {
["index"] = _number_node__1,
[".value"] = param__205,
[".location"] = param__206,
}
--@ unknown:-1:-1
end)()
return table__32
end
local fn__146 = function (param__207)
--@ compiler/ast.luma:39:25
local apply_result__305 = invoke_symbol (param__207, ".value", 0)
local apply_result__306 = invoke_symbol (apply_result__305, ".to-string", 0)
return apply_result__306
end
table__31 = {
functions = {
[".?"] = fn__143,
[1] = fn__144,
[2] = fn__145,
},
methods = {
[".to-string"] = fn__146,
},
}
--@ unknown:-1:-1
end)()
_number_node__1 = table__31
--@ compiler/ast.luma:41:15
local table__33
(function ()
local fn__147 = function (param__208)
--@ compiler/ast.luma:42:31
local result__44 = type (param__208) == "table" and (param__208.index == _apply_node__1 or param__208[_apply_node__1] ~= nil)
return result__44
end
local fn__148 = function (param__209)
--@ compiler/ast.luma:43:41
local apply_result__307 = _location__1.functions[".unknown"] ()
local apply_result__308 = invoke (_apply_node__1, 2, param__209, apply_result__307)
return apply_result__308
end
local fn__149 = function (param__210, param__211)
--@ compiler/ast.luma:44:24
local table__34
(function ()
--@ compiler/ast.luma:47:24
table__34 = {
["index"] = _apply_node__1,
[".items"] = param__210,
[".location"] = param__211,
}
--@ unknown:-1:-1
end)()
return table__34
end
local fn__150 = function (param__212)
--@ compiler/ast.luma:48:20
local list_result__48
(function ()
--@ compiler/ast.luma:49:17
local apply_result__309 = invoke_symbol (param__212, ".items", 0)
local apply_result__310 = invoke_symbol (apply_result__309, ".length", 0)
--@ compiler/ast.luma:49:35
local apply_result__311 = invoke_symbol (apply_result__310, ".>", 1, 0)
local assert_result__14 = assert(apply_result__311)
--@ compiler/ast.luma:52:27
local apply_result__312 = invoke_symbol (param__212, ".items", 0)
local apply_result__313 = invoke_symbol (apply_result__312, ".iterator", 0)
--@ compiler/ast.luma:52:56
local fn__151 = function (param__213)
--@ compiler/ast.luma:52:61
local apply_result__314 = invoke_symbol (param__213, ".to-string", 0)
return apply_result__314
end
local apply_result__315 = invoke_symbol (apply_result__313, ".map", 1, fn__151)
local apply_result__316 = invoke_symbol (apply_result__315, ".to-array", 0)
local apply_result__317 = space_separate__0 (apply_result__316)
--@ compiler/ast.luma:53:10
local apply_result__318 = invoke (combine_strings__0, 3, "[", apply_result__317, "]")
list_result__48 = apply_result__318
--@ unknown:-1:-1
end)()
return list_result__48
end
table__33 = {
functions = {
[".?"] = fn__147,
[1] = fn__148,
[2] = fn__149,
},
methods = {
[".to-string"] = fn__150,
},
}
--@ unknown:-1:-1
end)()
_apply_node__1 = table__33
--@ compiler/ast.luma:55:14
local table__35
(function ()
local fn__152 = function (param__214)
--@ compiler/ast.luma:56:30
local result__45 = type (param__214) == "table" and (param__214.index == _list_node__1 or param__214[_list_node__1] ~= nil)
return result__45
end
local fn__153 = function (param__215)
--@ compiler/ast.luma:57:40
local apply_result__319 = _location__1.functions[".unknown"] ()
local apply_result__320 = invoke (_list_node__1, 2, param__215, apply_result__319)
return apply_result__320
end
local fn__154 = function (param__216, param__217)
--@ compiler/ast.luma:58:24
local table__36
(function ()
--@ compiler/ast.luma:61:24
table__36 = {
["index"] = _list_node__1,
[".items"] = param__216,
[".location"] = param__217,
}
--@ unknown:-1:-1
end)()
return table__36
end
local fn__155 = function (param__218)
--@ compiler/ast.luma:64:10
local apply_result__321 = invoke_symbol (param__218, ".items", 0)
local apply_result__322 = invoke_symbol (apply_result__321, ".iterator", 0)
--@ compiler/ast.luma:64:36
local fn__156 = function (param__219)
--@ compiler/ast.luma:64:59
local apply_result__323 = invoke_symbol (param__219, ".to-string", 0)
local apply_result__324 = invoke (combine_strings__0, 2, " ", apply_result__323)
return apply_result__324
end
local apply_result__325 = invoke_symbol (apply_result__322, ".map", 1, fn__156)
local apply_result__326 = invoke_symbol (apply_result__325, ".to-array", 0)
--@ compiler/ast.luma:65:8
local apply_result__327 = invoke (combine_strings__0, 3, "[!", apply_result__326, "]")
return apply_result__327
end
table__35 = {
functions = {
[".?"] = fn__152,
[1] = fn__153,
[2] = fn__154,
},
methods = {
[".to-string"] = fn__155,
},
}
--@ unknown:-1:-1
end)()
_list_node__1 = table__35
--@ compiler/ast.luma:67:14
local table__37
(function ()
local fn__157 = function (param__220)
--@ compiler/ast.luma:68:30
local result__46 = type (param__220) == "table" and (param__220.index == _word_node__1 or param__220[_word_node__1] ~= nil)
return result__46
end
local fn__158 = function (param__221)
--@ compiler/ast.luma:69:34
local apply_result__328 = _location__1.functions[".unknown"] ()
local apply_result__329 = invoke (_word_node__1, 2, param__221, apply_result__328)
return apply_result__329
end
local fn__159 = function (param__222, param__223)
--@ compiler/ast.luma:70:21
local table__38
(function ()
--@ compiler/ast.luma:73:24
table__38 = {
["index"] = _word_node__1,
[".id"] = param__222,
[".location"] = param__223,
}
--@ unknown:-1:-1
end)()
return table__38
end
local fn__160 = function (param__224)
--@ compiler/ast.luma:74:25
local apply_result__330 = invoke_symbol (param__224, ".id", 0)
return apply_result__330
end
table__37 = {
functions = {
[".?"] = fn__157,
[1] = fn__158,
[2] = fn__159,
},
methods = {
[".to-string"] = fn__160,
},
}
--@ unknown:-1:-1
end)()
_word_node__1 = table__37
--@ compiler/ast.luma:76:16
local table__39
(function ()
local fn__161 = function (param__225)
--@ compiler/ast.luma:77:32
local result__47 = type (param__225) == "table" and (param__225.index == _vararg_node__1 or param__225[_vararg_node__1] ~= nil)
return result__47
end
local fn__162 = function (param__226)
--@ compiler/ast.luma:78:36
local apply_result__331 = _location__1.functions[".unknown"] ()
local apply_result__332 = invoke (_vararg_node__1, 2, param__226, apply_result__331)
return apply_result__332
end
local fn__163 = function (param__227, param__228)
--@ compiler/ast.luma:79:21
local table__40
(function ()
--@ compiler/ast.luma:82:24
table__40 = {
["index"] = _vararg_node__1,
[".id"] = param__227,
[".location"] = param__228,
}
--@ unknown:-1:-1
end)()
return table__40
end
local fn__164 = function (param__229)
--@ compiler/ast.luma:83:25
local apply_result__333 = invoke_symbol (param__229, ".id", 0)
return apply_result__333
end
table__39 = {
functions = {
[".?"] = fn__161,
[1] = fn__162,
[2] = fn__163,
},
methods = {
[".to-string"] = fn__164,
},
}
--@ unknown:-1:-1
end)()
_vararg_node__1 = table__39
--@ compiler/ast.luma:85:16
local table__41
(function ()
local fn__165 = function (param__230)
--@ compiler/ast.luma:86:32
local result__48 = type (param__230) == "table" and (param__230.index == _string_node__1 or param__230[_string_node__1] ~= nil)
return result__48
end
local fn__166 = function (param__231)
--@ compiler/ast.luma:87:42
local apply_result__334 = _location__1.functions[".unknown"] ()
local apply_result__335 = invoke (_string_node__1, 2, param__231, apply_result__334)
return apply_result__335
end
local fn__167 = function (param__232, param__233)
--@ compiler/ast.luma:88:24
local table__42
(function ()
--@ compiler/ast.luma:91:24
table__42 = {
["index"] = _string_node__1,
[".value"] = param__232,
[".location"] = param__233,
}
--@ unknown:-1:-1
end)()
return table__42
end
local fn__168 = function (param__234)
--@ compiler/ast.luma:92:46
local apply_result__336 = invoke_symbol (param__234, ".value", 0)
--@ compiler/ast.luma:92:57
local apply_result__337 = invoke (combine_strings__0, 3, "'", apply_result__336, "'")
return apply_result__337
end
table__41 = {
functions = {
[".?"] = fn__165,
[1] = fn__166,
[2] = fn__167,
},
methods = {
[".to-string"] = fn__168,
},
}
--@ unknown:-1:-1
end)()
_string_node__1 = table__41
--@ compiler/ast.luma:94:17
local table__43
(function ()
local fn__169 = function (param__235)
--@ compiler/ast.luma:95:33
local result__49 = type (param__235) == "table" and (param__235.index == _binding_node__1 or param__235[_binding_node__1] ~= nil)
return result__49
end
local fn__170 = function (param__236, param__237)
--@ compiler/ast.luma:96:49
local apply_result__338 = _location__1.functions[".unknown"] ()
local apply_result__339 = invoke (_binding_node__1, 3, param__236, param__237, apply_result__338)
return apply_result__339
end
local fn__171 = function (param__238, param__239, param__240)
--@ compiler/ast.luma:97:27
local table__44
(function ()
--@ compiler/ast.luma:101:24
table__44 = {
["index"] = _binding_node__1,
[".id"] = param__238,
[".value"] = param__239,
[".location"] = param__240,
}
--@ unknown:-1:-1
end)()
return table__44
end
local fn__172 = function (param__241)
--@ compiler/ast.luma:102:41
local apply_result__340 = invoke_symbol (param__241, ".id", 0)
--@ compiler/ast.luma:102:54
local apply_result__341 = invoke_symbol (param__241, ".value", 0)
local apply_result__342 = invoke_symbol (apply_result__341, ".to-string", 0)
local apply_result__343 = invoke (combine_strings__0, 3, apply_result__340, ": ", apply_result__342)
return apply_result__343
end
table__43 = {
functions = {
[".?"] = fn__169,
[2] = fn__170,
[3] = fn__171,
},
methods = {
[".to-string"] = fn__172,
},
}
--@ unknown:-1:-1
end)()
_binding_node__1 = table__43
--@ compiler/ast.luma:104:15
local table__45
(function ()
local fn__173 = function (param__242)
--@ compiler/ast.luma:105:31
local result__50 = type (param__242) == "table" and (param__242.index == _field_node__1 or param__242[_field_node__1] ~= nil)
return result__50
end
local fn__174 = function (param__243, param__244)
--@ compiler/ast.luma:106:47
local apply_result__344 = _location__1.functions[".unknown"] ()
local apply_result__345 = invoke (_field_node__1, 3, param__243, param__244, apply_result__344)
return apply_result__345
end
local fn__175 = function (param__245, param__246, param__247)
--@ compiler/ast.luma:107:27
local table__46
(function ()
--@ compiler/ast.luma:111:24
table__46 = {
["index"] = _field_node__1,
[".id"] = param__245,
[".value"] = param__246,
[".location"] = param__247,
}
--@ unknown:-1:-1
end)()
return table__46
end
local fn__176 = function (param__248)
--@ compiler/ast.luma:112:41
local apply_result__346 = invoke_symbol (param__248, ".id", 0)
--@ compiler/ast.luma:112:54
local apply_result__347 = invoke_symbol (param__248, ".value", 0)
local apply_result__348 = invoke_symbol (apply_result__347, ".to-string", 0)
local apply_result__349 = invoke (combine_strings__0, 3, apply_result__346, ": ", apply_result__348)
return apply_result__349
end
table__45 = {
functions = {
[".?"] = fn__173,
[2] = fn__174,
[3] = fn__175,
},
methods = {
[".to-string"] = fn__176,
},
}
--@ unknown:-1:-1
end)()
_field_node__1 = table__45
--@ compiler/ast.luma:115:18
local table__47
(function ()
local fn__177 = function (param__249)
--@ compiler/ast.luma:116:34
local result__51 = type (param__249) == "table" and (param__249.index == _function_node__1 or param__249[_function_node__1] ~= nil)
return result__51
end
local fn__178 = function (param__250, param__251)
--@ compiler/ast.luma:117:56
local apply_result__350 = _location__1.functions[".unknown"] ()
local apply_result__351 = invoke (_function_node__1, 3, param__250, param__251, apply_result__350)
return apply_result__351
end
local fn__179 = function (param__252, param__253, param__254)
--@ compiler/ast.luma:118:30
local table__48
(function ()
--@ compiler/ast.luma:122:24
table__48 = {
["index"] = _function_node__1,
[".params"] = param__252,
[".body"] = param__253,
[".location"] = param__254,
}
--@ unknown:-1:-1
end)()
return table__48
end
local fn__180 = function (param__255)
--@ compiler/ast.luma:125:9
local apply_result__352 = invoke_symbol (param__255, ".params", 0)
--@ compiler/ast.luma:125:27
local fn__181 = function (param__256)
--@ compiler/ast.luma:125:50
local apply_result__353 = invoke (combine_strings__0, 2, " ", param__256)
return apply_result__353
end
local apply_result__354 = invoke_symbol (apply_result__352, ".map", 1, fn__181)
--@ compiler/ast.luma:127:9
local apply_result__355 = invoke_symbol (param__255, ".body", 0)
local apply_result__356 = invoke_symbol (apply_result__355, ".to-string", 0)
local apply_result__357 = invoke (combine_strings__0, 4, "[.", apply_result__354, "]: ", apply_result__356)
return apply_result__357
end
table__47 = {
functions = {
[".?"] = fn__177,
[2] = fn__178,
[3] = fn__179,
},
methods = {
[".to-string"] = fn__180,
},
}
--@ unknown:-1:-1
end)()
_function_node__1 = table__47
--@ compiler/ast.luma:129:25
local table__49
(function ()
local fn__182 = function (param__257)
--@ compiler/ast.luma:130:41
local result__52 = type (param__257) == "table" and (param__257.index == _symbol_function_node__1 or param__257[_symbol_function_node__1] ~= nil)
return result__52
end
local fn__183 = function (param__258, param__259)
--@ compiler/ast.luma:131:63
local apply_result__358 = _location__1.functions[".unknown"] ()
local apply_result__359 = invoke (_symbol_function_node__1, 3, param__258, param__259, apply_result__358)
return apply_result__359
end
local fn__184 = function (param__260, param__261, param__262, param__263)
--@ compiler/ast.luma:132:37
local table__50
(function ()
--@ compiler/ast.luma:137:24
table__50 = {
["index"] = _symbol_function_node__1,
[".symbol"] = param__260,
[".params"] = param__261,
[".body"] = param__262,
[".location"] = param__263,
}
--@ unknown:-1:-1
end)()
return table__50
end
local fn__185 = function (param__264)
--@ compiler/ast.luma:139:21
local apply_result__360 = invoke_symbol (param__264, ".symbol", 0)
local apply_result__361 = invoke (_list__0, 2, "[. ", apply_result__360)
--@ compiler/ast.luma:140:9
local apply_result__362 = invoke_symbol (param__264, ".params", 0)
--@ compiler/ast.luma:140:27
local fn__186 = function (param__265)
--@ compiler/ast.luma:140:50
local apply_result__363 = invoke (combine_strings__0, 2, " ", param__265)
return apply_result__363
end
local apply_result__364 = invoke_symbol (apply_result__362, ".map", 1, fn__186)
--@ compiler/ast.luma:141:21
local apply_result__365 = invoke_symbol (param__264, ".body", 0)
local apply_result__366 = invoke_symbol (apply_result__365, ".to-string", 0)
local apply_result__367 = invoke (_list__0, 2, "]: ", apply_result__366)
local apply_result__368 = invoke (combine_strings__0, 3, apply_result__361, apply_result__364, apply_result__367)
return apply_result__368
end
table__49 = {
functions = {
[".?"] = fn__182,
[2] = fn__183,
[4] = fn__184,
},
methods = {
[".to-string"] = fn__185,
},
}
--@ unknown:-1:-1
end)()
_symbol_function_node__1 = table__49
--@ compiler/ast.luma:143:23
local table__51
(function ()
local fn__187 = function (param__266)
--@ compiler/ast.luma:144:39
local result__53 = type (param__266) == "table" and (param__266.index == _symbol_method_node__1 or param__266[_symbol_method_node__1] ~= nil)
return result__53
end
local fn__188 = function (param__267, param__268)
--@ compiler/ast.luma:145:61
local apply_result__369 = _location__1.functions[".unknown"] ()
local apply_result__370 = invoke (_symbol_method_node__1, 3, param__267, param__268, apply_result__369)
return apply_result__370
end
local fn__189 = function (param__269, param__270, param__271, param__272)
--@ compiler/ast.luma:146:37
local table__52
(function ()
--@ compiler/ast.luma:151:24
table__52 = {
["index"] = _symbol_method_node__1,
[".symbol"] = param__269,
[".params"] = param__270,
[".body"] = param__271,
[".location"] = param__272,
}
--@ unknown:-1:-1
end)()
return table__52
end
local fn__190 = function (param__273)
--@ compiler/ast.luma:152:20
local list_result__49
(function ()
local iter__1, first__1
--@ compiler/ast.luma:153:15
local apply_result__371 = invoke_symbol (param__273, ".params", 0)
local apply_result__372 = invoke_symbol (apply_result__371, ".iterator", 0)
iter__1 = apply_result__372
--@ compiler/ast.luma:154:16
local apply_result__373 = invoke_symbol (iter__1, ".item", 0)
first__1 = apply_result__373
--@ compiler/ast.luma:155:9
local apply_result__374 = invoke_symbol (iter__1, ".advance", 0)
--@ compiler/ast.luma:157:27
local apply_result__375 = invoke_symbol (param__273, ".symbol", 0)
local apply_result__376 = invoke (_list__0, 3, "[", first__1, apply_result__375)
--@ compiler/ast.luma:158:23
local fn__191 = function (param__274)
--@ compiler/ast.luma:158:46
local apply_result__377 = invoke (combine_strings__0, 2, " ", param__274)
return apply_result__377
end
local apply_result__378 = invoke_symbol (iter__1, ".map", 1, fn__191)
local apply_result__379 = invoke_symbol (apply_result__378, ".to-array", 0)
--@ compiler/ast.luma:159:23
local apply_result__380 = invoke_symbol (param__273, ".body", 0)
local apply_result__381 = invoke_symbol (apply_result__380, ".to-string", 0)
local apply_result__382 = invoke (_list__0, 2, "]: ", apply_result__381)
local apply_result__383 = invoke (combine_strings__0, 3, apply_result__376, apply_result__379, apply_result__382)
list_result__49 = apply_result__383
--@ unknown:-1:-1
end)()
return list_result__49
end
table__51 = {
functions = {
[".?"] = fn__187,
[2] = fn__188,
[4] = fn__189,
},
methods = {
[".to-string"] = fn__190,
},
}
--@ unknown:-1:-1
end)()
_symbol_method_node__1 = table__51
--@ compiler/ast.luma:161:16
local table__53
(function ()
local fn__192 = function (param__275)
--@ compiler/ast.luma:162:32
local result__54 = type (param__275) == "table" and (param__275.index == _symbol_node__1 or param__275[_symbol_node__1] ~= nil)
return result__54
end
local fn__193 = function (param__276)
--@ compiler/ast.luma:163:36
local apply_result__384 = _location__1.functions[".unknown"] ()
local apply_result__385 = invoke (_symbol_node__1, 2, param__276, apply_result__384)
return apply_result__385
end
local fn__194 = function (param__277, param__278)
--@ compiler/ast.luma:164:21
local table__54
(function ()
--@ compiler/ast.luma:167:24
table__54 = {
["index"] = _symbol_node__1,
[".id"] = param__277,
[".location"] = param__278,
}
--@ unknown:-1:-1
end)()
return table__54
end
local fn__195 = function (param__279)
--@ compiler/ast.luma:168:25
local apply_result__386 = invoke_symbol (param__279, ".id", 0)
return apply_result__386
end
table__53 = {
functions = {
[".?"] = fn__192,
[1] = fn__193,
[2] = fn__194,
},
methods = {
[".to-string"] = fn__195,
},
}
--@ unknown:-1:-1
end)()
_symbol_node__1 = table__53
--@ compiler/ast.luma:170:15
local table__55
(function ()
local fn__196 = function (param__280)
--@ compiler/ast.luma:171:31
local result__55 = type (param__280) == "table" and (param__280.index == _table_node__1 or param__280[_table_node__1] ~= nil)
return result__55
end
local fn__197 = function (param__281)
--@ compiler/ast.luma:172:41
local apply_result__387 = _location__1.functions[".unknown"] ()
local apply_result__388 = invoke (_table_node__1, 2, param__281, apply_result__387)
return apply_result__388
end
local fn__198 = function (param__282, param__283)
--@ compiler/ast.luma:173:24
local table__56
(function ()
--@ compiler/ast.luma:176:24
table__56 = {
["index"] = _table_node__1,
[".items"] = param__282,
[".location"] = param__283,
}
--@ unknown:-1:-1
end)()
return table__56
end
local fn__199 = function (param__284)
--@ compiler/ast.luma:180:12
local apply_result__389 = invoke_symbol (param__284, ".items", 0)
local apply_result__390 = invoke_symbol (apply_result__389, ".iterator", 0)
--@ compiler/ast.luma:180:38
local fn__200 = function (param__285)
--@ compiler/ast.luma:180:61
local apply_result__391 = invoke_symbol (param__285, ".to-string", 0)
local apply_result__392 = invoke (combine_strings__0, 2, " ", apply_result__391)
return apply_result__392
end
local apply_result__393 = invoke_symbol (apply_result__390, ".map", 1, fn__200)
local apply_result__394 = invoke_symbol (apply_result__393, ".to-array", 0)
--@ compiler/ast.luma:181:10
local apply_result__395 = invoke (combine_strings__0, 3, "[#", apply_result__394, "]")
return apply_result__395
end
table__55 = {
functions = {
[".?"] = fn__196,
[1] = fn__197,
[2] = fn__198,
},
methods = {
[".to-string"] = fn__199,
},
}
--@ unknown:-1:-1
end)()
_table_node__1 = table__55
--@ compiler/ast.luma:183:19
local table__57
(function ()
local fn__201 = function (param__286)
--@ compiler/ast.luma:184:35
local result__56 = type (param__286) == "table" and (param__286.index == _primitive_node__1 or param__286[_primitive_node__1] ~= nil)
return result__56
end
local fn__202 = function (param__287)
--@ compiler/ast.luma:185:39
local apply_result__396 = _location__1.functions[".unknown"] ()
local apply_result__397 = invoke (_primitive_node__1, 2, param__287, apply_result__396)
return apply_result__397
end
local fn__203 = function (param__288, param__289)
--@ compiler/ast.luma:186:21
local table__58
(function ()
--@ compiler/ast.luma:189:24
table__58 = {
["index"] = _primitive_node__1,
[".fn"] = param__288,
[".location"] = param__289,
}
--@ unknown:-1:-1
end)()
return table__58
end
local fn__204 = function (param__290)
--@ compiler/ast.luma:190:29
return "<prim>"
end
table__57 = {
functions = {
[".?"] = fn__201,
[1] = fn__202,
[2] = fn__203,
},
methods = {
[".to-string"] = fn__204,
},
}
--@ unknown:-1:-1
end)()
_primitive_node__1 = table__57
--@ compiler/ast.luma:192:14
local table__59
(function ()
local fn__205 = function (param__291)
--@ compiler/ast.luma:193:30
local result__57 = type (param__291) == "table" and (param__291.index == _pair_node__1 or param__291[_pair_node__1] ~= nil)
return result__57
end
local fn__206 = function (param__292, param__293)
--@ compiler/ast.luma:194:48
local apply_result__398 = _location__1.functions[".unknown"] ()
local apply_result__399 = invoke (_pair_node__1, 3, param__292, param__293, apply_result__398)
return apply_result__399
end
local fn__207 = function (param__294, param__295, param__296)
--@ compiler/ast.luma:195:28
local table__60
(function ()
--@ compiler/ast.luma:199:24
table__60 = {
["index"] = _pair_node__1,
[".key"] = param__294,
[".value"] = param__295,
[".location"] = param__296,
}
--@ unknown:-1:-1
end)()
return table__60
end
local fn__208 = function (param__297)
--@ compiler/ast.luma:201:25
local apply_result__400 = invoke_symbol (param__297, ".key", 0)
local apply_result__401 = invoke_symbol (apply_result__400, ".to-string", 0)
--@ compiler/ast.luma:201:49
local apply_result__402 = invoke_symbol (param__297, ".value", 0)
local apply_result__403 = invoke_symbol (apply_result__402, ".to-string", 0)
local apply_result__404 = invoke (combine_strings__0, 3, apply_result__401, ": ", apply_result__403)
return apply_result__404
end
table__59 = {
functions = {
[".?"] = fn__205,
[2] = fn__206,
[3] = fn__207,
},
methods = {
[".to-string"] = fn__208,
},
}
--@ unknown:-1:-1
end)()
_pair_node__1 = table__59
--@ compiler/ast.luma:203:2
local table__61
(function ()
--@ compiler/ast.luma:220:26
table__61 = {
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
--@ unknown:-1:-1
end)()
list_result__44 = table__61
--@ unknown:-1:-1
end)()
_modules_compiler_ast__0 = list_result__44
--@ unknown:-1:-1
local apply_result__405 = _modules_compiler_ast__0[".#location"]
_location__0 = apply_result__405
--@ unknown:-1:-1
local apply_result__406 = _modules_compiler_ast__0[".#token-node"]
_token_node__0 = apply_result__406
--@ unknown:-1:-1
local apply_result__407 = _modules_compiler_ast__0[".#number-node"]
_number_node__0 = apply_result__407
--@ unknown:-1:-1
local apply_result__408 = _modules_compiler_ast__0[".#apply-node"]
_apply_node__0 = apply_result__408
--@ unknown:-1:-1
local apply_result__409 = _modules_compiler_ast__0[".#list-node"]
_list_node__0 = apply_result__409
--@ unknown:-1:-1
local apply_result__410 = _modules_compiler_ast__0[".#word-node"]
_word_node__0 = apply_result__410
--@ unknown:-1:-1
local apply_result__411 = _modules_compiler_ast__0[".#vararg-node"]
_vararg_node__0 = apply_result__411
--@ unknown:-1:-1
local apply_result__412 = _modules_compiler_ast__0[".#string-node"]
_string_node__0 = apply_result__412
--@ unknown:-1:-1
local apply_result__413 = _modules_compiler_ast__0[".#binding-node"]
_binding_node__0 = apply_result__413
--@ unknown:-1:-1
local apply_result__414 = _modules_compiler_ast__0[".#field-node"]
_field_node__0 = apply_result__414
--@ unknown:-1:-1
local apply_result__415 = _modules_compiler_ast__0[".#function-node"]
_function_node__0 = apply_result__415
--@ unknown:-1:-1
local apply_result__416 = _modules_compiler_ast__0[".#symbol-function-node"]
_symbol_function_node__0 = apply_result__416
--@ unknown:-1:-1
local apply_result__417 = _modules_compiler_ast__0[".#symbol-method-node"]
_symbol_method_node__0 = apply_result__417
--@ unknown:-1:-1
local apply_result__418 = _modules_compiler_ast__0[".#symbol-node"]
_symbol_node__0 = apply_result__418
--@ unknown:-1:-1
local apply_result__419 = _modules_compiler_ast__0[".#table-node"]
_table_node__0 = apply_result__419
--@ unknown:-1:-1
local apply_result__420 = _modules_compiler_ast__0[".#primitive-node"]
_primitive_node__0 = apply_result__420
--@ unknown:-1:-1
local apply_result__421 = _modules_compiler_ast__0[".#pair-node"]
_pair_node__0 = apply_result__421
--@ unknown:-1:-1
local list_result__50
(function ()
local read__1
--@ compiler/read.luma:1:21
local fn__209 = function (param__298, param__299)
--@ compiler/read.luma:1:21
local list_result__51
(function ()
local i__4, line__0, col__0, char__0, peek__0, advance__0, emit_index__0, pending_text__0, discard__0, is_char___0, is_in___0, is_space___0, begins_word___0, continues_word___0, begins_number___0, continues_number___0, tokens__0, emit__0, skip_space__0, skip_comment__0, skip_space_and_comments__0, indent_levels__0, paren_level__0, current_indent__0, read_new_line__0, read_word__0, read_number__0, read_string__0, read_token__0, unindent_loop__0
--@ compiler/read.luma:3:7
i__4 = 0
--@ compiler/read.luma:4:10
line__0 = 1
--@ compiler/read.luma:5:9
col__0 = 0
--@ compiler/read.luma:6:11
char__0 = ""
--@ compiler/read.luma:8:10
local fn__210 = function ()
--@ compiler/read.luma:9:21
local apply_result__422 = invoke_symbol (char__0, ".length", 0)
local apply_result__423 = invoke (___0, 2, i__4, apply_result__422)
--@ compiler/read.luma:9:33
local apply_result__424 = invoke_symbol (param__298, ".length", 0)
local apply_result__425 = invoke (___5, 2, apply_result__423, apply_result__424)
local result__58 = apply_result__425
if result__58 then
--@ compiler/read.luma:10:36
local apply_result__426 = invoke_symbol (char__0, ".length", 0)
local apply_result__427 = invoke (___0, 2, i__4, apply_result__426)
local apply_result__428 = invoke_symbol (param__298, ".utf8-char-at", 1, apply_result__427)
result__58 = apply_result__428
end
return result__58
end
peek__0 = fn__210
--@ compiler/read.luma:12:13
local fn__211 = function ()
--@ compiler/read.luma:12:13
local list_result__52
(function ()
local len__1
--@ compiler/read.luma:13:32
local op_result__19 = char__0 == false
local apply_result__429 = invoke (not__0, 1, op_result__19)
--@ compiler/read.luma:13:51
local assert_result__15 = assert(apply_result__429, "passed the end")
--@ compiler/read.luma:15:9
local result__59
--@ compiler/read.luma:16:21
local op_result__20 = char__0 == "\
"
if op_result__20 then
--@ compiler/read.luma:16:23
local list_result__53
(function ()
--@ compiler/read.luma:17:27
local apply_result__430 = invoke (___0, 2, line__0, 1)
line__0 = apply_result__430
--@ compiler/read.luma:18:18
col__0 = 1
list_result__53 = true
--@ unknown:-1:-1
end)()
result__59 = list_result__53
else
--@ compiler/read.luma:19:11
if else__0 then
--@ compiler/read.luma:20:25
local apply_result__431 = invoke (___0, 2, col__0, 1)
col__0 = apply_result__431
result__59 = true
else
result__59 = false 
end
end
--@ compiler/read.luma:22:14
local apply_result__432 = invoke_symbol (char__0, ".length", 0)
len__1 = apply_result__432
--@ compiler/read.luma:23:19
local apply_result__433 = peek__0 ()
char__0 = apply_result__433
--@ compiler/read.luma:24:19
local apply_result__434 = invoke (___0, 2, i__4, len__1)
i__4 = apply_result__434
list_result__52 = true
--@ unknown:-1:-1
end)()
return list_result__52
end
advance__0 = fn__211
--@ compiler/read.luma:26:11
local apply_result__435 = advance__0 ()
--@ compiler/read.luma:29:16
emit_index__0 = 0
--@ compiler/read.luma:30:18
local fn__212 = function ()
--@ compiler/read.luma:30:47
local apply_result__436 = invoke_symbol (param__298, ".substring", 2, emit_index__0, i__4)
return apply_result__436
end
pending_text__0 = fn__212
--@ compiler/read.luma:31:13
local fn__213 = function ()
--@ compiler/read.luma:31:37
emit_index__0 = i__4
return true
end
discard__0 = fn__213
--@ compiler/read.luma:34:16
local fn__214 = function (param__300)
--@ compiler/read.luma:34:33
local apply_result__437 = invoke (___4, 2, param__300, char__0)
return apply_result__437
end
is_char___0 = fn__214
--@ compiler/read.luma:35:20
local fn__215 = function (param__301)
--@ compiler/read.luma:35:32
local result__60 = char__0
if result__60 then
--@ compiler/read.luma:35:56
local apply_result__438 = invoke_symbol (param__301, ".contains?", 1, char__0)
result__60 = apply_result__438
end
return result__60
end
is_in___0 = fn__215
--@ compiler/read.luma:36:15
local fn__216 = function ()
--@ compiler/read.luma:36:36
local apply_result__439 = is_in___0 (" \9")
return apply_result__439
end
is_space___0 = fn__216
--@ compiler/read.luma:37:18
local fn__217 = function ()
--@ compiler/read.luma:37:32
local result__61 = char__0
if result__61 then
--@ compiler/read.luma:37:60
local apply_result__440 = is_in___0 ("\
\9 :[]()'")
local apply_result__441 = invoke (not__0, 1, apply_result__440)
result__61 = apply_result__441
end
return result__61
end
begins_word___0 = fn__217
--@ compiler/read.luma:38:21
local fn__218 = function ()
--@ compiler/read.luma:38:32
local result__62 = char__0
if result__62 then
--@ compiler/read.luma:38:61
local apply_result__442 = is_in___0 ("\
\9 .:[]()'")
local apply_result__443 = invoke (not__0, 1, apply_result__442)
result__62 = apply_result__443
end
return result__62
end
continues_word___0 = fn__218
--@ compiler/read.luma:39:20
local fn__219 = function ()
--@ compiler/read.luma:39:32
local result__63 = char__0
if result__63 then
--@ compiler/read.luma:39:54
local apply_result__444 = is_in___0 ("-0123456789")
result__63 = apply_result__444
end
return result__63
end
begins_number___0 = fn__219
--@ compiler/read.luma:40:23
local fn__220 = function ()
--@ compiler/read.luma:40:32
local result__64 = char__0
if result__64 then
--@ compiler/read.luma:40:60
local apply_result__445 = is_in___0 ("\
\9 :[]()'")
local apply_result__446 = invoke (not__0, 1, apply_result__445)
result__64 = apply_result__446
end
return result__64
end
continues_number___0 = fn__220
--@ compiler/read.luma:43:18
local apply_result__447 = invoke (_array__0, 0)
tokens__0 = apply_result__447
--@ compiler/read.luma:44:16
local fn__221 = function (param__302)
--@ compiler/read.luma:44:16
local list_result__54
(function ()
local location__0
--@ compiler/read.luma:45:42
local apply_result__448 = invoke (_location__0, 3, param__299, line__0, col__0)
location__0 = apply_result__448
--@ compiler/read.luma:46:44
local apply_result__449 = invoke (_token_node__0, 2, param__302, location__0)
local apply_result__450 = invoke_symbol (tokens__0, ".push", 1, apply_result__449)
--@ compiler/read.luma:47:13
local apply_result__451 = discard__0 ()
list_result__54 = apply_result__451
--@ unknown:-1:-1
end)()
return list_result__54
end
emit__0 = fn__221
--@ compiler/read.luma:49:16
local fn__222 = function ()
--@ compiler/read.luma:50:9
local result__65
--@ compiler/read.luma:51:17
local apply_result__452 = is_space___0 ()
if apply_result__452 then
--@ compiler/read.luma:51:19
local list_result__55
(function ()
--@ compiler/read.luma:52:17
local apply_result__453 = advance__0 ()
--@ compiler/read.luma:53:20
local apply_result__454 = invoke (skip_space__0, 0)
list_result__55 = apply_result__454
--@ unknown:-1:-1
end)()
result__65 = list_result__55
else
--@ compiler/read.luma:54:11
if else__0 then
--@ compiler/read.luma:55:17
local apply_result__455 = discard__0 ()
result__65 = apply_result__455
else
result__65 = false 
end
end
return result__65
end
skip_space__0 = fn__222
--@ compiler/read.luma:57:18
local fn__223 = function ()
--@ compiler/read.luma:57:18
local list_result__56
(function ()
local depth__0
--@ compiler/read.luma:58:13
local apply_result__456 = advance__0 ()
--@ compiler/read.luma:59:13
depth__0 = 1
--@ compiler/read.luma:60:22
local apply_result__457 = invoke_symbol (depth__0, ".>", 1, 0)
local while_condition__9 = apply_result__457
while while_condition__9 do
--@ compiler/read.luma:60:24
local list_result__57
(function ()
--@ compiler/read.luma:61:11
local result__66
--@ compiler/read.luma:62:22
local apply_result__458 = is_char___0 ("(")
if apply_result__458 then
--@ compiler/read.luma:63:32
local apply_result__459 = invoke_symbol (depth__0, ".+", 1, 1)
depth__0 = apply_result__459
result__66 = true
else
--@ compiler/read.luma:64:22
local apply_result__460 = is_char___0 (")")
if apply_result__460 then
--@ compiler/read.luma:65:32
local apply_result__461 = invoke_symbol (depth__0, ".-", 1, 1)
depth__0 = apply_result__461
result__66 = true
else
result__66 = false 
end
end
--@ compiler/read.luma:66:15
local apply_result__462 = advance__0 ()
list_result__57 = apply_result__462
--@ unknown:-1:-1
end)()
local _ = list_result__57
--@ compiler/read.luma:60:22
local apply_result__463 = invoke_symbol (depth__0, ".>", 1, 0)
while_condition__9 = apply_result__463
end
--@ compiler/read.luma:67:13
local apply_result__464 = discard__0 ()
list_result__56 = apply_result__464
--@ unknown:-1:-1
end)()
return list_result__56
end
skip_comment__0 = fn__223
--@ compiler/read.luma:69:29
local fn__224 = function ()
--@ compiler/read.luma:70:25
local apply_result__465 = is_space___0 ()
local result__67 = apply_result__465
if not result__67 then
--@ compiler/read.luma:70:40
local apply_result__466 = is_char___0 ("(")
result__67 = apply_result__466
end
local while_condition__10 = result__67
while while_condition__10 do
--@ compiler/read.luma:70:43
local list_result__58
(function ()
--@ compiler/read.luma:71:18
local apply_result__467 = skip_space__0 ()
--@ compiler/read.luma:72:11
local result__68
--@ compiler/read.luma:72:25
local apply_result__468 = is_char___0 ("(")
if apply_result__468 then
--@ compiler/read.luma:73:22
local apply_result__469 = skip_comment__0 ()
result__68 = apply_result__469
else
result__68 = false 
end
list_result__58 = result__68
--@ unknown:-1:-1
end)()
local _ = list_result__58
--@ compiler/read.luma:70:25
local apply_result__470 = is_space___0 ()
local result__69 = apply_result__470
if not result__69 then
--@ compiler/read.luma:70:40
local apply_result__471 = is_char___0 ("(")
result__69 = apply_result__471
end
while_condition__10 = result__69
end
return false
end
skip_space_and_comments__0 = fn__224
--@ compiler/read.luma:76:28
local apply_result__472 = invoke (_array__0, 1, -1)
indent_levels__0 = apply_result__472
--@ compiler/read.luma:77:17
paren_level__0 = 0
--@ compiler/read.luma:78:20
local fn__225 = function ()
--@ compiler/read.luma:78:34
local apply_result__473 = invoke_symbol (indent_levels__0, ".peek", 0)
return apply_result__473
end
current_indent__0 = fn__225
--@ compiler/read.luma:81:19
local fn__226 = function ()
--@ compiler/read.luma:81:19
local list_result__59
(function ()
local read_whitespace__0, indent__0
--@ compiler/read.luma:83:23
local fn__227 = function ()
--@ compiler/read.luma:84:11
local result__70
--@ compiler/read.luma:84:21
local result__71 = char__0
if result__71 then
--@ compiler/read.luma:84:32
local apply_result__474 = is_space___0 ()
result__71 = apply_result__474
end
if result__71 then
--@ compiler/read.luma:84:35
local list_result__60
(function ()
--@ compiler/read.luma:85:17
local apply_result__475 = advance__0 ()
--@ compiler/read.luma:86:25
local apply_result__476 = invoke (read_whitespace__0, 0)
list_result__60 = apply_result__476
--@ unknown:-1:-1
end)()
result__70 = list_result__60
else
result__70 = false 
end
return result__70
end
read_whitespace__0 = fn__227
--@ compiler/read.luma:87:21
local apply_result__477 = read_whitespace__0 ()
--@ compiler/read.luma:88:26
local apply_result__478 = pending_text__0 ()
local apply_result__479 = invoke_symbol (apply_result__478, ".length", 0)
indent__0 = apply_result__479
--@ compiler/read.luma:89:13
local apply_result__480 = discard__0 ()
--@ compiler/read.luma:90:29
local apply_result__481 = skip_space_and_comments__0 ()
--@ compiler/read.luma:91:9
local result__72
--@ compiler/read.luma:92:21
local apply_result__482 = is_char___0 ("\
")
if apply_result__482 then
--@ compiler/read.luma:92:23
local list_result__61
(function ()
--@ compiler/read.luma:93:17
local apply_result__483 = advance__0 ()
--@ compiler/read.luma:94:17
local apply_result__484 = discard__0 ()
--@ compiler/read.luma:95:23
local apply_result__485 = invoke (read_new_line__0, 0)
list_result__61 = apply_result__485
--@ unknown:-1:-1
end)()
result__72 = list_result__61
else
--@ compiler/read.luma:96:16
local result__73 = char__0
if result__73 then
--@ compiler/read.luma:96:34
local apply_result__486 = invoke (____1, 2, paren_level__0, 0)
result__73 = apply_result__486
end
if result__73 then
--@ compiler/read.luma:96:37
local list_result__62
(function ()
local unindent_loop__1
--@ compiler/read.luma:97:13
local result__74
--@ compiler/read.luma:97:32
local apply_result__487 = current_indent__0 ()
--@ compiler/read.luma:97:40
local apply_result__488 = invoke (___5, 2, apply_result__487, indent__0)
if apply_result__488 then
--@ compiler/read.luma:97:42
local list_result__63
(function ()
--@ compiler/read.luma:98:36
local apply_result__489 = invoke_symbol (indent_levels__0, ".push", 1, indent__0)
--@ compiler/read.luma:99:26
local apply_result__490 = emit__0 ("[indent]")
list_result__63 = apply_result__490
--@ unknown:-1:-1
end)()
result__74 = list_result__63
else
result__74 = false 
end
--@ compiler/read.luma:100:25
local fn__228 = function ()
--@ compiler/read.luma:101:15
local result__75
--@ compiler/read.luma:101:41
local apply_result__491 = current_indent__0 ()
local apply_result__492 = invoke (___5, 2, indent__0, apply_result__491)
if apply_result__492 then
--@ compiler/read.luma:101:44
local list_result__64
(function ()
--@ compiler/read.luma:102:26
local apply_result__493 = invoke_symbol (indent_levels__0, ".pop", 0)
--@ compiler/read.luma:103:30
local apply_result__494 = emit__0 ("[unindent]")
--@ compiler/read.luma:104:27
local apply_result__495 = invoke (unindent_loop__1, 0)
list_result__64 = apply_result__495
--@ unknown:-1:-1
end)()
result__75 = list_result__64
else
result__75 = false 
end
return result__75
end
unindent_loop__1 = fn__228
--@ compiler/read.luma:105:23
local apply_result__496 = unindent_loop__1 ()
--@ compiler/read.luma:106:22
local apply_result__497 = emit__0 ("[line]")
list_result__62 = apply_result__497
--@ unknown:-1:-1
end)()
result__72 = list_result__62
else
result__72 = false 
end
end
list_result__59 = result__72
--@ unknown:-1:-1
end)()
return list_result__59
end
read_new_line__0 = fn__226
--@ compiler/read.luma:108:15
local fn__229 = function ()
--@ compiler/read.luma:108:15
local list_result__65
(function ()
--@ compiler/read.luma:109:13
local apply_result__498 = advance__0 ()
--@ compiler/read.luma:110:27
local apply_result__499 = continues_word___0 ()
local while_condition__11 = apply_result__499
while while_condition__11 do
--@ compiler/read.luma:111:15
local apply_result__500 = advance__0 ()
local _ = apply_result__500
--@ compiler/read.luma:110:27
local apply_result__501 = continues_word___0 ()
while_condition__11 = apply_result__501
end
--@ compiler/read.luma:112:9
local result__76
--@ compiler/read.luma:112:28
local apply_result__502 = is_char___0 (".")
local result__77 = apply_result__502
if result__77 then
--@ compiler/read.luma:112:42
local apply_result__503 = peek__0 ()
local apply_result__504 = invoke (___4, 2, ".", apply_result__503)
result__77 = apply_result__504
end
if result__77 then
--@ compiler/read.luma:112:46
local list_result__66
(function ()
--@ compiler/read.luma:113:15
local apply_result__505 = advance__0 ()
--@ compiler/read.luma:114:15
local apply_result__506 = advance__0 ()
list_result__66 = apply_result__506
--@ unknown:-1:-1
end)()
result__76 = list_result__66
else
result__76 = false 
end
--@ compiler/read.luma:115:23
local apply_result__507 = pending_text__0 ()
local apply_result__508 = emit__0 (apply_result__507)
list_result__65 = apply_result__508
--@ unknown:-1:-1
end)()
return list_result__65
end
read_word__0 = fn__229
--@ compiler/read.luma:117:17
local fn__230 = function ()
--@ compiler/read.luma:117:17
local list_result__67
(function ()
--@ compiler/read.luma:118:13
local apply_result__509 = advance__0 ()
--@ compiler/read.luma:119:29
local apply_result__510 = continues_number___0 ()
local while_condition__12 = apply_result__510
while while_condition__12 do
--@ compiler/read.luma:120:15
local apply_result__511 = advance__0 ()
local _ = apply_result__511
--@ compiler/read.luma:119:29
local apply_result__512 = continues_number___0 ()
while_condition__12 = apply_result__512
end
--@ compiler/read.luma:121:23
local apply_result__513 = pending_text__0 ()
local apply_result__514 = emit__0 (apply_result__513)
list_result__67 = apply_result__514
--@ unknown:-1:-1
end)()
return list_result__67
end
read_number__0 = fn__230
--@ compiler/read.luma:123:17
local fn__231 = function ()
--@ compiler/read.luma:123:17
local list_result__68
(function ()
local out__1, put__0, escaping__0
--@ compiler/read.luma:124:17
local apply_result__515 = invoke (_array__0, 0)
out__1 = apply_result__515
--@ compiler/read.luma:125:15
local fn__232 = function (param__303)
--@ compiler/read.luma:125:15
local list_result__69
(function ()
--@ compiler/read.luma:126:28
local apply_result__516 = invoke_symbol (_string__0, ".?", 1, param__303)
--@ compiler/read.luma:126:70
local assert_result__16 = assert(apply_result__516, "tried to put non-string in read-string")
--@ compiler/read.luma:127:19
local apply_result__517 = invoke_symbol (out__1, ".push", 1, param__303)
list_result__69 = apply_result__517
--@ unknown:-1:-1
end)()
return list_result__69
end
put__0 = fn__232
--@ compiler/read.luma:129:13
local apply_result__518 = advance__0 ()
--@ compiler/read.luma:130:13
local apply_result__519 = put__0 ("'")
--@ compiler/read.luma:131:20
escaping__0 = false
--@ compiler/read.luma:133:23
local result__78 = escaping__0
if not result__78 then
--@ compiler/read.luma:133:43
local apply_result__520 = is_char___0 ("'")
local apply_result__521 = invoke (not__0, 1, apply_result__520)
result__78 = apply_result__521
end
local while_condition__13 = result__78
while while_condition__13 do
--@ compiler/read.luma:133:47
local list_result__70
(function ()
--@ compiler/read.luma:134:11
local result__79
--@ compiler/read.luma:135:17
if escaping__0 then
--@ compiler/read.luma:135:18
local list_result__71
(function ()
--@ compiler/read.luma:136:15
local result__80
--@ compiler/read.luma:136:29
local apply_result__522 = is_char___0 ("n")
if apply_result__522 then
--@ compiler/read.luma:136:41
local apply_result__523 = put__0 ("\
")
result__80 = apply_result__523
else
--@ compiler/read.luma:137:29
local apply_result__524 = is_char___0 ("t")
if apply_result__524 then
--@ compiler/read.luma:137:41
local apply_result__525 = put__0 ("\9")
result__80 = apply_result__525
else
--@ compiler/read.luma:138:20
if else__0 then
--@ compiler/read.luma:138:41
local apply_result__526 = put__0 (char__0)
result__80 = apply_result__526
else
result__80 = false 
end
end
end
--@ compiler/read.luma:139:29
escaping__0 = false
list_result__71 = true
--@ unknown:-1:-1
end)()
result__79 = list_result__71
else
--@ compiler/read.luma:140:13
if else__0 then
--@ compiler/read.luma:141:15
local result__81
--@ compiler/read.luma:142:27
local apply_result__527 = is_char___0 ("\\")
if apply_result__527 then
--@ compiler/read.luma:142:47
escaping__0 = true
result__81 = true
else
--@ compiler/read.luma:143:17
if else__0 then
--@ compiler/read.luma:143:38
local apply_result__528 = put__0 (char__0)
result__81 = apply_result__528
else
result__81 = false 
end
end
result__79 = result__81
else
result__79 = false 
end
end
--@ compiler/read.luma:144:15
local apply_result__529 = advance__0 ()
list_result__70 = apply_result__529
--@ unknown:-1:-1
end)()
local _ = list_result__70
--@ compiler/read.luma:133:23
local result__82 = escaping__0
if not result__82 then
--@ compiler/read.luma:133:43
local apply_result__530 = is_char___0 ("'")
local apply_result__531 = invoke (not__0, 1, apply_result__530)
result__82 = apply_result__531
end
while_condition__13 = result__82
end
--@ compiler/read.luma:146:13
local apply_result__532 = advance__0 ()
--@ compiler/read.luma:147:13
local apply_result__533 = put__0 ("'")
--@ compiler/read.luma:148:13
local apply_result__534 = invoke_symbol (out__1, ".concat", 0)
local apply_result__535 = emit__0 (apply_result__534)
list_result__68 = apply_result__535
--@ unknown:-1:-1
end)()
return list_result__68
end
read_string__0 = fn__231
--@ compiler/read.luma:150:16
local fn__233 = function ()
--@ compiler/read.luma:150:16
local list_result__72
(function ()
--@ compiler/read.luma:151:16
local apply_result__536 = skip_space__0 ()
--@ compiler/read.luma:152:9
local result__83
--@ compiler/read.luma:153:22
local apply_result__537 = begins_number___0 ()
if apply_result__537 then
--@ compiler/read.luma:153:38
local apply_result__538 = read_number__0 ()
result__83 = apply_result__538
else
--@ compiler/read.luma:154:20
local apply_result__539 = begins_word___0 ()
if apply_result__539 then
--@ compiler/read.luma:154:36
local apply_result__540 = read_word__0 ()
result__83 = apply_result__540
else
--@ compiler/read.luma:155:21
local apply_result__541 = is_char___0 ("'")
if apply_result__541 then
--@ compiler/read.luma:155:38
local apply_result__542 = read_string__0 ()
result__83 = apply_result__542
else
--@ compiler/read.luma:156:20
local apply_result__543 = is_char___0 ("(")
if apply_result__543 then
--@ compiler/read.luma:156:39
local apply_result__544 = skip_comment__0 ()
result__83 = apply_result__544
else
--@ compiler/read.luma:157:20
local apply_result__545 = is_char___0 ("[")
if apply_result__545 then
--@ compiler/read.luma:157:22
local list_result__73
(function ()
--@ compiler/read.luma:158:17
local apply_result__546 = advance__0 ()
--@ compiler/read.luma:159:41
local apply_result__547 = invoke (___0, 2, paren_level__0, 1)
paren_level__0 = apply_result__547
--@ compiler/read.luma:160:27
local apply_result__548 = pending_text__0 ()
local apply_result__549 = emit__0 (apply_result__548)
list_result__73 = apply_result__549
--@ unknown:-1:-1
end)()
result__83 = list_result__73
else
--@ compiler/read.luma:161:20
local apply_result__550 = is_char___0 ("]")
if apply_result__550 then
--@ compiler/read.luma:161:22
local list_result__74
(function ()
--@ compiler/read.luma:162:17
local apply_result__551 = advance__0 ()
--@ compiler/read.luma:163:41
local apply_result__552 = invoke (___1, 2, paren_level__0, 1)
paren_level__0 = apply_result__552
--@ compiler/read.luma:164:27
local apply_result__553 = pending_text__0 ()
local apply_result__554 = emit__0 (apply_result__553)
list_result__74 = apply_result__554
--@ unknown:-1:-1
end)()
result__83 = list_result__74
else
--@ compiler/read.luma:165:20
local apply_result__555 = is_char___0 (":")
if apply_result__555 then
--@ compiler/read.luma:165:22
local list_result__75
(function ()
--@ compiler/read.luma:166:17
local apply_result__556 = advance__0 ()
--@ compiler/read.luma:167:27
local apply_result__557 = pending_text__0 ()
local apply_result__558 = emit__0 (apply_result__557)
list_result__75 = apply_result__558
--@ unknown:-1:-1
end)()
result__83 = list_result__75
else
--@ compiler/read.luma:168:21
local apply_result__559 = is_char___0 ("\
")
if apply_result__559 then
--@ compiler/read.luma:168:23
local list_result__76
(function ()
--@ compiler/read.luma:169:17
local apply_result__560 = advance__0 ()
--@ compiler/read.luma:170:17
local apply_result__561 = discard__0 ()
--@ compiler/read.luma:171:23
local apply_result__562 = read_new_line__0 ()
list_result__76 = apply_result__562
--@ unknown:-1:-1
end)()
result__83 = list_result__76
else
--@ compiler/read.luma:172:11
if else__0 then
--@ compiler/read.luma:173:65
local apply_result__563 = invoke (combine_strings__0, 2, "unknown character: ", char__0)
local assert_result__17 = assert(false, apply_result__563)
result__83 = assert_result__17
else
result__83 = false 
end
end
end
end
end
end
end
end
end
list_result__72 = result__83
--@ unknown:-1:-1
end)()
return list_result__72
end
read_token__0 = fn__233
--@ compiler/read.luma:175:17
local apply_result__564 = read_new_line__0 ()
--@ compiler/read.luma:176:14
local apply_result__565 = skip_space__0 ()
--@ compiler/read.luma:178:13
local while_condition__14 = char__0
while while_condition__14 do
--@ compiler/read.luma:178:14
local list_result__77
(function ()
--@ compiler/read.luma:179:16
local apply_result__566 = read_token__0 ()
--@ compiler/read.luma:180:16
local apply_result__567 = skip_space__0 ()
list_result__77 = apply_result__567
--@ unknown:-1:-1
end)()
local _ = list_result__77
--@ compiler/read.luma:178:13
while_condition__14 = char__0
end
--@ compiler/read.luma:182:19
local fn__234 = function ()
--@ compiler/read.luma:183:9
local result__84
--@ compiler/read.luma:183:29
local apply_result__568 = invoke_symbol (indent_levels__0, ".length", 0)
local apply_result__569 = invoke_symbol (1, ".<", 1, apply_result__568)
if apply_result__569 then
--@ compiler/read.luma:183:38
local list_result__78
(function ()
--@ compiler/read.luma:184:24
local apply_result__570 = emit__0 ("[unindent]")
--@ compiler/read.luma:185:20
local apply_result__571 = invoke_symbol (indent_levels__0, ".pop", 0)
--@ compiler/read.luma:186:21
local apply_result__572 = invoke (unindent_loop__0, 0)
list_result__78 = apply_result__572
--@ unknown:-1:-1
end)()
result__84 = list_result__78
else
result__84 = false 
end
return result__84
end
unindent_loop__0 = fn__234
--@ compiler/read.luma:187:17
local apply_result__573 = unindent_loop__0 ()
--@ compiler/read.luma:189:9
list_result__51 = tokens__0
--@ unknown:-1:-1
end)()
return list_result__51
end
read__1 = fn__209
--@ compiler/read.luma:191:2
local table__62
(function ()
--@ compiler/read.luma:192:14
table__62 = {
[".read"] = read__1,
}
--@ unknown:-1:-1
end)()
list_result__50 = table__62
--@ unknown:-1:-1
end)()
_modules_compiler_read__0 = list_result__50
--@ unknown:-1:-1
local apply_result__574 = _modules_compiler_read__0[".read"]
read__0 = apply_result__574
--@ unknown:-1:-1
local list_result__79
(function ()
local _context__1
--@ compiler/context.luma:1:12
local table__63
(function ()
local fn__235 = function (param__304)
--@ compiler/context.luma:2:28
local result__85 = type (param__304) == "table" and (param__304.index == _context__1 or param__304[_context__1] ~= nil)
return result__85
end
local fn__236 = function ()
--@ compiler/context.luma:3:22
local apply_result__575 = invoke (_context__1, 1, false)
return apply_result__575
end
local fn__237 = function (param__305)
--@ compiler/context.luma:4:16
local table__64
(function ()
--@ compiler/context.luma:7:19
local apply_result__576 = invoke (_hash__0, 0)
table__64 = {
["index"] = _context__1,
[".parent"] = param__305,
[".scope"] = apply_result__576,
}
--@ unknown:-1:-1
end)()
return table__64
end
local fn__238 = function (param__306, param__307, param__308)
--@ compiler/context.luma:9:24
local list_result__80
(function ()
--@ compiler/context.luma:10:26
local apply_result__577 = invoke_symbol (_string__0, ".?", 1, param__307)
--@ compiler/context.luma:10:52
local assert_result__18 = assert(apply_result__577, "expected string as key")
--@ compiler/context.luma:11:22
local apply_result__578 = invoke_symbol (param__306, ".scope", 0)
--@ compiler/context.luma:11:37
local apply_result__579 = invoke_symbol (apply_result__578, ".has?", 1, param__307)
local apply_result__580 = invoke (not__0, 1, apply_result__579)
--@ compiler/context.luma:11:68
local assert_result__19 = assert(apply_result__580, "duplicate entry in context")
--@ compiler/context.luma:12:9
local apply_result__581 = invoke_symbol (param__306, ".scope", 0)
--@ compiler/context.luma:12:29
local apply_result__582 = invoke_symbol (apply_result__581, ".set", 2, param__307, param__308)
list_result__80 = apply_result__582
--@ unknown:-1:-1
end)()
return list_result__80
end
local fn__239 = function (param__309, param__310, param__311)
--@ compiler/context.luma:14:30
local list_result__81
(function ()
local result__86
--@ compiler/context.luma:15:41
local apply_result__583 = invoke_symbol (param__309, ".lookup-recursively", 1, param__310)
result__86 = apply_result__583
--@ compiler/context.luma:16:9
local result__87
--@ compiler/context.luma:16:21
local apply_result__584 = invoke (not__0, 1, result__86)
if apply_result__584 then
--@ compiler/context.luma:17:40
local apply_result__585 = invoke (_word_node__0, 2, param__310, param__311)
--@ compiler/context.luma:17:85
local apply_result__586 = invoke (combine_strings__0, 2, "missing in context: ", param__310)
local apply_result__587 = invoke (error_at__0, 2, apply_result__585, apply_result__586)
result__87 = apply_result__587
else
result__87 = false 
end
--@ compiler/context.luma:18:11
list_result__81 = result__86
--@ unknown:-1:-1
end)()
return list_result__81
end
local fn__240 = function (param__312, param__313)
--@ compiler/context.luma:21:42
local apply_result__588 = invoke_symbol (param__312, ".lookup-recursively", 1, param__313)
local apply_result__589 = invoke (not__0, 1, apply_result__588)
local apply_result__590 = invoke (not__0, 1, apply_result__589)
return apply_result__590
end
local fn__241 = function (param__314, param__315)
--@ compiler/context.luma:24:13
local apply_result__591 = invoke_symbol (param__314, ".scope", 0)
--@ compiler/context.luma:24:36
local apply_result__592 = invoke_symbol (apply_result__591, ".get-or", 2, param__315, false)
local result__88 = apply_result__592
if not result__88 then
--@ compiler/context.luma:25:16
local apply_result__593 = invoke_symbol (param__314, ".parent", 0)
local result__89 = apply_result__593
if result__89 then
--@ compiler/context.luma:25:29
local apply_result__594 = invoke_symbol (param__314, ".parent", 0)
--@ compiler/context.luma:25:59
local apply_result__595 = invoke_symbol (apply_result__594, ".lookup-recursively", 1, param__315)
result__89 = apply_result__595
end
result__88 = result__89
end
return result__88
end
table__63 = {
functions = {
[".?"] = fn__235,
[0] = fn__236,
[1] = fn__237,
},
methods = {
[".add"] = fn__238,
[".lookup"] = fn__239,
[".has?"] = fn__240,
[".lookup-recursively"] = fn__241,
},
}
--@ unknown:-1:-1
end)()
_context__1 = table__63
--@ compiler/context.luma:27:2
local table__65
(function ()
--@ compiler/context.luma:28:22
table__65 = {
[".#context"] = _context__1,
}
--@ unknown:-1:-1
end)()
list_result__79 = table__65
--@ unknown:-1:-1
end)()
_modules_compiler_context__0 = list_result__79
--@ unknown:-1:-1
local apply_result__596 = _modules_compiler_context__0[".#context"]
_context__0 = apply_result__596
--@ unknown:-1:-1
local list_result__82
(function ()
local make_list__0, make_pair__0, is_word_symbol___0, parse__1
--@ compiler/parse.luma:21:28
local fn__242 = function (param__316, param__317)
--@ compiler/parse.luma:21:28
local list_result__83
(function ()
local apply_items__0
--@ compiler/parse.luma:22:39
local apply_result__597 = invoke (_word_node__0, 1, "!")
local apply_result__598 = invoke (_array__0, 1, apply_result__597)
apply_items__0 = apply_result__598
--@ compiler/parse.luma:23:31
local apply_result__599 = invoke_symbol (apply_items__0, ".push-items", 1, param__316)
--@ compiler/parse.luma:24:35
local apply_result__600 = invoke (_apply_node__0, 2, apply_items__0, param__317)
list_result__83 = apply_result__600
--@ unknown:-1:-1
end)()
return list_result__83
end
make_list__0 = fn__242
--@ compiler/parse.luma:26:26
local fn__243 = function (param__318, param__319, param__320)
--@ compiler/parse.luma:27:38
local apply_result__601 = invoke (_word_node__0, 1, ":")
--@ compiler/parse.luma:27:43
local apply_result__602 = invoke (_array__0, 3, apply_result__601, param__318, param__319)
--@ compiler/parse.luma:27:53
local apply_result__603 = invoke (_apply_node__0, 2, apply_result__602, param__320)
return apply_result__603
end
make_pair__0 = fn__243
--@ compiler/parse.luma:29:24
local fn__244 = function (param__321)
--@ compiler/parse.luma:30:25
local apply_result__604 = invoke_symbol (_word_node__0, ".?", 1, param__321)
local result__90 = apply_result__604
if result__90 then
--@ compiler/parse.luma:30:39
local apply_result__605 = invoke_symbol (param__321, ".id", 0)
--@ compiler/parse.luma:30:56
local apply_result__606 = invoke_symbol (apply_result__605, ".substring", 2, 0, 1)
local apply_result__607 = invoke (___4, 2, ".", apply_result__606)
result__90 = apply_result__607
end
return result__90
end
is_word_symbol___0 = fn__244
--@ compiler/parse.luma:32:21
local fn__245 = function (param__322)
--@ compiler/parse.luma:32:21
local list_result__84
(function ()
local token_index__0, current__0, current_location__0, is_token___0, is_symbol___0, check_is__0, next__0, starts_expr__0, rules__0
--@ compiler/parse.luma:33:17
token_index__0 = 0
--@ compiler/parse.luma:35:13
local fn__246 = function ()
--@ compiler/parse.luma:36:35
local apply_result__608 = invoke_symbol (param__322, ".length", 0)
local apply_result__609 = invoke_symbol (token_index__0, ".<", 1, apply_result__608)
local result__91
if apply_result__609 then
--@ compiler/parse.luma:37:34
local apply_result__610 = invoke_symbol (param__322, ".get", 1, token_index__0)
result__91 = apply_result__610
else
--@ compiler/parse.luma:38:12
result__91 = false
end
return result__91
end
current__0 = fn__246
--@ compiler/parse.luma:40:22
local fn__247 = function ()
--@ compiler/parse.luma:40:22
local list_result__85
(function ()
local t__0
--@ compiler/parse.luma:41:16
local apply_result__611 = current__0 ()
t__0 = apply_result__611
--@ compiler/parse.luma:42:9
local result__92
if t__0 then
--@ compiler/parse.luma:43:8
local apply_result__612 = invoke_symbol (t__0, ".location", 0)
result__92 = apply_result__612
else
--@ compiler/parse.luma:44:16
local apply_result__613 = invoke_symbol (_location__0, ".unknown", 0)
result__92 = apply_result__613
end
list_result__85 = result__92
--@ unknown:-1:-1
end)()
return list_result__85
end
current_location__0 = fn__247
--@ compiler/parse.luma:46:17
local fn__248 = function (param__323)
--@ compiler/parse.luma:47:17
local apply_result__614 = current__0 ()
local result__93 = apply_result__614
if result__93 then
--@ compiler/parse.luma:47:30
local apply_result__615 = current__0 ()
local apply_result__616 = invoke_symbol (apply_result__615, ".id", 0)
--@ compiler/parse.luma:47:36
local apply_result__617 = invoke (___4, 2, apply_result__616, param__323)
result__93 = apply_result__617
end
return result__93
end
is_token___0 = fn__248
--@ compiler/parse.luma:49:16
local fn__249 = function ()
--@ compiler/parse.luma:50:32
local apply_result__618 = current__0 ()
local apply_result__619 = invoke_symbol (_token_node__0, ".?", 1, apply_result__618)
local result__94 = apply_result__619
if result__94 then
--@ compiler/parse.luma:50:51
local apply_result__620 = current__0 ()
local apply_result__621 = invoke_symbol (apply_result__620, ".id", 0)
--@ compiler/parse.luma:50:69
local apply_result__622 = invoke_symbol (apply_result__621, ".substring", 2, 0, 1)
local apply_result__623 = invoke (___4, 2, ".", apply_result__622)
result__94 = apply_result__623
end
return result__94
end
is_symbol___0 = fn__249
--@ compiler/parse.luma:52:16
local fn__250 = function (param__324)
--@ compiler/parse.luma:53:9
local result__95
--@ compiler/parse.luma:53:27
local apply_result__624 = is_token___0 (param__324)
local apply_result__625 = invoke (not__0, 1, apply_result__624)
if apply_result__625 then
--@ compiler/parse.luma:55:89
local apply_result__626 = current__0 ()
local apply_result__627 = invoke_symbol (apply_result__626, ".id", 0)
local _value_to_string_result__2 = tostring(apply_result__627)
local apply_result__628 = invoke (_string__0, 1, _value_to_string_result__2)
--@ compiler/parse.luma:55:122
local apply_result__629 = current_location__0 ()
local apply_result__630 = invoke_symbol (apply_result__629, ".to-string", 0)
local apply_result__631 = invoke (combine_strings__0, 6, "expected '", param__324, "', got '", apply_result__628, "' at ", apply_result__630)
local assert_result__20 = assert(false, apply_result__631)
result__95 = assert_result__20
else
result__95 = false 
end
return result__95
end
check_is__0 = fn__250
--@ compiler/parse.luma:57:10
local table__66
(function ()
local fn__251 = function (param__325)
--@ compiler/parse.luma:58:11
local list_result__86
(function ()
--@ compiler/parse.luma:59:17
local apply_result__632 = check_is__0 (param__325)
--@ compiler/parse.luma:60:12
local apply_result__633 = invoke (next__0, 0)
list_result__86 = apply_result__633
--@ unknown:-1:-1
end)()
return list_result__86
end
local fn__252 = function ()
--@ compiler/parse.luma:61:9
local list_result__87
(function ()
--@ compiler/parse.luma:62:22
local apply_result__634 = current__0 ()
--@ compiler/parse.luma:62:51
local assert_result__21 = assert(apply_result__634, "tried to advance past end")
--@ compiler/parse.luma:63:40
local apply_result__635 = invoke_symbol (1, ".+", 1, token_index__0)
token_index__0 = apply_result__635
list_result__87 = true
--@ unknown:-1:-1
end)()
return list_result__87
end
table__66 = {
functions = {
[1] = fn__251,
[0] = fn__252,
},
}
--@ unknown:-1:-1
end)()
next__0 = table__66
--@ compiler/parse.luma:65:17
local fn__253 = function ()
--@ compiler/parse.luma:66:9
local result__96
--@ compiler/parse.luma:67:30
local apply_result__636 = is_token___0 ("[unindent]")
if apply_result__636 then
--@ compiler/parse.luma:67:38
result__96 = false
else
--@ compiler/parse.luma:68:26
local apply_result__637 = is_token___0 ("[line]")
if apply_result__637 then
--@ compiler/parse.luma:68:38
result__96 = false
else
--@ compiler/parse.luma:69:28
local apply_result__638 = is_token___0 ("[indent]")
if apply_result__638 then
--@ compiler/parse.luma:69:38
result__96 = false
else
--@ compiler/parse.luma:70:21
local apply_result__639 = is_token___0 (":")
if apply_result__639 then
--@ compiler/parse.luma:70:38
result__96 = false
else
--@ compiler/parse.luma:71:21
local apply_result__640 = is_token___0 ("]")
if apply_result__640 then
--@ compiler/parse.luma:71:38
result__96 = false
else
--@ compiler/parse.luma:72:23
local apply_result__641 = is_token___0 (false)
if apply_result__641 then
--@ compiler/parse.luma:72:38
result__96 = false
else
--@ compiler/parse.luma:73:11
if else__0 then
--@ compiler/parse.luma:73:37
result__96 = true
else
result__96 = false 
end
end
end
end
end
end
end
return result__96
end
starts_expr__0 = fn__253
--@ compiler/parse.luma:75:11
local table__67
(function ()
local fn__254 = function ()
--@ compiler/parse.luma:77:22
local apply_result__642 = invoke_symbol (rules__0, ".body", 0)
--@ compiler/parse.luma:77:45
local apply_result__643 = current_location__0 ()
local apply_result__644 = make_list__0 (apply_result__642, apply_result__643)
return apply_result__644
end
local fn__255 = function ()
--@ compiler/parse.luma:79:15
local list_result__88
(function ()
local items__0
--@ compiler/parse.luma:80:21
local apply_result__645 = invoke (_array__0, 0)
items__0 = apply_result__645
--@ compiler/parse.luma:81:22
local apply_result__646 = next__0.functions[1] ("[indent]")
--@ compiler/parse.luma:82:46
local apply_result__647 = is_token___0 ("[unindent]")
local apply_result__648 = invoke (not__0, 1, apply_result__647)
local result__97 = apply_result__648
if result__97 then
--@ compiler/parse.luma:82:70
local apply_result__649 = is_token___0 (false)
local apply_result__650 = invoke (not__0, 1, apply_result__649)
result__97 = apply_result__650
end
local while_condition__15 = result__97
while while_condition__15 do
--@ compiler/parse.luma:82:74
local list_result__89
(function ()
--@ compiler/parse.luma:83:22
local apply_result__651 = next__0.functions[1] ("[line]")
--@ compiler/parse.luma:84:25
local apply_result__652 = invoke_symbol (rules__0, ".line", 0)
local apply_result__653 = invoke_symbol (items__0, ".push", 1, apply_result__652)
list_result__89 = apply_result__653
--@ unknown:-1:-1
end)()
local _ = list_result__89
--@ compiler/parse.luma:82:46
local apply_result__654 = is_token___0 ("[unindent]")
local apply_result__655 = invoke (not__0, 1, apply_result__654)
local result__98 = apply_result__655
if result__98 then
--@ compiler/parse.luma:82:70
local apply_result__656 = is_token___0 (false)
local apply_result__657 = invoke (not__0, 1, apply_result__656)
result__98 = apply_result__657
end
while_condition__15 = result__98
end
--@ compiler/parse.luma:85:24
local apply_result__658 = next__0.functions[1] ("[unindent]")
--@ compiler/parse.luma:86:12
local apply_result__659 = invoke_symbol (items__0, ".iterator", 0)
local apply_result__660 = invoke_symbol (apply_result__659, ".to-list", 0)
list_result__88 = apply_result__660
--@ unknown:-1:-1
end)()
return list_result__88
end
local fn__256 = function ()
--@ compiler/parse.luma:88:15
local list_result__90
(function ()
local items__1
--@ compiler/parse.luma:89:27
local apply_result__661 = invoke_symbol (rules__0, ".first-expr", 0)
local apply_result__662 = invoke (_array__0, 1, apply_result__661)
items__1 = apply_result__662
--@ compiler/parse.luma:90:29
local apply_result__663 = invoke_symbol (rules__0, ".rest", 0)
local apply_result__664 = invoke_symbol (items__1, ".push-items", 1, apply_result__663)
--@ compiler/parse.luma:91:20
local apply_result__665 = invoke_symbol (items__1, ".length", 0)
local apply_result__666 = invoke (___4, 2, 1, apply_result__665)
local result__99
if apply_result__666 then
--@ compiler/parse.luma:92:20
local apply_result__667 = invoke_symbol (items__1, ".get", 1, 0)
result__99 = apply_result__667
else
--@ compiler/parse.luma:93:39
local apply_result__668 = invoke_symbol (items__1, ".get", 1, 0)
local apply_result__669 = invoke_symbol (apply_result__668, ".location", 0)
local apply_result__670 = invoke (_apply_node__0, 2, items__1, apply_result__669)
result__99 = apply_result__670
end
list_result__90 = result__99
--@ unknown:-1:-1
end)()
return list_result__90
end
local fn__257 = function ()
--@ compiler/parse.luma:95:15
local list_result__91
(function ()
local items__2
--@ compiler/parse.luma:96:21
local apply_result__671 = invoke (_array__0, 0)
items__2 = apply_result__671
--@ compiler/parse.luma:97:25
local apply_result__672 = starts_expr__0 ()
local while_condition__16 = apply_result__672
while while_condition__16 do
--@ compiler/parse.luma:98:25
local apply_result__673 = invoke_symbol (rules__0, ".rest-expr", 0)
local apply_result__674 = invoke_symbol (items__2, ".push", 1, apply_result__673)
local _ = apply_result__674
--@ compiler/parse.luma:97:25
local apply_result__675 = starts_expr__0 ()
while_condition__16 = apply_result__675
end
--@ compiler/parse.luma:99:11
local result__100
--@ compiler/parse.luma:99:33
local apply_result__676 = is_token___0 ("[indent]")
if apply_result__676 then
--@ compiler/parse.luma:100:14
local apply_result__677 = invoke_symbol (rules__0, ".body", 0)
local apply_result__678 = invoke_symbol (apply_result__677, ".iterator", 0)
--@ compiler/parse.luma:100:40
local fn__258 = function (param__326)
--@ compiler/parse.luma:100:54
local apply_result__679 = invoke_symbol (items__2, ".push", 1, param__326)
return apply_result__679
end
local apply_result__680 = invoke_symbol (apply_result__678, ".each", 1, fn__258)
result__100 = apply_result__680
else
result__100 = false 
end
--@ compiler/parse.luma:101:12
local apply_result__681 = invoke_symbol (items__2, ".iterator", 0)
local apply_result__682 = invoke_symbol (apply_result__681, ".to-list", 0)
list_result__91 = apply_result__682
--@ unknown:-1:-1
end)()
return list_result__91
end
local fn__259 = function (param__327, param__328, param__329)
--@ compiler/parse.luma:104:11
local result__101
--@ compiler/parse.luma:105:30
local apply_result__683 = is_token___0 ("[indent]")
if apply_result__683 then
--@ compiler/parse.luma:105:32
local list_result__92
(function ()
local body__0
--@ compiler/parse.luma:106:22
local apply_result__684 = invoke_symbol (rules__0, ".body", 0)
body__0 = apply_result__684
--@ compiler/parse.luma:107:23
local apply_result__685 = invoke_symbol (body__0, ".length", 0)
local apply_result__686 = invoke (___4, 2, 1, apply_result__685)
local result__102
if apply_result__686 then
--@ compiler/parse.luma:108:32
local apply_result__687 = invoke_symbol (body__0, ".first", 0)
--@ compiler/parse.luma:108:47
local apply_result__688 = make_pair__0 (param__327, apply_result__687, param__328)
result__102 = apply_result__688
else
--@ compiler/parse.luma:109:52
local apply_result__689 = make_list__0 (body__0, param__328)
--@ compiler/parse.luma:109:62
local apply_result__690 = make_pair__0 (param__327, apply_result__689, param__328)
result__102 = apply_result__690
end
list_result__92 = result__102
--@ unknown:-1:-1
end)()
result__101 = list_result__92
else
--@ compiler/parse.luma:110:13
if else__0 then
--@ compiler/parse.luma:111:41
local apply_result__691 = invoke (param__329, 0)
--@ compiler/parse.luma:111:51
local apply_result__692 = make_pair__0 (param__327, apply_result__691, param__328)
result__101 = apply_result__692
else
result__101 = false 
end
end
return result__101
end
local fn__260 = function ()
--@ compiler/parse.luma:114:21
local list_result__93
(function ()
local expr__0
--@ compiler/parse.luma:115:18
local apply_result__693 = invoke_symbol (rules__0, ".expr", 0)
expr__0 = apply_result__693
--@ compiler/parse.luma:116:11
local result__103
--@ compiler/parse.luma:117:40
local apply_result__694 = is_word_symbol___0 (expr__0)
local apply_result__695 = invoke (not__0, 1, apply_result__694)
local result__104 = apply_result__695
if result__104 then
--@ compiler/parse.luma:117:54
local apply_result__696 = is_symbol___0 ()
result__104 = apply_result__696
end
if result__104 then
--@ compiler/parse.luma:117:57
local list_result__94
(function ()
--@ compiler/parse.luma:118:28
local apply_result__697 = is_symbol___0 ()
local while_condition__17 = apply_result__697
while while_condition__17 do
--@ compiler/parse.luma:119:53
local apply_result__698 = invoke_symbol (rules__0, ".word", 0)
local apply_result__699 = invoke (_array__0, 2, expr__0, apply_result__698)
--@ compiler/parse.luma:119:77
local apply_result__700 = current_location__0 ()
local apply_result__701 = invoke (_apply_node__0, 2, apply_result__699, apply_result__700)
expr__0 = apply_result__701
local _ = true
--@ compiler/parse.luma:118:28
local apply_result__702 = is_symbol___0 ()
while_condition__17 = apply_result__702
end
--@ compiler/parse.luma:120:45
local apply_result__703 = invoke_symbol (expr__0, ".items", 0)
--@ compiler/parse.luma:120:57
local apply_result__704 = invoke_symbol (rules__0, ".rest", 0)
local apply_result__705 = invoke_symbol (_array__0, ".append", 2, apply_result__703, apply_result__704)
--@ compiler/parse.luma:120:19
expr__0 [".items"] = apply_result__705
list_result__94 = true
--@ unknown:-1:-1
end)()
result__103 = list_result__94
else
result__103 = false 
end
--@ compiler/parse.luma:121:11
local result__105
--@ compiler/parse.luma:122:23
local apply_result__706 = is_token___0 (":")
if apply_result__706 then
--@ compiler/parse.luma:122:25
local list_result__95
(function ()
local location__1
--@ compiler/parse.luma:123:38
local apply_result__707 = current_location__0 ()
location__1 = apply_result__707
--@ compiler/parse.luma:124:16
local apply_result__708 = next__0.functions[0] ()
--@ compiler/parse.luma:125:56
local fn__261 = function ()
--@ compiler/parse.luma:125:63
local apply_result__709 = invoke_symbol (rules__0, ".line", 0)
return apply_result__709
end
local apply_result__710 = invoke_symbol (rules__0, ".pair-value", 3, expr__0, location__1, fn__261)
expr__0 = apply_result__710
list_result__95 = true
--@ unknown:-1:-1
end)()
result__105 = list_result__95
else
result__105 = false 
end
--@ compiler/parse.luma:126:11
list_result__93 = expr__0
--@ unknown:-1:-1
end)()
return list_result__93
end
local fn__262 = function ()
--@ compiler/parse.luma:128:20
local list_result__96
(function ()
local expr__1
--@ compiler/parse.luma:129:18
local apply_result__711 = invoke_symbol (rules__0, ".expr", 0)
expr__1 = apply_result__711
--@ compiler/parse.luma:130:11
local result__106
--@ compiler/parse.luma:131:40
local apply_result__712 = is_word_symbol___0 (expr__1)
local apply_result__713 = invoke (not__0, 1, apply_result__712)
local result__107 = apply_result__713
if result__107 then
--@ compiler/parse.luma:131:54
local apply_result__714 = is_symbol___0 ()
result__107 = apply_result__714
end
if result__107 then
--@ compiler/parse.luma:132:28
local apply_result__715 = is_symbol___0 ()
local while_condition__18 = apply_result__715
while while_condition__18 do
--@ compiler/parse.luma:133:53
local apply_result__716 = invoke_symbol (rules__0, ".word", 0)
local apply_result__717 = invoke (_array__0, 2, expr__1, apply_result__716)
--@ compiler/parse.luma:133:77
local apply_result__718 = current_location__0 ()
local apply_result__719 = invoke (_apply_node__0, 2, apply_result__717, apply_result__718)
expr__1 = apply_result__719
local _ = true
--@ compiler/parse.luma:132:28
local apply_result__720 = is_symbol___0 ()
while_condition__18 = apply_result__720
end
result__106 = false
else
result__106 = false 
end
--@ compiler/parse.luma:134:11
local result__108
--@ compiler/parse.luma:135:23
local apply_result__721 = is_token___0 (":")
if apply_result__721 then
--@ compiler/parse.luma:135:25
local list_result__97
(function ()
local location__2
--@ compiler/parse.luma:136:38
local apply_result__722 = current_location__0 ()
location__2 = apply_result__722
--@ compiler/parse.luma:137:16
local apply_result__723 = next__0.functions[0] ()
--@ compiler/parse.luma:138:56
local fn__263 = function ()
--@ compiler/parse.luma:138:63
local apply_result__724 = invoke_symbol (rules__0, ".rest-expr", 0)
return apply_result__724
end
local apply_result__725 = invoke_symbol (rules__0, ".pair-value", 3, expr__1, location__2, fn__263)
expr__1 = apply_result__725
list_result__97 = true
--@ unknown:-1:-1
end)()
result__108 = list_result__97
else
result__108 = false 
end
--@ compiler/parse.luma:139:11
list_result__96 = expr__1
--@ unknown:-1:-1
end)()
return list_result__96
end
local fn__264 = function ()
--@ compiler/parse.luma:142:11
local result__109
--@ compiler/parse.luma:143:23
local apply_result__726 = is_token___0 ("[")
if apply_result__726 then
--@ compiler/parse.luma:143:25
local list_result__98
(function ()
local do_wrap___0, expr__2, rest__0
--@ compiler/parse.luma:144:16
local apply_result__727 = next__0.functions[0] ()
--@ compiler/parse.luma:145:25
do_wrap___0 = true
--@ compiler/parse.luma:146:22
local apply_result__728 = invoke_symbol (rules__0, ".expr", 0)
expr__2 = apply_result__728
--@ compiler/parse.luma:147:15
local result__110
--@ compiler/parse.luma:147:47
local apply_result__729 = is_word_symbol___0 (expr__2)
local apply_result__730 = invoke (not__0, 1, apply_result__729)
local result__111 = apply_result__730
if result__111 then
--@ compiler/parse.luma:147:61
local apply_result__731 = is_symbol___0 ()
result__111 = apply_result__731
end
if result__111 then
--@ compiler/parse.luma:147:64
local list_result__99
(function ()
--@ compiler/parse.luma:148:30
local apply_result__732 = is_symbol___0 ()
local while_condition__19 = apply_result__732
while while_condition__19 do
--@ compiler/parse.luma:148:32
local list_result__100
(function ()
--@ compiler/parse.luma:149:55
local apply_result__733 = invoke_symbol (rules__0, ".word", 0)
local apply_result__734 = invoke (_array__0, 2, expr__2, apply_result__733)
--@ compiler/parse.luma:149:79
local apply_result__735 = current_location__0 ()
local apply_result__736 = invoke (_apply_node__0, 2, apply_result__734, apply_result__735)
expr__2 = apply_result__736
--@ compiler/parse.luma:150:33
do_wrap___0 = false
list_result__100 = true
--@ unknown:-1:-1
end)()
local _ = list_result__100
--@ compiler/parse.luma:148:30
local apply_result__737 = is_symbol___0 ()
while_condition__19 = apply_result__737
end
--@ compiler/parse.luma:151:47
local apply_result__738 = invoke_symbol (expr__2, ".items", 0)
--@ compiler/parse.luma:151:59
local apply_result__739 = invoke_symbol (rules__0, ".rest", 0)
local apply_result__740 = invoke_symbol (_array__0, ".append", 2, apply_result__738, apply_result__739)
--@ compiler/parse.luma:151:21
expr__2 [".items"] = apply_result__740
list_result__99 = true
--@ unknown:-1:-1
end)()
result__110 = list_result__99
else
result__110 = false 
end
--@ compiler/parse.luma:152:22
local apply_result__741 = invoke_symbol (rules__0, ".rest", 0)
rest__0 = apply_result__741
--@ compiler/parse.luma:153:19
local apply_result__742 = next__0.functions[1] ("]")
--@ compiler/parse.luma:154:26
local result__112 = do_wrap___0
if not result__112 then
--@ compiler/parse.luma:154:32
local apply_result__743 = invoke_symbol (rest__0, ".length", 0)
--@ compiler/parse.luma:154:44
local apply_result__744 = invoke_symbol (apply_result__743, ".>", 1, 0)
result__112 = apply_result__744
end
local result__113
if result__112 then
--@ compiler/parse.luma:155:52
local apply_result__745 = invoke (_array__0, 1, expr__2)
--@ compiler/parse.luma:155:58
local apply_result__746 = invoke_symbol (_array__0, ".append", 2, apply_result__745, rest__0)
--@ compiler/parse.luma:155:64
local apply_result__747 = invoke_symbol (expr__2, ".location", 0)
local apply_result__748 = invoke (_apply_node__0, 2, apply_result__746, apply_result__747)
result__113 = apply_result__748
else
--@ compiler/parse.luma:156:17
result__113 = expr__2
end
list_result__98 = result__113
--@ unknown:-1:-1
end)()
result__109 = list_result__98
else
--@ compiler/parse.luma:158:13
if else__0 then
--@ compiler/parse.luma:159:16
local apply_result__749 = invoke_symbol (rules__0, ".word", 0)
result__109 = apply_result__749
else
result__109 = false 
end
end
return result__109
end
local fn__265 = function ()
--@ compiler/parse.luma:161:15
local list_result__101
(function ()
local token__0, location__3
--@ compiler/parse.luma:163:22
local apply_result__750 = current__0 ()
token__0 = apply_result__750
--@ compiler/parse.luma:164:34
local apply_result__751 = current_location__0 ()
location__3 = apply_result__751
--@ compiler/parse.luma:165:12
local apply_result__752 = next__0.functions[0] ()
--@ compiler/parse.luma:166:23
local apply_result__753 = invoke_symbol (token__0, ".id", 0)
--@ compiler/parse.luma:166:35
local apply_result__754 = invoke (_word_node__0, 2, apply_result__753, location__3)
list_result__101 = apply_result__754
--@ unknown:-1:-1
end)()
return list_result__101
end
table__67 = {
functions = {
[".root"] = fn__254,
[".body"] = fn__255,
[".line"] = fn__256,
[".rest"] = fn__257,
[".pair-value"] = fn__259,
[".first-expr"] = fn__260,
[".rest-expr"] = fn__262,
[".expr"] = fn__264,
[".word"] = fn__265,
},
}
--@ unknown:-1:-1
end)()
rules__0 = table__67
--@ compiler/parse.luma:169:8
local apply_result__755 = rules__0.functions[".root"] ()
list_result__84 = apply_result__755
--@ unknown:-1:-1
end)()
return list_result__84
end
parse__1 = fn__245
--@ compiler/parse.luma:171:2
local table__68
(function ()
--@ compiler/parse.luma:172:16
table__68 = {
[".parse"] = parse__1,
}
--@ unknown:-1:-1
end)()
list_result__82 = table__68
--@ unknown:-1:-1
end)()
_modules_compiler_parse__0 = list_result__82
--@ unknown:-1:-1
local apply_result__756 = _modules_compiler_parse__0[".parse"]
parse__0 = apply_result__756
--@ unknown:-1:-1
local list_result__102
(function ()
local is_word___0, is_anon_key___0, resolve__1
--@ compiler/resolve.luma:1:22
local fn__266 = function (param__330, param__331)
--@ compiler/resolve.luma:2:25
local apply_result__757 = invoke_symbol (_word_node__0, ".?", 1, param__330)
local result__114 = apply_result__757
if result__114 then
--@ compiler/resolve.luma:2:34
local apply_result__758 = invoke_symbol (param__330, ".id", 0)
--@ compiler/resolve.luma:2:42
local apply_result__759 = invoke (___4, 2, apply_result__758, param__331)
result__114 = apply_result__759
end
return result__114
end
is_word___0 = fn__266
--@ compiler/resolve.luma:4:21
local fn__267 = function (param__332)
--@ compiler/resolve.luma:7:25
local apply_result__760 = invoke_symbol (_apply_node__0, ".?", 1, param__332)
local result__115 = apply_result__760
if result__115 then
--@ compiler/resolve.luma:8:12
local apply_result__761 = invoke_symbol (param__332, ".items", 0)
local apply_result__762 = invoke_symbol (apply_result__761, ".length", 0)
--@ compiler/resolve.luma:8:30
local apply_result__763 = invoke_symbol (apply_result__762, ".>", 1, 0)
result__115 = apply_result__763
end
local result__116 = result__115
if result__116 then
--@ compiler/resolve.luma:10:27
local apply_result__764 = invoke_symbol (param__332, ".items", 0)
--@ compiler/resolve.luma:10:39
local apply_result__765 = invoke_symbol (apply_result__764, ".get", 1, 0)
local apply_result__766 = invoke_symbol (_symbol_node__0, ".?", 1, apply_result__765)
local result__117 = apply_result__766
if result__117 then
--@ compiler/resolve.luma:11:15
local apply_result__767 = invoke_symbol (param__332, ".items", 0)
--@ compiler/resolve.luma:11:27
local apply_result__768 = invoke_symbol (apply_result__767, ".get", 1, 0)
local apply_result__769 = invoke_symbol (apply_result__768, ".id", 0)
--@ compiler/resolve.luma:11:35
local apply_result__770 = invoke (___4, 2, apply_result__769, ".")
result__117 = apply_result__770
end
result__116 = result__117
end
return result__116
end
is_anon_key___0 = fn__267
--@ compiler/resolve.luma:13:21
local fn__268 = function (param__333)
--@ compiler/resolve.luma:13:21
local list_result__103
(function ()
local resolve_table__0, resolve_list__0, resolve_pair__0, resolve_apply__0, resolve_word__0, resolve_node__0
--@ compiler/resolve.luma:15:24
local fn__269 = function (param__334)
--@ compiler/resolve.luma:15:24
local list_result__104
(function ()
local items__3
--@ compiler/resolve.luma:16:17
local apply_result__771 = invoke_symbol (param__334, ".items", 0)
--@ compiler/resolve.luma:16:30
local apply_result__772 = invoke_symbol (apply_result__771, ".drop", 1, 1)
--@ compiler/resolve.luma:16:48
local apply_result__773 = invoke_symbol (apply_result__772, ".map", 1, resolve_node__0)
items__3 = apply_result__773
--@ compiler/resolve.luma:18:27
local apply_result__774 = invoke_symbol (param__334, ".location", 0)
local apply_result__775 = invoke (_table_node__0, 2, items__3, apply_result__774)
list_result__104 = apply_result__775
--@ unknown:-1:-1
end)()
return list_result__104
end
resolve_table__0 = fn__269
--@ compiler/resolve.luma:20:23
local fn__270 = function (param__335)
--@ compiler/resolve.luma:20:23
local list_result__105
(function ()
local items__4
--@ compiler/resolve.luma:21:17
local apply_result__776 = invoke_symbol (param__335, ".items", 0)
--@ compiler/resolve.luma:21:30
local apply_result__777 = invoke_symbol (apply_result__776, ".drop", 1, 1)
--@ compiler/resolve.luma:21:48
local apply_result__778 = invoke_symbol (apply_result__777, ".map", 1, resolve_node__0)
items__4 = apply_result__778
--@ compiler/resolve.luma:23:26
local apply_result__779 = invoke_symbol (param__335, ".location", 0)
local apply_result__780 = invoke (_list_node__0, 2, items__4, apply_result__779)
list_result__105 = apply_result__780
--@ unknown:-1:-1
end)()
return list_result__105
end
resolve_list__0 = fn__270
--@ compiler/resolve.luma:25:23
local fn__271 = function (param__336)
--@ compiler/resolve.luma:25:23
local list_result__106
(function ()
local items__5
--@ compiler/resolve.luma:26:17
local apply_result__781 = invoke_symbol (param__336, ".items", 0)
--@ compiler/resolve.luma:26:30
local apply_result__782 = invoke_symbol (apply_result__781, ".drop", 1, 1)
--@ compiler/resolve.luma:26:48
local apply_result__783 = invoke_symbol (apply_result__782, ".map", 1, resolve_node__0)
items__5 = apply_result__783
--@ compiler/resolve.luma:27:22
local apply_result__784 = invoke_symbol (items__5, ".length", 0)
local apply_result__785 = invoke (___4, 2, 2, apply_result__784)
--@ compiler/resolve.luma:27:62
local apply_result__786 = invoke_symbol (param__336, ".location", 0)
local apply_result__787 = invoke_symbol (apply_result__786, ".to-string", 0)
local assert_result__22 = assert(apply_result__785, "pair needs two items at ", apply_result__787)
--@ compiler/resolve.luma:28:28
local apply_result__788 = invoke_symbol (items__5, ".get", 1, 0)
--@ compiler/resolve.luma:28:42
local apply_result__789 = invoke_symbol (items__5, ".get", 1, 1)
--@ compiler/resolve.luma:28:48
local apply_result__790 = invoke_symbol (param__336, ".location", 0)
local apply_result__791 = invoke (_pair_node__0, 3, apply_result__788, apply_result__789, apply_result__790)
list_result__106 = apply_result__791
--@ unknown:-1:-1
end)()
return list_result__106
end
resolve_pair__0 = fn__271
--@ compiler/resolve.luma:30:24
local fn__272 = function (param__337)
--@ compiler/resolve.luma:30:24
local list_result__107
(function ()
local first__2
--@ compiler/resolve.luma:31:17
local apply_result__792 = invoke_symbol (param__337, ".items", 0)
local apply_result__793 = invoke_symbol (apply_result__792, ".length", 0)
--@ compiler/resolve.luma:31:35
local apply_result__794 = invoke_symbol (apply_result__793, ".>", 1, 0)
--@ compiler/resolve.luma:31:81
local apply_result__795 = invoke_symbol (param__337, ".location", 0)
local apply_result__796 = invoke_symbol (apply_result__795, ".to-string", 0)
local apply_result__797 = invoke (combine_strings__0, 2, "empty apply node at ", apply_result__796)
local assert_result__23 = assert(apply_result__794, apply_result__797)
--@ compiler/resolve.luma:32:16
local apply_result__798 = invoke_symbol (param__337, ".items", 0)
--@ compiler/resolve.luma:32:28
local apply_result__799 = invoke_symbol (apply_result__798, ".get", 1, 0)
first__2 = apply_result__799
--@ compiler/resolve.luma:33:9
local result__118
--@ compiler/resolve.luma:34:26
local apply_result__800 = is_word___0 (first__2, "#")
if apply_result__800 then
--@ compiler/resolve.luma:34:48
local apply_result__801 = resolve_table__0 (param__337)
result__118 = apply_result__801
else
--@ compiler/resolve.luma:35:26
local apply_result__802 = is_word___0 (first__2, "!")
if apply_result__802 then
--@ compiler/resolve.luma:35:47
local apply_result__803 = resolve_list__0 (param__337)
result__118 = apply_result__803
else
--@ compiler/resolve.luma:36:26
local apply_result__804 = is_word___0 (first__2, ":")
if apply_result__804 then
--@ compiler/resolve.luma:36:47
local apply_result__805 = resolve_pair__0 (param__337)
result__118 = apply_result__805
else
--@ compiler/resolve.luma:37:11
if else__0 then
--@ compiler/resolve.luma:37:12
local list_result__108
(function ()
local items__6
--@ compiler/resolve.luma:38:20
local apply_result__806 = invoke_symbol (param__337, ".items", 0)
--@ compiler/resolve.luma:38:43
local apply_result__807 = invoke_symbol (apply_result__806, ".map", 1, resolve_node__0)
items__6 = apply_result__807
--@ compiler/resolve.luma:39:31
local apply_result__808 = invoke_symbol (param__337, ".location", 0)
local apply_result__809 = invoke (_apply_node__0, 2, items__6, apply_result__808)
list_result__108 = apply_result__809
--@ unknown:-1:-1
end)()
result__118 = list_result__108
else
result__118 = false 
end
end
end
end
list_result__107 = result__118
--@ unknown:-1:-1
end)()
return list_result__107
end
resolve_apply__0 = fn__272
--@ compiler/resolve.luma:41:23
local fn__273 = function (param__338)
--@ compiler/resolve.luma:42:9
local result__119
--@ compiler/resolve.luma:43:22
local apply_result__810 = invoke_symbol (param__338, ".id", 0)
local apply_result__811 = invoke_symbol (apply_result__810, ".length", 0)
local apply_result__812 = invoke (____1, 2, 1, apply_result__811)
local result__120 = apply_result__812
if result__120 then
--@ compiler/resolve.luma:43:46
local apply_result__813 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:43:63
local apply_result__814 = invoke_symbol (apply_result__813, ".substring", 2, 0, 1)
local apply_result__815 = invoke (___4, 2, ".", apply_result__814)
result__120 = apply_result__815
end
if result__120 then
--@ compiler/resolve.luma:44:26
local apply_result__816 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:44:34
local apply_result__817 = invoke_symbol (param__338, ".location", 0)
local apply_result__818 = invoke (_symbol_node__0, 2, apply_result__816, apply_result__817)
result__119 = apply_result__818
else
--@ compiler/resolve.luma:45:22
local apply_result__819 = invoke_symbol (param__338, ".id", 0)
local apply_result__820 = invoke_symbol (apply_result__819, ".length", 0)
local apply_result__821 = invoke (____1, 2, 1, apply_result__820)
local result__121 = apply_result__821
if result__121 then
--@ compiler/resolve.luma:45:47
local apply_result__822 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:45:64
local apply_result__823 = invoke_symbol (apply_result__822, ".substring", 2, 0, 1)
local apply_result__824 = invoke (___4, 2, "'", apply_result__823)
result__121 = apply_result__824
end
if result__121 then
--@ compiler/resolve.luma:46:27
local apply_result__825 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:46:50
local apply_result__826 = invoke_symbol (param__338, ".id", 0)
local apply_result__827 = invoke_symbol (apply_result__826, ".length", 0)
--@ compiler/resolve.luma:46:62
local apply_result__828 = invoke (___1, 2, apply_result__827, 1)
local apply_result__829 = invoke_symbol (apply_result__825, ".substring", 2, 1, apply_result__828)
--@ compiler/resolve.luma:46:69
local apply_result__830 = invoke_symbol (param__338, ".location", 0)
local apply_result__831 = invoke (_string_node__0, 2, apply_result__829, apply_result__830)
result__119 = apply_result__831
else
--@ compiler/resolve.luma:47:12
local apply_result__832 = invoke_symbol (param__338, ".id", 0)
local apply_result__833 = invoke_symbol (apply_result__832, ".to-number", 0)
if apply_result__833 then
--@ compiler/resolve.luma:48:26
local apply_result__834 = invoke_symbol (param__338, ".id", 0)
local apply_result__835 = invoke_symbol (apply_result__834, ".to-number", 0)
--@ compiler/resolve.luma:48:44
local apply_result__836 = invoke_symbol (param__338, ".location", 0)
local apply_result__837 = invoke (_number_node__0, 2, apply_result__835, apply_result__836)
result__119 = apply_result__837
else
--@ compiler/resolve.luma:49:12
local apply_result__838 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:49:30
local apply_result__839 = invoke_symbol (apply_result__838, ".contains?", 1, "..")
if apply_result__839 then
--@ compiler/resolve.luma:50:26
local apply_result__840 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:50:34
local apply_result__841 = invoke_symbol (param__338, ".location", 0)
local apply_result__842 = invoke (_vararg_node__0, 2, apply_result__840, apply_result__841)
result__119 = apply_result__842
else
--@ compiler/resolve.luma:51:16
local apply_result__843 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:51:33
local apply_result__844 = invoke_symbol (apply_result__843, ".contains?", 1, ".")
local result__122 = apply_result__844
if not result__122 then
--@ compiler/resolve.luma:51:44
local apply_result__845 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:51:61
local apply_result__846 = invoke_symbol (apply_result__845, ".contains?", 1, "[")
local result__123 = apply_result__846
if not result__123 then
--@ compiler/resolve.luma:51:68
local apply_result__847 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:51:85
local apply_result__848 = invoke_symbol (apply_result__847, ".contains?", 1, "]")
result__123 = apply_result__848
end
result__122 = result__123
end
if result__122 then
--@ compiler/resolve.luma:52:73
local apply_result__849 = invoke_symbol (param__338, ".id", 0)
--@ compiler/resolve.luma:52:88
local apply_result__850 = invoke_symbol (param__338, ".location", 0)
local apply_result__851 = invoke_symbol (apply_result__850, ".to-string", 0)
local apply_result__852 = invoke (combine_strings__0, 4, "invalid character in word: ", apply_result__849, " at ", apply_result__851)
local assert_result__24 = assert(false, apply_result__852)
result__119 = assert_result__24
else
--@ compiler/resolve.luma:53:11
if else__0 then
--@ compiler/resolve.luma:54:13
result__119 = param__338
else
result__119 = false 
end
end
end
end
end
end
return result__119
end
resolve_word__0 = fn__273
--@ compiler/resolve.luma:56:23
local fn__274 = function (param__339)
--@ compiler/resolve.luma:57:9
local result__124
--@ compiler/resolve.luma:58:26
local apply_result__853 = invoke_symbol (_apply_node__0, ".?", 1, param__339)
if apply_result__853 then
--@ compiler/resolve.luma:58:48
local apply_result__854 = resolve_apply__0 (param__339)
result__124 = apply_result__854
else
--@ compiler/resolve.luma:59:25
local apply_result__855 = invoke_symbol (_word_node__0, ".?", 1, param__339)
if apply_result__855 then
--@ compiler/resolve.luma:59:47
local apply_result__856 = resolve_word__0 (param__339)
result__124 = apply_result__856
else
--@ compiler/resolve.luma:60:11
if else__0 then
--@ compiler/resolve.luma:60:91
local apply_result__857 = invoke_symbol (param__339, ".location", 0)
local apply_result__858 = invoke_symbol (apply_result__857, ".to-string", 0)
local apply_result__859 = invoke (combine_strings__0, 2, "resolve: unknown node at ", apply_result__858)
local assert_result__25 = assert(false, apply_result__859)
result__124 = assert_result__25
else
result__124 = false 
end
end
end
return result__124
end
resolve_node__0 = fn__274
--@ compiler/resolve.luma:62:26
local apply_result__860 = resolve_node__0 (param__333)
list_result__103 = apply_result__860
--@ unknown:-1:-1
end)()
return list_result__103
end
resolve__1 = fn__268
--@ compiler/resolve.luma:64:2
local table__69
(function ()
--@ compiler/resolve.luma:65:20
table__69 = {
[".resolve"] = resolve__1,
}
--@ unknown:-1:-1
end)()
list_result__102 = table__69
--@ unknown:-1:-1
end)()
_modules_compiler_resolve__0 = list_result__102
--@ unknown:-1:-1
local apply_result__861 = _modules_compiler_resolve__0[".resolve"]
resolve__0 = apply_result__861
--@ unknown:-1:-1
local list_result__109
(function ()
local remove_item__0, contains___0, is_word___1, link__1
--@ compiler/link.luma:1:25
local fn__275 = function (param__340, param__341)
--@ compiler/link.luma:2:7
local result__125
--@ compiler/link.luma:3:9
local apply_result__862 = invoke_symbol (param__340, ".empty?", 0)
if apply_result__862 then
--@ compiler/link.luma:4:55
local assert_result__26 = assert(false, "tried to remove non-existent item")
result__125 = assert_result__26
else
--@ compiler/link.luma:5:12
local apply_result__863 = invoke_symbol (param__340, ".first", 0)
--@ compiler/link.luma:5:23
local apply_result__864 = invoke (___4, 2, apply_result__863, param__341)
if apply_result__864 then
--@ compiler/link.luma:6:11
local apply_result__865 = invoke_symbol (param__340, ".rest", 0)
result__125 = apply_result__865
else
--@ compiler/link.luma:7:9
if else__0 then
--@ compiler/link.luma:8:22
local apply_result__866 = invoke_symbol (param__340, ".first", 0)
--@ compiler/link.luma:8:46
local apply_result__867 = invoke_symbol (param__340, ".rest", 0)
--@ compiler/link.luma:8:56
local apply_result__868 = invoke (remove_item__0, 2, apply_result__867, param__341)
local apply_result__869 = invoke_symbol (_list__0, ".link", 2, apply_result__866, apply_result__868)
result__125 = apply_result__869
else
result__125 = false 
end
end
end
return result__125
end
remove_item__0 = fn__275
--@ compiler/link.luma:10:23
local fn__276 = function (param__342, param__343)
--@ compiler/link.luma:11:10
local apply_result__870 = invoke_symbol (param__342, ".empty?", 0)
local result__126
if apply_result__870 then
--@ compiler/link.luma:12:10
result__126 = false
else
--@ compiler/link.luma:13:20
local apply_result__871 = invoke_symbol (param__342, ".first", 0)
local apply_result__872 = invoke (___4, 2, param__343, apply_result__871)
local result__127 = apply_result__872
if not result__127 then
--@ compiler/link.luma:13:43
local apply_result__873 = invoke_symbol (param__342, ".rest", 0)
--@ compiler/link.luma:13:53
local apply_result__874 = invoke (contains___0, 2, apply_result__873, param__343)
result__127 = apply_result__874
end
result__126 = result__127
end
return result__126
end
contains___0 = fn__276
--@ compiler/link.luma:15:19
local fn__277 = function (param__344, param__345)
--@ compiler/link.luma:16:24
local apply_result__875 = invoke_symbol (_word_node__0, ".?", 1, param__344)
local result__128 = apply_result__875
if result__128 then
--@ compiler/link.luma:16:32
local apply_result__876 = invoke_symbol (param__344, ".id", 0)
--@ compiler/link.luma:16:38
local apply_result__877 = invoke (___4, 2, apply_result__876, param__345)
result__128 = apply_result__877
end
return result__128
end
is_word___1 = fn__277
--@ compiler/link.luma:18:18
local fn__278 = function (param__346)
--@ compiler/link.luma:18:18
local list_result__110
(function ()
local modules_linked__0, cycling__0, result__129, scan_module_for_imports__0, import_module__0
--@ compiler/link.luma:19:25
local apply_result__878 = invoke (_list__0, 0)
modules_linked__0 = apply_result__878
--@ compiler/link.luma:20:18
local apply_result__879 = invoke (_list__0, 0)
cycling__0 = apply_result__879
--@ compiler/link.luma:21:18
local apply_result__880 = invoke (_array__0, 0)
result__129 = apply_result__880
--@ compiler/link.luma:23:33
local fn__279 = function (param__347)
--@ compiler/link.luma:23:33
local list_result__111
(function ()
--@ compiler/link.luma:24:32
local apply_result__881 = invoke_symbol (_list_node__0, ".?", 1, param__347)
--@ compiler/link.luma:24:76
local apply_result__882 = invoke (assert_at__0, 3, apply_result__881, param__347, "top level of module should be a list")
--@ compiler/link.luma:25:8
local apply_result__883 = invoke_symbol (param__347, ".items", 0)
--@ compiler/link.luma:25:29
local fn__280 = function (param__348)
--@ compiler/link.luma:26:11
local result__130
--@ compiler/link.luma:26:36
local apply_result__884 = invoke_symbol (_apply_node__0, ".?", 1, param__348)
local result__131 = apply_result__884
if result__131 then
--@ compiler/link.luma:26:53
local apply_result__885 = invoke_symbol (param__348, ".items", 0)
--@ compiler/link.luma:26:65
local apply_result__886 = invoke_symbol (apply_result__885, ".get", 1, 0)
--@ compiler/link.luma:26:75
local apply_result__887 = is_word___1 (apply_result__886, "import")
result__131 = apply_result__887
end
if result__131 then
--@ compiler/link.luma:26:78
local list_result__112
(function ()
local name__0
--@ compiler/link.luma:27:28
local apply_result__888 = invoke_symbol (param__348, ".items", 0)
local apply_result__889 = invoke_symbol (apply_result__888, ".length", 0)
local apply_result__890 = invoke (___4, 2, 2, apply_result__889)
--@ compiler/link.luma:27:81
local apply_result__891 = invoke (assert_at__0, 3, apply_result__890, param__348, "import should take one argument")
--@ compiler/link.luma:28:19
local apply_result__892 = invoke_symbol (param__348, ".items", 0)
--@ compiler/link.luma:28:31
local apply_result__893 = invoke_symbol (apply_result__892, ".get", 1, 1)
name__0 = apply_result__893
--@ compiler/link.luma:29:39
local apply_result__894 = invoke_symbol (_string_node__0, ".?", 1, name__0)
--@ compiler/link.luma:29:87
local apply_result__895 = invoke (assert_at__0, 3, apply_result__894, param__348, "import should be given a string literal")
--@ compiler/link.luma:30:27
local apply_result__896 = invoke_symbol (name__0, ".value", 0)
local apply_result__897 = invoke (import_module__0, 1, apply_result__896)
list_result__112 = apply_result__897
--@ unknown:-1:-1
end)()
result__130 = list_result__112
else
result__130 = false 
end
return result__130
end
local apply_result__898 = invoke_symbol (apply_result__883, ".each", 1, fn__280)
list_result__111 = apply_result__898
--@ unknown:-1:-1
end)()
return list_result__111
end
scan_module_for_imports__0 = fn__279
--@ compiler/link.luma:32:24
local fn__281 = function (param__349)
--@ compiler/link.luma:32:24
local list_result__113
(function ()
local internal__0
--@ compiler/link.luma:33:47
local apply_result__899 = invoke (combine_strings__0, 2, "&modules/", param__349)
internal__0 = apply_result__899
--@ compiler/link.luma:34:9
local result__132
--@ compiler/link.luma:34:45
local apply_result__900 = contains___0 (modules_linked__0, param__349)
local apply_result__901 = invoke (not__0, 1, apply_result__900)
if apply_result__901 then
--@ compiler/link.luma:34:48
local list_result__114
(function ()
local filename__0, str__0, tokens__1, mod__0, exports_table__0
--@ compiler/link.luma:35:11
local result__133
--@ compiler/link.luma:35:35
local apply_result__902 = contains___0 (cycling__0, param__349)
if apply_result__902 then
--@ compiler/link.luma:36:65
local apply_result__903 = invoke (combine_strings__0, 2, "cycle in import of ", param__349)
local assert_result__27 = assert(false, apply_result__903)
result__133 = assert_result__27
else
result__133 = false 
end
--@ compiler/link.luma:37:57
local apply_result__904 = invoke_symbol (_list__0, ".link", 2, param__349, modules_linked__0)
modules_linked__0 = apply_result__904
--@ compiler/link.luma:38:50
local apply_result__905 = invoke_symbol (_list__0, ".link", 2, param__349, modules_linked__0)
cycling__0 = apply_result__905
--@ compiler/link.luma:40:45
local apply_result__906 = invoke (combine_strings__0, 2, param__349, ".luma")
filename__0 = apply_result__906
--@ compiler/link.luma:41:30
local apply_result__907 = invoke (read_file__0, 1, filename__0)
str__0 = apply_result__907
--@ compiler/link.luma:42:32
local apply_result__908 = invoke (read__0, 2, str__0, filename__0)
tokens__1 = apply_result__908
--@ compiler/link.luma:43:33
local apply_result__909 = invoke (parse__0, 1, tokens__1)
local apply_result__910 = invoke (resolve__0, 1, apply_result__909)
mod__0 = apply_result__910
--@ compiler/link.luma:44:34
local apply_result__911 = scan_module_for_imports__0 (mod__0)
--@ compiler/link.luma:45:21
local apply_result__912 = invoke_symbol (mod__0, ".items", 0)
local apply_result__913 = invoke_symbol (apply_result__912, ".length", 0)
--@ compiler/link.luma:45:39
local apply_result__914 = invoke_symbol (apply_result__913, ".>", 1, 0)
--@ compiler/link.luma:45:88
local apply_result__915 = invoke (assert_at__0, 3, apply_result__914, mod__0, "empty module (todo: does this ever fire?)")
--@ compiler/link.luma:47:51
local apply_result__916 = invoke (_word_node__0, 1, internal__0)
--@ compiler/link.luma:47:56
local apply_result__917 = invoke (_pair_node__0, 2, apply_result__916, mod__0)
local apply_result__918 = invoke_symbol (result__129, ".push", 1, apply_result__917)
--@ compiler/link.luma:49:25
local apply_result__919 = invoke_symbol (mod__0, ".items", 0)
local apply_result__920 = invoke_symbol (apply_result__919, ".last", 0)
exports_table__0 = apply_result__920
--@ compiler/link.luma:50:45
local apply_result__921 = invoke_symbol (_table_node__0, ".?", 1, exports_table__0)
--@ compiler/link.luma:50:101
local apply_result__922 = invoke (assert_at__0, 3, apply_result__921, exports_table__0, "modules need to end in a literal table")
--@ compiler/link.luma:51:20
local apply_result__923 = invoke_symbol (exports_table__0, ".items", 0)
--@ compiler/link.luma:51:42
local fn__282 = function (param__350)
--@ compiler/link.luma:51:42
local list_result__115
(function ()
--@ compiler/link.luma:52:38
local apply_result__924 = invoke_symbol (_pair_node__0, ".?", 1, param__350)
--@ compiler/link.luma:52:78
local apply_result__925 = invoke (assert_at__0, 3, apply_result__924, param__350, "unknown item in module exports")
--@ compiler/link.luma:53:40
local apply_result__926 = invoke_symbol (param__350, ".key", 0)
local apply_result__927 = invoke_symbol (_symbol_node__0, ".?", 1, apply_result__926)
--@ compiler/link.luma:53:51
local apply_result__928 = invoke_symbol (param__350, ".key", 0)
--@ compiler/link.luma:53:92
local apply_result__929 = invoke (assert_at__0, 3, apply_result__927, apply_result__928, "unknown pair key in module exports")
--@ compiler/link.luma:55:40
local apply_result__930 = invoke_symbol (param__350, ".key", 0)
local apply_result__931 = invoke_symbol (apply_result__930, ".id", 0)
--@ compiler/link.luma:55:65
local apply_result__932 = invoke_symbol (param__350, ".key", 0)
local apply_result__933 = invoke_symbol (apply_result__932, ".id", 0)
local apply_result__934 = invoke_symbol (apply_result__933, ".length", 0)
local apply_result__935 = invoke_symbol (apply_result__931, ".substring", 2, 1, apply_result__934)
local apply_result__936 = invoke (_word_node__0, 1, apply_result__935)
--@ compiler/link.luma:56:61
local apply_result__937 = invoke (_word_node__0, 1, internal__0)
--@ compiler/link.luma:56:82
local apply_result__938 = invoke_symbol (param__350, ".key", 0)
local apply_result__939 = invoke_symbol (apply_result__938, ".id", 0)
local apply_result__940 = invoke (_symbol_node__0, 1, apply_result__939)
local apply_result__941 = invoke (_list__0, 2, apply_result__937, apply_result__940)
local apply_result__942 = invoke (_apply_node__0, 1, apply_result__941)
local apply_result__943 = invoke (_pair_node__0, 2, apply_result__936, apply_result__942)
local apply_result__944 = invoke_symbol (result__129, ".push", 1, apply_result__943)
list_result__115 = apply_result__944
--@ unknown:-1:-1
end)()
return list_result__115
end
local apply_result__945 = invoke_symbol (apply_result__923, ".each", 1, fn__282)
--@ compiler/link.luma:57:44
local apply_result__946 = remove_item__0 (cycling__0, param__349)
cycling__0 = apply_result__946
list_result__114 = true
--@ unknown:-1:-1
end)()
result__132 = list_result__114
else
result__132 = false 
end
list_result__113 = result__132
--@ unknown:-1:-1
end)()
return list_result__113
end
import_module__0 = fn__281
--@ compiler/link.luma:59:37
local apply_result__947 = scan_module_for_imports__0 (param__346)
--@ compiler/link.luma:60:24
local apply_result__948 = invoke_symbol (result__129, ".push", 1, param__346)
--@ compiler/link.luma:61:21
local apply_result__949 = invoke (_list_node__0, 1, result__129)
list_result__110 = apply_result__949
--@ unknown:-1:-1
end)()
return list_result__110
end
link__1 = fn__278
--@ compiler/link.luma:63:2
local table__70
(function ()
--@ compiler/link.luma:64:14
table__70 = {
[".link"] = link__1,
}
--@ unknown:-1:-1
end)()
list_result__109 = table__70
--@ unknown:-1:-1
end)()
_modules_compiler_link__0 = list_result__109
--@ unknown:-1:-1
local apply_result__950 = _modules_compiler_link__0[".link"]
link__0 = apply_result__950
--@ unknown:-1:-1
local list_result__116
(function ()
local emit_debug_info__0, key_____0, _type__0, _value__0, seq__0, comma_separate__0, words__ids__0, is_function_vararg___0, process_symbol_function_or_method__0, process_plain_function__0, process_pair__0, process_pairs__0, compile__1
--@ compiler/compile.luma:1:22
emit_debug_info__0 = true
--@ compiler/compile.luma:3:14
local fn__283 = function (param__351, param__352)
--@ compiler/compile.luma:3:14
local list_result__117
(function ()
local a_type_value__0, b_type_value__0
--@ compiler/compile.luma:4:32
local apply_result__951 = invoke_symbol (_number__0, ".?", 1, param__351)
local result__134
if apply_result__951 then
--@ compiler/compile.luma:4:35
result__134 = 0
else
--@ compiler/compile.luma:4:37
result__134 = 1
end
a_type_value__0 = result__134
--@ compiler/compile.luma:5:32
local apply_result__952 = invoke_symbol (_number__0, ".?", 1, param__352)
local result__135
if apply_result__952 then
--@ compiler/compile.luma:5:35
result__135 = 0
else
--@ compiler/compile.luma:5:37
result__135 = 1
end
b_type_value__0 = result__135
--@ compiler/compile.luma:6:7
local result__136
--@ compiler/compile.luma:7:34
local apply_result__953 = invoke_symbol (a_type_value__0, ".<", 1, b_type_value__0)
if apply_result__953 then
--@ compiler/compile.luma:7:41
result__136 = true
else
--@ compiler/compile.luma:8:34
local apply_result__954 = invoke_symbol (a_type_value__0, ".=", 1, b_type_value__0)
if apply_result__954 then
--@ compiler/compile.luma:8:44
local apply_result__955 = invoke_symbol (param__351, ".<=", 1, param__352)
result__136 = apply_result__955
else
--@ compiler/compile.luma:9:9
if else__0 then
--@ compiler/compile.luma:9:42
result__136 = false
else
result__136 = false 
end
end
end
list_result__117 = result__136
--@ unknown:-1:-1
end)()
return list_result__117
end
key_____0 = fn__283
--@ compiler/compile.luma:11:9
local table__71
(function ()
local fn__284 = function (param__353)
--@ compiler/compile.luma:12:25
local result__137 = type (param__353) == "table" and (param__353.index == _type__0 or param__353[_type__0] ~= nil)
return result__137
end
local fn__285 = function ()
--@ compiler/compile.luma:13:9
local table__72
(function ()
--@ compiler/compile.luma:15:23
local apply_result__956 = invoke (_hash__0, 0)
--@ compiler/compile.luma:16:23
local apply_result__957 = invoke (_hash__0, 0)
--@ compiler/compile.luma:17:23
local apply_result__958 = invoke (_hash__0, 0)
--@ compiler/compile.luma:18:22
table__72 = {
["index"] = _type__0,
[".call"] = false,
[".fields"] = apply_result__956,
[".functions"] = apply_result__957,
[".methods"] = apply_result__958,
[".index"] = false,
}
--@ unknown:-1:-1
end)()
return table__72
end
local fn__286 = function (param__354)
--@ compiler/compile.luma:20:20
local list_result__118
(function ()
local out__2, add_from_hash__0
--@ compiler/compile.luma:21:25
local apply_result__959 = invoke (_array__0, 1, "[type")
out__2 = apply_result__959
--@ compiler/compile.luma:23:31
local fn__287 = function (param__355, param__356)
--@ compiler/compile.luma:23:31
local list_result__119
(function ()
local keys__0
--@ compiler/compile.luma:24:17
local apply_result__960 = invoke_symbol (param__356, ".key-iterator", 0)
local apply_result__961 = invoke_symbol (apply_result__960, ".to-array", 0)
keys__0 = apply_result__961
--@ compiler/compile.luma:25:23
local apply_result__962 = invoke_symbol (keys__0, ".sort", 1, key_____0)
--@ compiler/compile.luma:26:11
local result__138
--@ compiler/compile.luma:26:17
local apply_result__963 = invoke_symbol (keys__0, ".length", 0)
--@ compiler/compile.luma:26:29
local apply_result__964 = invoke_symbol (apply_result__963, ".>", 1, 0)
if apply_result__964 then
--@ compiler/compile.luma:26:31
local list_result__120
(function ()
--@ compiler/compile.luma:27:22
local apply_result__965 = invoke_symbol (out__2, ".push", 1, " [")
--@ compiler/compile.luma:28:22
local apply_result__966 = invoke_symbol (out__2, ".push", 1, param__355)
--@ compiler/compile.luma:29:25
local fn__288 = function (param__357)
--@ compiler/compile.luma:29:25
local list_result__121
(function ()
local type__0
--@ compiler/compile.luma:30:23
local apply_result__967 = invoke_symbol (out__2, ".push", 1, " ")
--@ compiler/compile.luma:31:21
local apply_result__968 = invoke_symbol (param__357, ".to-string", 0)
local apply_result__969 = invoke_symbol (out__2, ".push", 1, apply_result__968)
--@ compiler/compile.luma:32:28
local apply_result__970 = invoke_symbol (param__356, ".get", 1, param__357)
type__0 = apply_result__970
--@ compiler/compile.luma:33:15
local result__139
--@ compiler/compile.luma:33:29
local apply_result__971 = invoke_symbol (_type__0, ".?", 1, type__0)
if apply_result__971 then
--@ compiler/compile.luma:33:31
local list_result__122
(function ()
--@ compiler/compile.luma:34:26
local apply_result__972 = invoke_symbol (out__2, ".push", 1, ": ")
--@ compiler/compile.luma:35:26
local apply_result__973 = invoke_symbol (type__0, ".to-string", 0)
local apply_result__974 = invoke_symbol (out__2, ".push", 1, apply_result__973)
list_result__122 = apply_result__974
--@ unknown:-1:-1
end)()
result__139 = list_result__122
else
result__139 = false 
end
list_result__121 = result__139
--@ unknown:-1:-1
end)()
return list_result__121
end
local apply_result__975 = invoke_symbol (keys__0, ".each", 1, fn__288)
--@ compiler/compile.luma:36:21
local apply_result__976 = invoke_symbol (out__2, ".push", 1, "]")
list_result__120 = apply_result__976
--@ unknown:-1:-1
end)()
result__138 = list_result__120
else
result__138 = false 
end
list_result__119 = result__138
--@ unknown:-1:-1
end)()
return list_result__119
end
add_from_hash__0 = fn__287
--@ compiler/compile.luma:38:33
local apply_result__977 = invoke_symbol (param__354, ".fields", 0)
local apply_result__978 = add_from_hash__0 ("fields", apply_result__977)
--@ compiler/compile.luma:39:36
local apply_result__979 = invoke_symbol (param__354, ".functions", 0)
local apply_result__980 = add_from_hash__0 ("functions", apply_result__979)
--@ compiler/compile.luma:40:34
local apply_result__981 = invoke_symbol (param__354, ".methods", 0)
local apply_result__982 = add_from_hash__0 ("methods", apply_result__981)
--@ compiler/compile.luma:41:9
local result__140
--@ compiler/compile.luma:41:14
local apply_result__983 = invoke_symbol (param__354, ".call", 0)
if apply_result__983 then
--@ compiler/compile.luma:41:20
local list_result__123
(function ()
--@ compiler/compile.luma:42:25
local apply_result__984 = invoke_symbol (out__2, ".push", 1, " [call ")
--@ compiler/compile.luma:43:20
local apply_result__985 = invoke_symbol (param__354, ".call", 0)
local apply_result__986 = invoke_symbol (apply_result__985, ".to-string", 0)
local apply_result__987 = invoke_symbol (out__2, ".push", 1, apply_result__986)
--@ compiler/compile.luma:44:19
local apply_result__988 = invoke_symbol (out__2, ".push", 1, "]")
list_result__123 = apply_result__988
--@ unknown:-1:-1
end)()
result__140 = list_result__123
else
result__140 = false 
end
--@ compiler/compile.luma:45:9
local result__141
--@ compiler/compile.luma:45:14
local apply_result__989 = invoke_symbol (param__354, ".index", 0)
if apply_result__989 then
--@ compiler/compile.luma:45:21
local list_result__124
(function ()
--@ compiler/compile.luma:46:26
local apply_result__990 = invoke_symbol (out__2, ".push", 1, " [index ")
--@ compiler/compile.luma:47:20
local apply_result__991 = invoke_symbol (param__354, ".index", 0)
local apply_result__992 = invoke_symbol (apply_result__991, ".to-string", 0)
local apply_result__993 = invoke_symbol (out__2, ".push", 1, apply_result__992)
--@ compiler/compile.luma:48:19
local apply_result__994 = invoke_symbol (out__2, ".push", 1, "]")
list_result__124 = apply_result__994
--@ unknown:-1:-1
end)()
result__141 = list_result__124
else
result__141 = false 
end
--@ compiler/compile.luma:49:17
local apply_result__995 = invoke_symbol (out__2, ".push", 1, "]")
--@ compiler/compile.luma:50:8
local apply_result__996 = invoke_symbol (out__2, ".concat", 0)
list_result__118 = apply_result__996
--@ unknown:-1:-1
end)()
return list_result__118
end
table__71 = {
functions = {
[".?"] = fn__284,
[0] = fn__285,
},
methods = {
[".to-string"] = fn__286,
},
}
--@ unknown:-1:-1
end)()
_type__0 = table__71
--@ compiler/compile.luma:53:10
local table__73
(function ()
local fn__289 = function (param__358)
--@ compiler/compile.luma:54:26
local result__142 = type (param__358) == "table" and (param__358.index == _value__0 or param__358[_value__0] ~= nil)
return result__142
end
local fn__290 = function (param__359)
--@ compiler/compile.luma:55:14
local table__74
(function ()
--@ compiler/compile.luma:57:18
local apply_result__997 = _type__0.functions[0] ()
table__74 = {
["index"] = _value__0,
[".id"] = param__359,
[".type"] = apply_result__997,
}
--@ unknown:-1:-1
end)()
return table__74
end
table__73 = {
functions = {
[".?"] = fn__289,
[1] = fn__290,
},
}
--@ unknown:-1:-1
end)()
_value__0 = table__73
--@ compiler/compile.luma:59:15
local fn__291 = function (...)
local param__360 = { n = select ("#", ...) - 0, select (1, ...) }
assert (param__360.n >= 0, "not enough arguments to function")
--@ compiler/compile.luma:59:15
local list_result__125
(function ()
local inputs__0, result__143
--@ compiler/compile.luma:61:18
local apply_result__998 = invoke (_array__0, 0 + param__360.n, unpack (param__360, 1, param__360.n))
inputs__0 = apply_result__998
--@ compiler/compile.luma:62:18
local apply_result__999 = invoke (_array__0, 0)
result__143 = apply_result__999
--@ compiler/compile.luma:63:24
local fn__292 = function (param__361)
--@ compiler/compile.luma:64:22
local apply_result__1000 = invoke_symbol (_array__0, ".?", 1, param__361)
local result__144
if apply_result__1000 then
--@ compiler/compile.luma:65:29
local apply_result__1001 = invoke_symbol (result__143, ".push-items", 1, param__361)
result__144 = apply_result__1001
else
--@ compiler/compile.luma:66:23
local apply_result__1002 = invoke_symbol (result__143, ".push", 1, param__361)
result__144 = apply_result__1002
end
return result__144
end
local apply_result__1003 = invoke_symbol (inputs__0, ".each", 1, fn__292)
--@ compiler/compile.luma:67:9
list_result__125 = result__143
--@ unknown:-1:-1
end)()
return list_result__125
end
seq__0 = fn__291
--@ compiler/compile.luma:69:24
local fn__293 = function (param__362)
--@ compiler/compile.luma:69:24
local list_result__126
(function ()
local out__3, iter__2
--@ compiler/compile.luma:70:15
local apply_result__1004 = invoke (_array__0, 0)
out__3 = apply_result__1004
--@ compiler/compile.luma:71:14
local apply_result__1005 = invoke_symbol (param__362, ".iterator", 0)
iter__2 = apply_result__1005
--@ compiler/compile.luma:72:7
local result__145
--@ compiler/compile.luma:72:17
local apply_result__1006 = invoke_symbol (iter__2, ".empty?", 0)
local apply_result__1007 = invoke (not__0, 1, apply_result__1006)
if apply_result__1007 then
--@ compiler/compile.luma:72:26
local list_result__127
(function ()
--@ compiler/compile.luma:73:18
local apply_result__1008 = invoke_symbol (iter__2, ".item", 0)
local apply_result__1009 = invoke_symbol (out__3, ".push", 1, apply_result__1008)
--@ compiler/compile.luma:74:9
local apply_result__1010 = invoke_symbol (iter__2, ".advance", 0)
list_result__127 = apply_result__1010
--@ unknown:-1:-1
end)()
result__145 = list_result__127
else
result__145 = false 
end
--@ compiler/compile.luma:75:22
local fn__294 = function (param__363)
--@ compiler/compile.luma:75:22
local list_result__128
(function ()
--@ compiler/compile.luma:76:18
local apply_result__1011 = invoke_symbol (out__3, ".push", 1, ", ")
--@ compiler/compile.luma:77:18
local apply_result__1012 = invoke_symbol (out__3, ".push", 1, param__363)
list_result__128 = apply_result__1012
--@ unknown:-1:-1
end)()
return list_result__128
end
local apply_result__1013 = invoke_symbol (iter__2, ".each", 1, fn__294)
--@ compiler/compile.luma:78:6
list_result__126 = out__3
--@ unknown:-1:-1
end)()
return list_result__126
end
comma_separate__0 = fn__293
--@ compiler/compile.luma:80:20
local fn__295 = function (param__364)
--@ compiler/compile.luma:81:19
local fn__296 = function (param__365)
--@ compiler/compile.luma:81:22
local apply_result__1014 = invoke_symbol (param__365, ".id", 0)
return apply_result__1014
end
local apply_result__1015 = invoke_symbol (param__364, ".map", 1, fn__296)
return apply_result__1015
end
words__ids__0 = fn__295
--@ compiler/compile.luma:83:25
local fn__297 = function (param__366)
--@ compiler/compile.luma:83:25
local list_result__129
(function ()
local last_arg__0
--@ compiler/compile.luma:84:19
local apply_result__1016 = invoke_symbol (param__366, ".params", 0)
local apply_result__1017 = invoke_symbol (apply_result__1016, ".length", 0)
--@ compiler/compile.luma:84:38
local apply_result__1018 = invoke_symbol (apply_result__1017, ".>", 1, 0)
local result__146 = apply_result__1018
if result__146 then
--@ compiler/compile.luma:84:41
local apply_result__1019 = invoke_symbol (param__366, ".params", 0)
local apply_result__1020 = invoke_symbol (apply_result__1019, ".last", 0)
result__146 = apply_result__1020
end
last_arg__0 = result__146
--@ compiler/compile.luma:85:15
local result__147 = last_arg__0
if result__147 then
--@ compiler/compile.luma:85:40
local apply_result__1021 = invoke_symbol (last_arg__0, ".contains?", 1, "..")
result__147 = apply_result__1021
end
list_result__129 = result__147
--@ unknown:-1:-1
end)()
return list_result__129
end
is_function_vararg___0 = fn__297
--@ compiler/compile.luma:87:41
local fn__298 = function (param__367)
--@ compiler/compile.luma:87:41
local list_result__130
(function ()
local signature__0, first__3, symbol__0, args__0
--@ compiler/compile.luma:88:17
local apply_result__1022 = invoke_symbol (param__367, ".key", 0)
signature__0 = apply_result__1022
--@ compiler/compile.luma:89:19
local apply_result__1023 = invoke_symbol (signature__0, ".items", 0)
--@ compiler/compile.luma:89:31
local apply_result__1024 = invoke_symbol (apply_result__1023, ".get", 1, 0)
first__3 = apply_result__1024
--@ compiler/compile.luma:90:20
local apply_result__1025 = invoke_symbol (signature__0, ".items", 0)
--@ compiler/compile.luma:90:32
local apply_result__1026 = invoke_symbol (apply_result__1025, ".get", 1, 1)
symbol__0 = apply_result__1026
--@ compiler/compile.luma:91:18
local apply_result__1027 = invoke_symbol (signature__0, ".items", 0)
--@ compiler/compile.luma:91:31
local apply_result__1028 = invoke_symbol (apply_result__1027, ".drop", 1, 2)
args__0 = apply_result__1028
--@ compiler/compile.luma:92:7
local result__148
--@ compiler/compile.luma:93:26
local apply_result__1029 = invoke_symbol (_symbol_node__0, ".?", 1, first__3)
if apply_result__1029 then
--@ compiler/compile.luma:93:28
local list_result__131
(function ()
--@ compiler/compile.luma:94:29
local apply_result__1030 = invoke_symbol (first__3, ".id", 0)
local apply_result__1031 = invoke (___4, 2, ".", apply_result__1030)
--@ compiler/compile.luma:94:96
local apply_result__1032 = invoke (assert_at__0, 3, apply_result__1031, first__3, "invalid symbol in first position of function signature")
--@ compiler/compile.luma:95:35
local apply_result__1033 = invoke_symbol (symbol__0, ".id", 0)
--@ compiler/compile.luma:95:55
local apply_result__1034 = words__ids__0 (args__0)
--@ compiler/compile.luma:95:60
local apply_result__1035 = invoke_symbol (param__367, ".value", 0)
--@ compiler/compile.luma:95:70
local apply_result__1036 = invoke_symbol (param__367, ".location", 0)
local apply_result__1037 = invoke (_symbol_function_node__0, 4, apply_result__1033, apply_result__1034, apply_result__1035, apply_result__1036)
list_result__131 = apply_result__1037
--@ unknown:-1:-1
end)()
result__148 = list_result__131
else
--@ compiler/compile.luma:96:9
if else__0 then
--@ compiler/compile.luma:96:10
local list_result__132
(function ()
--@ compiler/compile.luma:97:36
local apply_result__1038 = invoke_symbol (_word_node__0, ".?", 1, first__3)
--@ compiler/compile.luma:97:64
local apply_result__1039 = invoke (assert_at__0, 3, apply_result__1038, first__3, "expected word node")
--@ compiler/compile.luma:98:33
local apply_result__1040 = invoke_symbol (symbol__0, ".id", 0)
--@ compiler/compile.luma:98:77
local apply_result__1041 = invoke (_array__0, 1, first__3)
--@ compiler/compile.luma:98:83
local apply_result__1042 = invoke_symbol (_array__0, ".append", 2, apply_result__1041, args__0)
local apply_result__1043 = words__ids__0 (apply_result__1042)
--@ compiler/compile.luma:98:89
local apply_result__1044 = invoke_symbol (param__367, ".value", 0)
--@ compiler/compile.luma:98:99
local apply_result__1045 = invoke_symbol (param__367, ".location", 0)
local apply_result__1046 = invoke (_symbol_method_node__0, 4, apply_result__1040, apply_result__1043, apply_result__1044, apply_result__1045)
list_result__132 = apply_result__1046
--@ unknown:-1:-1
end)()
result__148 = list_result__132
else
result__148 = false 
end
end
list_result__130 = result__148
--@ unknown:-1:-1
end)()
return list_result__130
end
process_symbol_function_or_method__0 = fn__298
--@ compiler/compile.luma:100:30
local fn__299 = function (param__368)
--@ compiler/compile.luma:100:30
local list_result__133
(function ()
local signature__1, first__4, rest__1
--@ compiler/compile.luma:101:17
local apply_result__1047 = invoke_symbol (param__368, ".key", 0)
signature__1 = apply_result__1047
--@ compiler/compile.luma:102:19
local apply_result__1048 = invoke_symbol (signature__1, ".items", 0)
--@ compiler/compile.luma:102:31
local apply_result__1049 = invoke_symbol (apply_result__1048, ".get", 1, 0)
first__4 = apply_result__1049
--@ compiler/compile.luma:103:18
local apply_result__1050 = invoke_symbol (signature__1, ".items", 0)
--@ compiler/compile.luma:103:31
local apply_result__1051 = invoke_symbol (apply_result__1050, ".drop", 1, 1)
rest__1 = apply_result__1051
--@ compiler/compile.luma:104:7
local result__149
--@ compiler/compile.luma:105:24
local apply_result__1052 = invoke_symbol (_word_node__0, ".?", 1, first__4)
if apply_result__1052 then
--@ compiler/compile.luma:106:26
local apply_result__1053 = invoke_symbol (first__4, ".id", 0)
--@ compiler/compile.luma:107:40
local apply_result__1054 = words__ids__0 (rest__1)
--@ compiler/compile.luma:107:45
local apply_result__1055 = invoke_symbol (param__368, ".value", 0)
--@ compiler/compile.luma:107:55
local apply_result__1056 = invoke_symbol (param__368, ".location", 0)
local apply_result__1057 = invoke (_function_node__0, 3, apply_result__1054, apply_result__1055, apply_result__1056)
local apply_result__1058 = invoke (_binding_node__0, 2, apply_result__1053, apply_result__1057)
result__149 = apply_result__1058
else
--@ compiler/compile.luma:108:9
if else__0 then
--@ compiler/compile.luma:108:10
local list_result__134
(function ()
--@ compiler/compile.luma:109:43
local apply_result__1059 = invoke_symbol (_symbol_node__0, ".?", 1, first__4)
local result__150 = apply_result__1059
if result__150 then
--@ compiler/compile.luma:109:57
local apply_result__1060 = invoke_symbol (first__4, ".id", 0)
local apply_result__1061 = invoke (___4, 2, ".", apply_result__1060)
result__150 = apply_result__1061
end
--@ compiler/compile.luma:109:115
local apply_result__1062 = invoke (assert_at__0, 3, result__150, first__4, "function expects . or word in first position")
--@ compiler/compile.luma:110:38
local apply_result__1063 = words__ids__0 (rest__1)
--@ compiler/compile.luma:110:43
local apply_result__1064 = invoke_symbol (param__368, ".value", 0)
--@ compiler/compile.luma:110:53
local apply_result__1065 = invoke_symbol (param__368, ".location", 0)
local apply_result__1066 = invoke (_function_node__0, 3, apply_result__1063, apply_result__1064, apply_result__1065)
list_result__134 = apply_result__1066
--@ unknown:-1:-1
end)()
result__149 = list_result__134
else
result__149 = false 
end
end
list_result__133 = result__149
--@ unknown:-1:-1
end)()
return list_result__133
end
process_plain_function__0 = fn__299
--@ compiler/compile.luma:112:29
local fn__300 = function (param__369, param__370)
--@ compiler/compile.luma:113:7
local result__151
--@ compiler/compile.luma:114:23
local apply_result__1067 = invoke_symbol (param__369, ".key", 0)
local apply_result__1068 = invoke_symbol (_apply_node__0, ".?", 1, apply_result__1067)
if apply_result__1068 then
--@ compiler/compile.luma:114:29
local list_result__135
(function ()
local signature__2
--@ compiler/compile.luma:115:21
local apply_result__1069 = invoke_symbol (param__369, ".key", 0)
signature__2 = apply_result__1069
--@ compiler/compile.luma:117:11
local result__152
--@ compiler/compile.luma:118:30
local apply_result__1070 = invoke_symbol (signature__2, ".items", 0)
local apply_result__1071 = invoke_symbol (apply_result__1070, ".length", 0)
local apply_result__1072 = invoke_symbol (2, ".<=", 1, apply_result__1071)
local result__153 = apply_result__1072
if result__153 then
--@ compiler/compile.luma:118:71
local apply_result__1073 = invoke_symbol (signature__2, ".items", 0)
--@ compiler/compile.luma:118:83
local apply_result__1074 = invoke_symbol (apply_result__1073, ".get", 1, 1)
local apply_result__1075 = invoke_symbol (_symbol_node__0, ".?", 1, apply_result__1074)
result__153 = apply_result__1075
end
if result__153 then
--@ compiler/compile.luma:119:48
local apply_result__1076 = process_symbol_function_or_method__0 (param__369)
result__152 = apply_result__1076
else
--@ compiler/compile.luma:120:13
if else__0 then
--@ compiler/compile.luma:121:37
local apply_result__1077 = process_plain_function__0 (param__369)
result__152 = apply_result__1077
else
result__152 = false 
end
end
list_result__135 = result__152
--@ unknown:-1:-1
end)()
result__151 = list_result__135
else
--@ compiler/compile.luma:122:24
local apply_result__1078 = invoke_symbol (param__369, ".key", 0)
local apply_result__1079 = invoke_symbol (_symbol_node__0, ".?", 1, apply_result__1078)
if apply_result__1079 then
--@ compiler/compile.luma:123:22
local apply_result__1080 = invoke_symbol (param__369, ".key", 0)
local apply_result__1081 = invoke_symbol (apply_result__1080, ".id", 0)
--@ compiler/compile.luma:123:33
local apply_result__1082 = invoke_symbol (param__369, ".value", 0)
--@ compiler/compile.luma:123:43
local apply_result__1083 = invoke_symbol (param__369, ".location", 0)
local apply_result__1084 = invoke (_field_node__0, 3, apply_result__1081, apply_result__1082, apply_result__1083)
result__151 = apply_result__1084
else
--@ compiler/compile.luma:124:9
if else__0 then
--@ compiler/compile.luma:124:10
local list_result__136
(function ()
--@ compiler/compile.luma:125:34
local apply_result__1085 = invoke_symbol (param__369, ".key", 0)
local apply_result__1086 = invoke_symbol (_word_node__0, ".?", 1, apply_result__1085)
--@ compiler/compile.luma:125:43
local apply_result__1087 = invoke_symbol (param__369, ".key", 0)
--@ compiler/compile.luma:125:69
local apply_result__1088 = invoke (assert_at__0, 3, apply_result__1086, apply_result__1087, "unknown key in pair")
--@ compiler/compile.luma:126:24
local apply_result__1089 = invoke_symbol (param__369, ".key", 0)
local apply_result__1090 = invoke_symbol (apply_result__1089, ".id", 0)
--@ compiler/compile.luma:126:35
local apply_result__1091 = invoke_symbol (param__369, ".value", 0)
--@ compiler/compile.luma:126:45
local apply_result__1092 = invoke_symbol (param__369, ".location", 0)
local apply_result__1093 = invoke (_binding_node__0, 3, apply_result__1090, apply_result__1091, apply_result__1092)
list_result__136 = apply_result__1093
--@ unknown:-1:-1
end)()
result__151 = list_result__136
else
result__151 = false 
end
end
end
return result__151
end
process_pair__0 = fn__300
--@ compiler/compile.luma:128:31
local fn__301 = function (param__371, param__372)
--@ compiler/compile.luma:129:20
local fn__302 = function (param__373)
--@ compiler/compile.luma:130:25
local apply_result__1094 = invoke_symbol (_pair_node__0, ".?", 1, param__373)
local result__154
if apply_result__1094 then
--@ compiler/compile.luma:131:32
local apply_result__1095 = process_pair__0 (param__373, param__372)
result__154 = apply_result__1095
else
--@ compiler/compile.luma:132:10
result__154 = param__373
end
return result__154
end
local apply_result__1096 = invoke_symbol (param__371, ".map", 1, fn__302)
return apply_result__1096
end
process_pairs__0 = fn__301
--@ compiler/compile.luma:134:15
local fn__303 = function (param__374)
--@ compiler/compile.luma:134:15
local list_result__137
(function ()
local buffer__0, location_to_emit__0, gensym_counts__0, gensym__0, set_location_info__0, emit__1, compile_number__0, compile_string__0, compile_word__0, compile_args__0, prepare_args__0, find_method__0, compile_apply__0, compile_list__0, compile_function__0, compile_table__0, compile_pair__0, compile_exp__0, base_context__0
--@ compiler/compile.luma:135:18
local apply_result__1097 = invoke (_array__0, 0)
buffer__0 = apply_result__1097
--@ compiler/compile.luma:136:26
location_to_emit__0 = false
--@ compiler/compile.luma:137:24
local apply_result__1098 = invoke (_hash__0, 0)
gensym_counts__0 = apply_result__1098
--@ compiler/compile.luma:139:17
local fn__304 = function (param__375)
--@ compiler/compile.luma:139:17
local list_result__138
(function ()
local safe_name__0, count__0, id__0
--@ compiler/compile.luma:140:37
local apply_result__1099 = invoke (safe_identifier__0, 1, param__375)
safe_name__0 = apply_result__1099
--@ compiler/compile.luma:141:44
local apply_result__1100 = invoke_symbol (gensym_counts__0, ".get-or", 2, safe_name__0, 0)
count__0 = apply_result__1100
--@ compiler/compile.luma:142:45
local apply_result__1101 = invoke_symbol (count__0, ".to-string", 0)
local apply_result__1102 = invoke (combine_strings__0, 3, safe_name__0, "__", apply_result__1101)
id__0 = apply_result__1102
--@ compiler/compile.luma:143:44
local apply_result__1103 = invoke_symbol (count__0, ".+", 1, 1)
local apply_result__1104 = invoke_symbol (gensym_counts__0, ".set", 2, safe_name__0, apply_result__1103)
--@ compiler/compile.luma:144:14
local apply_result__1105 = _value__0.functions[1] (id__0)
list_result__138 = apply_result__1105
--@ unknown:-1:-1
end)()
return list_result__138
end
gensym__0 = fn__304
--@ compiler/compile.luma:147:32
local fn__305 = function (param__376)
--@ compiler/compile.luma:148:9
local result__155
--@ compiler/compile.luma:148:25
if emit_debug_info__0 then
--@ compiler/compile.luma:149:36
location_to_emit__0 = param__376
result__155 = true
else
result__155 = false 
end
return result__155
end
set_location_info__0 = fn__305
--@ compiler/compile.luma:151:10
local table__75
(function ()
local fn__306 = function ()
--@ compiler/compile.luma:152:14
return true
end
local fn__307 = function (...)
local param__377 = ...
local param__378 = { n = select ("#", ...) - 1, select (2, ...) }
assert (param__378.n >= 0, "not enough arguments to function")
--@ compiler/compile.luma:153:22
local list_result__139
(function ()
--@ compiler/compile.luma:154:11
local result__156
--@ compiler/compile.luma:154:28
if location_to_emit__0 then
--@ compiler/compile.luma:154:29
local list_result__140
(function ()
--@ compiler/compile.luma:155:61
local apply_result__1106 = invoke_symbol (location_to_emit__0, ".to-string", 0)
--@ compiler/compile.luma:155:76
local apply_result__1107 = invoke (combine_strings__0, 3, "--@ ", apply_result__1106, "\
")
local apply_result__1108 = invoke_symbol (buffer__0, ".push", 1, apply_result__1107)
--@ compiler/compile.luma:156:35
location_to_emit__0 = false
list_result__140 = true
--@ unknown:-1:-1
end)()
result__156 = list_result__140
else
result__156 = false 
end
--@ compiler/compile.luma:157:11
local result__157
--@ compiler/compile.luma:158:24
local apply_result__1109 = invoke_symbol (_string__0, ".?", 1, param__377)
if apply_result__1109 then
--@ compiler/compile.luma:159:27
local apply_result__1110 = invoke_symbol (buffer__0, ".push", 1, param__377)
result__157 = apply_result__1110
else
--@ compiler/compile.luma:160:23
local apply_result__1111 = _value__0.functions[".?"] (param__377)
if apply_result__1111 then
--@ compiler/compile.luma:161:20
local apply_result__1112 = invoke_symbol (param__377, ".id", 0)
local apply_result__1113 = invoke (emit__1, 1, apply_result__1112)
result__157 = apply_result__1113
else
--@ compiler/compile.luma:162:13
if else__0 then
--@ compiler/compile.luma:163:15
local apply_result__1114 = invoke_symbol (param__377, ".iterator", 0)
--@ compiler/compile.luma:163:36
local fn__308 = function (param__379)
--@ compiler/compile.luma:163:44
local apply_result__1115 = invoke (emit__1, 1, param__379)
return apply_result__1115
end
local apply_result__1116 = invoke_symbol (apply_result__1114, ".each", 1, fn__308)
result__157 = apply_result__1116
else
result__157 = false 
end
end
end
--@ compiler/compile.luma:166:11
local apply_result__1117 = invoke (emit__1, 0 + param__378.n, unpack (param__378, 1, param__378.n))
list_result__139 = apply_result__1117
--@ unknown:-1:-1
end)()
return list_result__139
end
table__75 = {
functions = {
[0] = fn__306,
[".."] = fn__307,
},
}
--@ unknown:-1:-1
end)()
emit__1 = table__75
--@ compiler/compile.luma:168:32
local fn__309 = function (param__380, param__381)
--@ compiler/compile.luma:169:15
local apply_result__1118 = invoke_symbol (param__380, ".value", 0)
local apply_result__1119 = invoke_symbol (apply_result__1118, ".to-string", 0)
local apply_result__1120 = _value__0.functions[1] (apply_result__1119)
return apply_result__1120
end
compile_number__0 = fn__309
--@ compiler/compile.luma:171:32
local fn__310 = function (param__382, param__383)
--@ compiler/compile.luma:172:29
local apply_result__1121 = invoke_symbol (param__382, ".value", 0)
local apply_result__1122 = invoke (quote_string__0, 1, apply_result__1121)
local apply_result__1123 = _value__0.functions[1] (apply_result__1122)
return apply_result__1123
end
compile_string__0 = fn__310
--@ compiler/compile.luma:174:30
local fn__311 = function (param__384, param__385)
--@ compiler/compile.luma:175:23
local apply_result__1124 = invoke_symbol (param__384, ".id", 0)
--@ compiler/compile.luma:175:30
local apply_result__1125 = invoke_symbol (param__384, ".location", 0)
local apply_result__1126 = invoke_symbol (param__385, ".lookup", 2, apply_result__1124, apply_result__1125)
return apply_result__1126
end
compile_word__0 = fn__311
--@ compiler/compile.luma:177:31
local fn__312 = function (param__386, param__387)
--@ compiler/compile.luma:178:22
local fn__313 = function (param__388)
--@ compiler/compile.luma:179:30
local apply_result__1127 = invoke (compile_exp__0, 2, param__388, param__387)
return apply_result__1127
end
local apply_result__1128 = invoke_symbol (param__386, ".map", 1, fn__313)
return apply_result__1128
end
compile_args__0 = fn__312
--@ compiler/compile.luma:181:31
local fn__314 = function (param__389, param__390)
--@ compiler/compile.luma:182:9
local result__158
--@ compiler/compile.luma:183:12
local apply_result__1129 = invoke_symbol (param__389, ".length", 0)
--@ compiler/compile.luma:183:24
local apply_result__1130 = invoke_symbol (apply_result__1129, ".=", 1, 0)
if apply_result__1130 then
--@ compiler/compile.luma:184:10
local table__76
(function ()
--@ compiler/compile.luma:187:22
table__76 = {
[".n"] = "0",
[".static-n"] = 0,
[".args"] = param__389,
}
--@ unknown:-1:-1
end)()
result__158 = table__76
else
--@ compiler/compile.luma:188:11
if else__0 then
--@ compiler/compile.luma:188:12
local list_result__141
(function ()
local last_arg__1
--@ compiler/compile.luma:189:23
local apply_result__1131 = invoke_symbol (param__389, ".last", 0)
last_arg__1 = apply_result__1131
--@ compiler/compile.luma:190:13
local result__159
--@ compiler/compile.luma:191:35
local apply_result__1132 = invoke_symbol (_vararg_node__0, ".?", 1, last_arg__1)
if apply_result__1132 then
--@ compiler/compile.luma:191:37
local list_result__142
(function ()
local vararg__0, list_without_vararg__0, n__0, arg_strings__0
--@ compiler/compile.luma:192:45
local apply_result__1133 = invoke_symbol (last_arg__1, ".id", 0)
--@ compiler/compile.luma:192:57
local apply_result__1134 = invoke_symbol (last_arg__1, ".location", 0)
local apply_result__1135 = invoke_symbol (param__390, ".lookup", 2, apply_result__1133, apply_result__1134)
vararg__0 = apply_result__1135
--@ compiler/compile.luma:193:50
local apply_result__1136 = invoke_symbol (param__389, ".drop-last", 1, 1)
list_without_vararg__0 = apply_result__1136
--@ compiler/compile.luma:194:51
local apply_result__1137 = invoke_symbol (list_without_vararg__0, ".length", 0)
local apply_result__1138 = invoke_symbol (apply_result__1137, ".to-string", 0)
--@ compiler/compile.luma:194:81
local apply_result__1139 = invoke_symbol (vararg__0, ".id", 0)
--@ compiler/compile.luma:194:89
local apply_result__1140 = invoke (combine_strings__0, 4, apply_result__1138, " + ", apply_result__1139, ".n")
n__0 = apply_result__1140
--@ compiler/compile.luma:195:71
local apply_result__1141 = invoke_symbol (param__389, ".drop-last", 1, 1)
--@ compiler/compile.luma:195:80
local apply_result__1142 = compile_args__0 (apply_result__1141, param__390)
--@ compiler/compile.luma:196:82
local apply_result__1143 = invoke_symbol (vararg__0, ".id", 0)
--@ compiler/compile.luma:196:100
local apply_result__1144 = invoke_symbol (vararg__0, ".id", 0)
--@ compiler/compile.luma:196:109
local apply_result__1145 = invoke (combine_strings__0, 5, "unpack (", apply_result__1143, ", 1, ", apply_result__1144, ".n)")
local apply_result__1146 = invoke (_array__0, 1, apply_result__1145)
local apply_result__1147 = invoke_symbol (_array__0, ".append", 2, apply_result__1142, apply_result__1146)
arg_strings__0 = apply_result__1147
--@ compiler/compile.luma:197:14
local table__77
(function ()
--@ compiler/compile.luma:200:33
table__77 = {
[".n"] = n__0,
[".static-n"] = false,
[".args"] = arg_strings__0,
}
--@ unknown:-1:-1
end)()
list_result__142 = table__77
--@ unknown:-1:-1
end)()
result__159 = list_result__142
else
--@ compiler/compile.luma:201:15
if else__0 then
--@ compiler/compile.luma:202:14
local table__78
(function ()
--@ compiler/compile.luma:203:23
local apply_result__1148 = invoke_symbol (param__389, ".length", 0)
local apply_result__1149 = invoke_symbol (apply_result__1148, ".to-string", 0)
--@ compiler/compile.luma:204:30
local apply_result__1150 = invoke_symbol (param__389, ".length", 0)
--@ compiler/compile.luma:205:47
local apply_result__1151 = compile_args__0 (param__389, param__390)
table__78 = {
[".n"] = apply_result__1149,
[".static-n"] = apply_result__1150,
[".args"] = apply_result__1151,
}
--@ unknown:-1:-1
end)()
result__159 = table__78
else
result__159 = false 
end
end
list_result__141 = result__159
--@ unknown:-1:-1
end)()
result__158 = list_result__141
else
result__158 = false 
end
end
return result__158
end
prepare_args__0 = fn__314
--@ compiler/compile.luma:207:33
local fn__315 = function (param__391, param__392)
--@ compiler/compile.luma:207:33
local list_result__143
(function ()
local index_type__0
--@ compiler/compile.luma:209:21
local apply_result__1152 = invoke_symbol (param__391, ".index", 0)
index_type__0 = apply_result__1152
--@ compiler/compile.luma:210:9
local result__160
--@ compiler/compile.luma:211:22
local result__161 = index_type__0
if result__161 then
--@ compiler/compile.luma:211:34
local apply_result__1153 = invoke_symbol (index_type__0, ".methods", 0)
--@ compiler/compile.luma:211:58
local apply_result__1154 = invoke_symbol (apply_result__1153, ".has?", 1, param__392)
result__161 = apply_result__1154
end
if result__161 then
--@ compiler/compile.luma:212:10
local table__79
(function ()
--@ compiler/compile.luma:213:65
local apply_result__1155 = invoke (quote_string__0, 1, param__392)
--@ compiler/compile.luma:213:70
local apply_result__1156 = seq__0 (".index.methods [", apply_result__1155, "]")
--@ compiler/compile.luma:214:29
local apply_result__1157 = invoke_symbol (index_type__0, ".methods", 0)
--@ compiler/compile.luma:214:52
local apply_result__1158 = invoke_symbol (apply_result__1157, ".get", 1, param__392)
table__79 = {
[".path"] = apply_result__1156,
[".type"] = apply_result__1158,
}
--@ unknown:-1:-1
end)()
result__160 = table__79
else
--@ compiler/compile.luma:215:17
if index_type__0 then
--@ compiler/compile.luma:215:18
local list_result__144
(function ()
local found__0
--@ compiler/compile.luma:216:49
local apply_result__1159 = invoke (find_method__0, 2, index_type__0, param__392)
found__0 = apply_result__1159
--@ compiler/compile.luma:217:18
local result__162 = found__0
if result__162 then
--@ compiler/compile.luma:218:12
local table__80
(function ()
--@ compiler/compile.luma:219:38
local apply_result__1160 = invoke_symbol (found__0, ".path", 0)
local apply_result__1161 = seq__0 (".index", apply_result__1160)
--@ compiler/compile.luma:220:25
local apply_result__1162 = invoke_symbol (found__0, ".type", 0)
table__80 = {
[".path"] = apply_result__1161,
[".type"] = apply_result__1162,
}
--@ unknown:-1:-1
end)()
result__162 = table__80
end
list_result__144 = result__162
--@ unknown:-1:-1
end)()
result__160 = list_result__144
else
--@ compiler/compile.luma:221:11
if else__0 then
--@ compiler/compile.luma:222:14
result__160 = false
else
result__160 = false 
end
end
end
list_result__143 = result__160
--@ unknown:-1:-1
end)()
return list_result__143
end
find_method__0 = fn__315
--@ compiler/compile.luma:224:31
local fn__316 = function (param__393, param__394)
--@ compiler/compile.luma:224:31
local list_result__145
(function ()
local fn__317, args__1, fn_val__0
--@ compiler/compile.luma:225:12
local apply_result__1163 = invoke_symbol (param__393, ".items", 0)
--@ compiler/compile.luma:225:24
local apply_result__1164 = invoke_symbol (apply_result__1163, ".get", 1, 0)
fn__317 = apply_result__1164
--@ compiler/compile.luma:226:14
local apply_result__1165 = invoke_symbol (param__393, ".items", 0)
--@ compiler/compile.luma:226:27
local apply_result__1166 = invoke_symbol (apply_result__1165, ".drop", 1, 1)
args__1 = apply_result__1166
--@ compiler/compile.luma:229:35
local apply_result__1167 = invoke (compile_exp__0, 2, fn__317, param__394)
fn_val__0 = apply_result__1167
--@ compiler/compile.luma:231:9
local result__163
--@ compiler/compile.luma:232:32
local apply_result__1168 = invoke_symbol (_primitive_node__0, ".?", 1, fn_val__0)
if apply_result__1168 then
--@ compiler/compile.luma:233:16
local apply_result__1169 = invoke_symbol (fn_val__0, ".fn", 0)
--@ compiler/compile.luma:233:32
local apply_result__1170 = invoke (apply_result__1169, 2, param__393, param__394)
result__163 = apply_result__1170
else
--@ compiler/compile.luma:235:17
local apply_result__1171 = invoke_symbol (args__1, ".length", 0)
--@ compiler/compile.luma:235:29
local apply_result__1172 = invoke_symbol (apply_result__1171, ".>", 1, 0)
local result__164 = apply_result__1172
if result__164 then
--@ compiler/compile.luma:235:58
local apply_result__1173 = invoke_symbol (args__1, ".get", 1, 0)
local apply_result__1174 = invoke_symbol (_symbol_node__0, ".?", 1, apply_result__1173)
result__164 = apply_result__1174
end
if result__164 then
--@ compiler/compile.luma:235:62
local list_result__146
(function ()
local symbol_id__0, quoted_symbol__0, compiled_args__0, result_id__0
--@ compiler/compile.luma:236:31
local apply_result__1175 = invoke_symbol (args__1, ".get", 1, 0)
local apply_result__1176 = invoke_symbol (apply_result__1175, ".id", 0)
symbol_id__0 = apply_result__1176
--@ compiler/compile.luma:237:46
local apply_result__1177 = invoke (quote_string__0, 1, symbol_id__0)
quoted_symbol__0 = apply_result__1177
--@ compiler/compile.luma:239:49
local apply_result__1178 = invoke_symbol (args__1, ".drop", 1, 1)
--@ compiler/compile.luma:239:58
local apply_result__1179 = prepare_args__0 (apply_result__1178, param__394)
compiled_args__0 = apply_result__1179
--@ compiler/compile.luma:241:41
local apply_result__1180 = gensym__0 ("apply_result")
result_id__0 = apply_result__1180
--@ compiler/compile.luma:242:38
local apply_result__1181 = emit__1.functions[".."] ("local ", result_id__0, " = ")
--@ compiler/compile.luma:243:13
local result__165
--@ compiler/compile.luma:244:18
local apply_result__1182 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1183 = invoke_symbol (apply_result__1182, ".fields", 0)
--@ compiler/compile.luma:244:45
local apply_result__1184 = invoke_symbol (apply_result__1183, ".has?", 1, symbol_id__0)
if apply_result__1184 then
--@ compiler/compile.luma:245:17
local result__166
--@ compiler/compile.luma:246:35
local apply_result__1185 = invoke_symbol (compiled_args__0, ".static-n", 0)
local op_result__21 = 0 == apply_result__1185
if op_result__21 then
--@ compiler/compile.luma:247:52
local apply_result__1186 = emit__1.functions[".."] (fn_val__0, "[", quoted_symbol__0, "]\
")
result__166 = apply_result__1186
else
--@ compiler/compile.luma:248:19
if else__0 then
--@ compiler/compile.luma:248:20
local list_result__147
(function ()
local field__0
--@ compiler/compile.luma:250:39
local apply_result__1187 = emit__1.functions[".."] ("invoke_symbol (")
--@ compiler/compile.luma:251:46
local apply_result__1188 = invoke_symbol (fn_val__0, ".id", 0)
--@ compiler/compile.luma:251:71
local apply_result__1189 = invoke (combine_strings__0, 4, apply_result__1188, "[", quoted_symbol__0, "]")
field__0 = apply_result__1189
--@ compiler/compile.luma:252:62
local apply_result__1190 = invoke_symbol (compiled_args__0, ".n", 0)
--@ compiler/compile.luma:252:78
local apply_result__1191 = invoke_symbol (compiled_args__0, ".args", 0)
local apply_result__1192 = seq__0 (field__0, apply_result__1190, apply_result__1191)
local apply_result__1193 = comma_separate__0 (apply_result__1192)
local apply_result__1194 = emit__1.functions[".."] (apply_result__1193)
--@ compiler/compile.luma:253:27
local apply_result__1195 = emit__1.functions[".."] (")\
")
list_result__147 = apply_result__1195
--@ unknown:-1:-1
end)()
result__166 = list_result__147
else
result__166 = false 
end
end
result__165 = result__166
else
--@ compiler/compile.luma:255:18
local apply_result__1196 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1197 = invoke_symbol (apply_result__1196, ".functions", 0)
--@ compiler/compile.luma:255:48
local apply_result__1198 = invoke_symbol (apply_result__1197, ".has?", 1, symbol_id__0)
if apply_result__1198 then
--@ compiler/compile.luma:255:50
local list_result__148
(function ()
--@ compiler/compile.luma:256:88
local apply_result__1199 = invoke_symbol (compiled_args__0, ".args", 0)
local apply_result__1200 = comma_separate__0 (apply_result__1199)
--@ compiler/compile.luma:256:100
local apply_result__1201 = emit__1.functions[".."] (fn_val__0, ".functions[", quoted_symbol__0, "] (", apply_result__1200, ")\
")
--@ compiler/compile.luma:257:39
local apply_result__1202 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1203 = invoke_symbol (apply_result__1202, ".functions", 0)
--@ compiler/compile.luma:257:68
local apply_result__1204 = invoke_symbol (apply_result__1203, ".get", 1, symbol_id__0)
--@ compiler/compile.luma:257:26
result_id__0 [".type"] = apply_result__1204
list_result__148 = true
--@ unknown:-1:-1
end)()
result__165 = list_result__148
else
--@ compiler/compile.luma:258:15
if else__0 then
--@ compiler/compile.luma:258:16
local list_result__149
(function ()
local found_method__0
--@ compiler/compile.luma:259:45
local apply_result__1205 = invoke_symbol (fn_val__0, ".type", 0)
--@ compiler/compile.luma:259:60
local apply_result__1206 = find_method__0 (apply_result__1205, symbol_id__0)
found_method__0 = apply_result__1206
--@ compiler/compile.luma:260:17
local result__167
--@ compiler/compile.luma:261:27
if found_method__0 then
--@ compiler/compile.luma:261:28
local list_result__150
(function ()
--@ compiler/compile.luma:262:41
local apply_result__1207 = invoke_symbol (found_method__0, ".path", 0)
--@ compiler/compile.luma:262:80
local apply_result__1208 = invoke_symbol (compiled_args__0, ".args", 0)
local apply_result__1209 = comma_separate__0 (apply_result__1208)
--@ compiler/compile.luma:262:92
local apply_result__1210 = emit__1.functions[".."] (fn_val__0, apply_result__1207, "(", apply_result__1209, ")\
")
--@ compiler/compile.luma:263:48
local apply_result__1211 = invoke_symbol (found_method__0, ".type", 0)
--@ compiler/compile.luma:263:30
result_id__0 [".type"] = apply_result__1211
list_result__150 = true
--@ unknown:-1:-1
end)()
result__167 = list_result__150
else
--@ compiler/compile.luma:264:19
if else__0 then
--@ compiler/compile.luma:264:20
local list_result__151
(function ()
--@ compiler/compile.luma:265:39
local apply_result__1212 = emit__1.functions[".."] ("invoke_symbol (")
--@ compiler/compile.luma:266:77
local apply_result__1213 = invoke_symbol (compiled_args__0, ".n", 0)
--@ compiler/compile.luma:266:93
local apply_result__1214 = invoke_symbol (compiled_args__0, ".args", 0)
local apply_result__1215 = seq__0 (fn_val__0, quoted_symbol__0, apply_result__1213, apply_result__1214)
local apply_result__1216 = comma_separate__0 (apply_result__1215)
local apply_result__1217 = emit__1.functions[".."] (apply_result__1216)
--@ compiler/compile.luma:267:27
local apply_result__1218 = emit__1.functions[".."] (")\
")
list_result__151 = apply_result__1218
--@ unknown:-1:-1
end)()
result__167 = list_result__151
else
result__167 = false 
end
end
list_result__149 = result__167
--@ unknown:-1:-1
end)()
result__165 = list_result__149
else
result__165 = false 
end
end
end
--@ compiler/compile.luma:269:18
list_result__146 = result_id__0
--@ unknown:-1:-1
end)()
result__163 = list_result__146
else
--@ compiler/compile.luma:271:11
if else__0 then
--@ compiler/compile.luma:271:12
local list_result__152
(function ()
local compiled_args__1, result_id__1
--@ compiler/compile.luma:273:49
local apply_result__1219 = prepare_args__0 (args__1, param__394)
compiled_args__1 = apply_result__1219
--@ compiler/compile.luma:275:41
local apply_result__1220 = gensym__0 ("apply_result")
result_id__1 = apply_result__1220
--@ compiler/compile.luma:276:38
local apply_result__1221 = emit__1.functions[".."] ("local ", result_id__1, " = ")
--@ compiler/compile.luma:277:13
local result__168
--@ compiler/compile.luma:278:17
local apply_result__1222 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1223 = invoke_symbol (apply_result__1222, ".call", 0)
if apply_result__1223 then
--@ compiler/compile.luma:278:28
local list_result__153
(function ()
--@ compiler/compile.luma:279:59
local apply_result__1224 = invoke_symbol (compiled_args__1, ".args", 0)
local apply_result__1225 = comma_separate__0 (apply_result__1224)
--@ compiler/compile.luma:279:71
local apply_result__1226 = emit__1.functions[".."] (fn_val__0, " (", apply_result__1225, ")\
")
--@ compiler/compile.luma:280:38
local apply_result__1227 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1228 = invoke_symbol (apply_result__1227, ".call", 0)
--@ compiler/compile.luma:280:26
result_id__1 [".type"] = apply_result__1228
list_result__153 = true
--@ unknown:-1:-1
end)()
result__168 = list_result__153
else
--@ compiler/compile.luma:281:18
local apply_result__1229 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1230 = invoke_symbol (apply_result__1229, ".functions", 0)
--@ compiler/compile.luma:281:52
local apply_result__1231 = invoke_symbol (compiled_args__1, ".static-n", 0)
local apply_result__1232 = invoke_symbol (apply_result__1230, ".has?", 1, apply_result__1231)
if apply_result__1232 then
--@ compiler/compile.luma:281:63
local list_result__154
(function ()
--@ compiler/compile.luma:282:52
local apply_result__1233 = invoke_symbol (compiled_args__1, ".n", 0)
--@ compiler/compile.luma:282:90
local apply_result__1234 = invoke_symbol (compiled_args__1, ".args", 0)
local apply_result__1235 = comma_separate__0 (apply_result__1234)
--@ compiler/compile.luma:282:102
local apply_result__1236 = emit__1.functions[".."] (fn_val__0, ".functions[", apply_result__1233, "] (", apply_result__1235, ")\
")
--@ compiler/compile.luma:283:39
local apply_result__1237 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1238 = invoke_symbol (apply_result__1237, ".functions", 0)
--@ compiler/compile.luma:283:72
local apply_result__1239 = invoke_symbol (compiled_args__1, ".static-n", 0)
local apply_result__1240 = invoke_symbol (apply_result__1238, ".get", 1, apply_result__1239)
--@ compiler/compile.luma:283:26
result_id__1 [".type"] = apply_result__1240
list_result__154 = true
--@ unknown:-1:-1
end)()
result__168 = list_result__154
else
--@ compiler/compile.luma:284:18
local apply_result__1241 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1242 = invoke_symbol (apply_result__1241, ".functions", 0)
--@ compiler/compile.luma:284:43
local apply_result__1243 = invoke_symbol (apply_result__1242, ".has?", 1, "..")
if apply_result__1243 then
--@ compiler/compile.luma:284:45
local list_result__155
(function ()
--@ compiler/compile.luma:285:75
local apply_result__1244 = invoke_symbol (compiled_args__1, ".args", 0)
local apply_result__1245 = comma_separate__0 (apply_result__1244)
--@ compiler/compile.luma:285:87
local apply_result__1246 = emit__1.functions[".."] (fn_val__0, ".functions[\"..\"] (", apply_result__1245, ")\
")
--@ compiler/compile.luma:286:39
local apply_result__1247 = invoke_symbol (fn_val__0, ".type", 0)
local apply_result__1248 = invoke_symbol (apply_result__1247, ".functions", 0)
--@ compiler/compile.luma:286:63
local apply_result__1249 = invoke_symbol (apply_result__1248, ".get", 1, "..")
--@ compiler/compile.luma:286:26
result_id__1 [".type"] = apply_result__1249
list_result__155 = true
--@ unknown:-1:-1
end)()
result__168 = list_result__155
else
--@ compiler/compile.luma:287:15
if else__0 then
--@ compiler/compile.luma:287:16
local list_result__156
(function ()
--@ compiler/compile.luma:288:28
local apply_result__1250 = emit__1.functions[".."] ("invoke (")
--@ compiler/compile.luma:289:59
local apply_result__1251 = invoke_symbol (compiled_args__1, ".n", 0)
--@ compiler/compile.luma:289:75
local apply_result__1252 = invoke_symbol (compiled_args__1, ".args", 0)
local apply_result__1253 = seq__0 (fn_val__0, apply_result__1251, apply_result__1252)
local apply_result__1254 = comma_separate__0 (apply_result__1253)
local apply_result__1255 = emit__1.functions[".."] (apply_result__1254)
--@ compiler/compile.luma:290:23
local apply_result__1256 = emit__1.functions[".."] (")\
")
list_result__156 = apply_result__1256
--@ unknown:-1:-1
end)()
result__168 = list_result__156
else
result__168 = false 
end
end
end
end
--@ compiler/compile.luma:292:18
list_result__152 = result_id__1
--@ unknown:-1:-1
end)()
result__163 = list_result__152
else
result__163 = false 
end
end
end
list_result__145 = result__163
--@ unknown:-1:-1
end)()
return list_result__145
end
compile_apply__0 = fn__316
--@ compiler/compile.luma:294:30
local fn__318 = function (param__395, param__396)
--@ compiler/compile.luma:294:30
local list_result__157
(function ()
local new_context__0, result_id__2, processed_items__0, locals__0
--@ compiler/compile.luma:295:34
local apply_result__1257 = invoke (_context__0, 1, param__396)
new_context__0 = apply_result__1257
--@ compiler/compile.luma:296:36
local apply_result__1258 = gensym__0 ("list_result")
result_id__2 = apply_result__1258
--@ compiler/compile.luma:299:39
local apply_result__1259 = invoke_symbol (param__395, ".items", 0)
--@ compiler/compile.luma:299:51
local apply_result__1260 = process_pairs__0 (apply_result__1259, false)
processed_items__0 = apply_result__1260
--@ compiler/compile.luma:302:33
local apply_result__1261 = emit__1.functions[".."] ("local ", result_id__2, "\
")
--@ compiler/compile.luma:303:26
local apply_result__1262 = emit__1.functions[".."] ("(function ()\
")
--@ compiler/compile.luma:306:19
local apply_result__1263 = invoke (_list__0, 0)
locals__0 = apply_result__1263
--@ compiler/compile.luma:307:35
local fn__319 = function (param__397)
--@ compiler/compile.luma:308:11
local result__169
--@ compiler/compile.luma:308:33
local apply_result__1264 = invoke_symbol (_binding_node__0, ".?", 1, param__397)
if apply_result__1264 then
--@ compiler/compile.luma:308:35
local list_result__158
(function ()
local id__1
--@ compiler/compile.luma:309:25
local apply_result__1265 = invoke_symbol (param__397, ".id", 0)
local apply_result__1266 = gensym__0 (apply_result__1265)
id__1 = apply_result__1266
--@ compiler/compile.luma:310:50
local apply_result__1267 = invoke (_list__0, 1, id__1)
local apply_result__1268 = invoke_symbol (_list__0, ".append", 2, locals__0, apply_result__1267)
locals__0 = apply_result__1268
--@ compiler/compile.luma:311:29
local apply_result__1269 = invoke_symbol (param__397, ".id", 0)
--@ compiler/compile.luma:311:35
local apply_result__1270 = invoke_symbol (new_context__0, ".add", 2, apply_result__1269, id__1)
list_result__158 = apply_result__1270
--@ unknown:-1:-1
end)()
result__169 = list_result__158
else
result__169 = false 
end
return result__169
end
local apply_result__1271 = invoke_symbol (processed_items__0, ".each", 1, fn__319)
--@ compiler/compile.luma:312:9
local result__170
--@ compiler/compile.luma:312:21
local apply_result__1272 = invoke_symbol (locals__0, ".empty?", 0)
local apply_result__1273 = invoke (not__0, 1, apply_result__1272)
if apply_result__1273 then
--@ compiler/compile.luma:313:43
local apply_result__1274 = comma_separate__0 (locals__0)
--@ compiler/compile.luma:313:49
local apply_result__1275 = emit__1.functions[".."] ("local ", apply_result__1274, "\
")
result__170 = apply_result__1275
else
result__170 = false 
end
--@ compiler/compile.luma:316:9
local result__171
--@ compiler/compile.luma:316:26
local apply_result__1276 = invoke_symbol (processed_items__0, ".length", 0)
--@ compiler/compile.luma:316:38
local apply_result__1277 = invoke_symbol (apply_result__1276, ".>", 1, 0)
if apply_result__1277 then
--@ compiler/compile.luma:316:40
local list_result__159
(function ()
local last_item__0, compiled_value__0
--@ compiler/compile.luma:317:35
local apply_result__1278 = invoke_symbol (processed_items__0, ".drop-last", 1, 1)
--@ compiler/compile.luma:317:51
local fn__320 = function (param__398)
--@ compiler/compile.luma:318:13
local result__172
--@ compiler/compile.luma:319:32
local apply_result__1279 = invoke_symbol (_binding_node__0, ".?", 1, param__398)
if apply_result__1279 then
--@ compiler/compile.luma:319:34
local list_result__160
(function ()
local id__2, compiled_value__1
--@ compiler/compile.luma:320:41
local apply_result__1280 = invoke_symbol (param__398, ".id", 0)
--@ compiler/compile.luma:320:49
local apply_result__1281 = invoke_symbol (param__398, ".location", 0)
local apply_result__1282 = invoke_symbol (new_context__0, ".lookup", 2, apply_result__1280, apply_result__1281)
id__2 = apply_result__1282
--@ compiler/compile.luma:321:46
local apply_result__1283 = invoke_symbol (param__398, ".value", 0)
--@ compiler/compile.luma:321:64
local apply_result__1284 = invoke (compile_exp__0, 2, apply_result__1283, new_context__0)
compiled_value__1 = apply_result__1284
--@ compiler/compile.luma:322:46
local apply_result__1285 = emit__1.functions[".."] (id__2, " = ", compiled_value__1, "\
")
--@ compiler/compile.luma:323:39
local apply_result__1286 = invoke_symbol (compiled_value__1, ".type", 0)
--@ compiler/compile.luma:323:19
id__2 [".type"] = apply_result__1286
--@ compiler/compile.luma:325:17
local result__173
--@ compiler/compile.luma:326:32
local apply_result__1287 = invoke_symbol (param__398, ".id", 0)
local apply_result__1288 = invoke (___4, 2, "#number", apply_result__1287)
if apply_result__1288 then
--@ compiler/compile.luma:326:67
local apply_result__1289 = emit__1.functions[".."] ("ops.number = ", id__2, "\
")
result__173 = apply_result__1289
else
--@ compiler/compile.luma:327:32
local apply_result__1290 = invoke_symbol (param__398, ".id", 0)
local apply_result__1291 = invoke (___4, 2, "#string", apply_result__1290)
if apply_result__1291 then
--@ compiler/compile.luma:327:67
local apply_result__1292 = emit__1.functions[".."] ("ops.string = ", id__2, "\
")
result__173 = apply_result__1292
else
--@ compiler/compile.luma:328:32
local apply_result__1293 = invoke_symbol (param__398, ".id", 0)
local apply_result__1294 = invoke (___4, 2, "#bool", apply_result__1293)
if apply_result__1294 then
--@ compiler/compile.luma:328:70
local apply_result__1295 = emit__1.functions[".."] ("ops.boolean = ", id__2, "\
")
result__173 = apply_result__1295
else
result__173 = false 
end
end
end
list_result__160 = result__173
--@ unknown:-1:-1
end)()
result__172 = list_result__160
else
--@ compiler/compile.luma:329:15
if else__0 then
--@ compiler/compile.luma:329:16
local list_result__161
(function ()
--@ compiler/compile.luma:331:42
local apply_result__1296 = invoke (compile_exp__0, 2, param__398, new_context__0)
list_result__161 = apply_result__1296
--@ unknown:-1:-1
end)()
result__172 = list_result__161
else
result__172 = false 
end
end
return result__172
end
local apply_result__1297 = invoke_symbol (apply_result__1278, ".each", 1, fn__320)
--@ compiler/compile.luma:332:33
local apply_result__1298 = invoke_symbol (processed_items__0, ".last", 0)
last_item__0 = apply_result__1298
--@ compiler/compile.luma:333:48
local apply_result__1299 = invoke_symbol (_binding_node__0, ".?", 1, last_item__0)
local apply_result__1300 = invoke (not__0, 1, apply_result__1299)
--@ compiler/compile.luma:333:90
local apply_result__1301 = invoke (assert_at__0, 3, apply_result__1300, last_item__0, "lists cant end in a binding")
--@ compiler/compile.luma:334:57
local apply_result__1302 = invoke (compile_exp__0, 2, last_item__0, new_context__0)
compiled_value__0 = apply_result__1302
--@ compiler/compile.luma:335:47
local apply_result__1303 = emit__1.functions[".."] (result_id__2, " = ", compiled_value__0, "\
")
--@ compiler/compile.luma:336:40
local apply_result__1304 = invoke_symbol (compiled_value__0, ".type", 0)
--@ compiler/compile.luma:336:20
result_id__2 [".type"] = apply_result__1304
list_result__159 = true
--@ unknown:-1:-1
end)()
result__171 = list_result__159
else
result__171 = false 
end
--@ compiler/compile.luma:338:32
local apply_result__1305 = invoke_symbol (_location__0, ".unknown", 0)
local apply_result__1306 = set_location_info__0 (apply_result__1305)
--@ compiler/compile.luma:339:20
local apply_result__1307 = emit__1.functions[".."] ("end)()\
")
--@ compiler/compile.luma:340:14
list_result__157 = result_id__2
--@ unknown:-1:-1
end)()
return list_result__157
end
compile_list__0 = fn__318
--@ compiler/compile.luma:342:34
local fn__321 = function (param__399, param__400)
--@ compiler/compile.luma:342:34
local list_result__162
(function ()
local fn_id__0, new_context__1, params__0, index__0, return_value__0
--@ compiler/compile.luma:343:23
local apply_result__1308 = gensym__0 ("fn")
fn_id__0 = apply_result__1308
--@ compiler/compile.luma:344:35
local apply_result__1309 = invoke (_context__0, 1, param__400)
new_context__1 = apply_result__1309
--@ compiler/compile.luma:345:20
local apply_result__1310 = invoke (_array__0, 0)
params__0 = apply_result__1310
--@ compiler/compile.luma:346:8
local apply_result__1311 = invoke_symbol (param__399, ".params", 0)
--@ compiler/compile.luma:346:31
local fn__322 = function (param__401)
--@ compiler/compile.luma:346:31
local list_result__163
(function ()
local param_id__0
--@ compiler/compile.luma:347:32
local apply_result__1312 = gensym__0 ("param")
param_id__0 = apply_result__1312
--@ compiler/compile.luma:348:27
local apply_result__1313 = invoke_symbol (params__0, ".push", 1, param_id__0)
--@ compiler/compile.luma:349:37
local apply_result__1314 = invoke_symbol (new_context__1, ".add", 2, param__401, param_id__0)
list_result__163 = apply_result__1314
--@ unknown:-1:-1
end)()
return list_result__163
end
local apply_result__1315 = invoke_symbol (apply_result__1311, ".each", 1, fn__322)
--@ compiler/compile.luma:350:17
index__0 = false
--@ compiler/compile.luma:351:9
local result__174
--@ compiler/compile.luma:352:31
local apply_result__1316 = is_function_vararg___0 (param__399)
if apply_result__1316 then
--@ compiler/compile.luma:352:33
local list_result__164
(function ()
local vararg__1, adjusted_params__0, fixed_param_count__0
--@ compiler/compile.luma:353:23
local apply_result__1317 = invoke_symbol (params__0, ".last", 0)
vararg__1 = apply_result__1317
--@ compiler/compile.luma:354:44
local apply_result__1318 = invoke_symbol (params__0, ".drop-last", 1, 1)
adjusted_params__0 = apply_result__1318
--@ compiler/compile.luma:355:43
local apply_result__1319 = invoke_symbol (adjusted_params__0, ".length", 0)
fixed_param_count__0 = apply_result__1319
--@ compiler/compile.luma:356:50
local apply_result__1320 = emit__1.functions[".."] ("local ", fn_id__0, " = function (...)\
")
--@ compiler/compile.luma:357:13
local result__175
--@ compiler/compile.luma:357:36
local apply_result__1321 = invoke (___5, 2, 0, fixed_param_count__0)
if apply_result__1321 then
--@ compiler/compile.luma:358:56
local apply_result__1322 = comma_separate__0 (adjusted_params__0)
--@ compiler/compile.luma:358:68
local apply_result__1323 = emit__1.functions[".."] ("local ", apply_result__1322, " = ...\
")
result__175 = apply_result__1323
else
result__175 = false 
end
--@ compiler/compile.luma:359:79
local apply_result__1324 = invoke_symbol (fixed_param_count__0, ".to-string", 0)
--@ compiler/compile.luma:359:125
local apply_result__1325 = invoke (___0, 2, 1, fixed_param_count__0)
local apply_result__1326 = invoke_symbol (apply_result__1325, ".to-string", 0)
--@ compiler/compile.luma:359:149
local apply_result__1327 = emit__1.functions[".."] ("local ", vararg__1, " = { n = select (\"#\", ...) - ", apply_result__1324, ", select (", apply_result__1326, ", ...) }\
")
--@ compiler/compile.luma:360:80
local apply_result__1328 = emit__1.functions[".."] ("assert (", vararg__1, ".n >= 0, \"not enough arguments to function\")\
")
--@ compiler/compile.luma:361:23
index__0 = ".."
list_result__164 = true
--@ unknown:-1:-1
end)()
result__174 = list_result__164
else
--@ compiler/compile.luma:362:11
if else__0 then
--@ compiler/compile.luma:362:12
local list_result__165
(function ()
--@ compiler/compile.luma:363:67
local apply_result__1329 = comma_separate__0 (params__0)
--@ compiler/compile.luma:363:74
local apply_result__1330 = emit__1.functions[".."] ("local ", fn_id__0, " = function (", apply_result__1329, ")\
")
--@ compiler/compile.luma:364:25
local apply_result__1331 = invoke_symbol (params__0, ".length", 0)
index__0 = apply_result__1331
list_result__165 = true
--@ unknown:-1:-1
end)()
result__174 = list_result__165
else
result__174 = false 
end
end
--@ compiler/compile.luma:365:35
local apply_result__1332 = invoke_symbol (param__399, ".body", 0)
--@ compiler/compile.luma:365:52
local apply_result__1333 = invoke (compile_exp__0, 2, apply_result__1332, new_context__1)
return_value__0 = apply_result__1333
--@ compiler/compile.luma:366:37
local apply_result__1334 = emit__1.functions[".."] ("return ", return_value__0, "\
")
--@ compiler/compile.luma:367:17
local apply_result__1335 = emit__1.functions[".."] ("end\
")
--@ compiler/compile.luma:368:37
local apply_result__1336 = invoke_symbol (return_value__0, ".type", 0)
--@ compiler/compile.luma:368:14
local apply_result__1337 = fn_id__0[".type"]
apply_result__1337 [".call"] = apply_result__1336
--@ compiler/compile.luma:369:10
list_result__162 = fn_id__0
--@ unknown:-1:-1
end)()
return list_result__162
end
compile_function__0 = fn__321
--@ compiler/compile.luma:371:31
local fn__323 = function (param__402, param__403)
--@ compiler/compile.luma:371:31
local list_result__166
(function ()
local new_context__2, processed_items__1, table_id__0, locals__1, fields__0, functions__0, methods__0, has_index__0
--@ compiler/compile.luma:372:34
local apply_result__1338 = invoke (_context__0, 1, param__403)
new_context__2 = apply_result__1338
--@ compiler/compile.luma:374:39
local apply_result__1339 = invoke_symbol (param__402, ".items", 0)
--@ compiler/compile.luma:374:50
local apply_result__1340 = process_pairs__0 (apply_result__1339, true)
processed_items__1 = apply_result__1340
--@ compiler/compile.luma:377:29
local apply_result__1341 = gensym__0 ("table")
table_id__0 = apply_result__1341
--@ compiler/compile.luma:379:32
local apply_result__1342 = emit__1.functions[".."] ("local ", table_id__0, "\
")
--@ compiler/compile.luma:381:26
local apply_result__1343 = emit__1.functions[".."] ("(function ()\
")
--@ compiler/compile.luma:383:19
local apply_result__1344 = invoke (_list__0, 0)
locals__1 = apply_result__1344
--@ compiler/compile.luma:384:35
local fn__324 = function (param__404)
--@ compiler/compile.luma:385:11
local result__176
--@ compiler/compile.luma:385:33
local apply_result__1345 = invoke_symbol (_binding_node__0, ".?", 1, param__404)
if apply_result__1345 then
--@ compiler/compile.luma:385:35
local list_result__167
(function ()
local id__3
--@ compiler/compile.luma:386:25
local apply_result__1346 = invoke_symbol (param__404, ".id", 0)
local apply_result__1347 = gensym__0 (apply_result__1346)
id__3 = apply_result__1347
--@ compiler/compile.luma:387:50
local apply_result__1348 = invoke (_list__0, 1, id__3)
local apply_result__1349 = invoke_symbol (_list__0, ".append", 2, locals__1, apply_result__1348)
locals__1 = apply_result__1349
--@ compiler/compile.luma:388:29
local apply_result__1350 = invoke_symbol (param__404, ".id", 0)
--@ compiler/compile.luma:388:35
local apply_result__1351 = invoke_symbol (new_context__2, ".add", 2, apply_result__1350, id__3)
list_result__167 = apply_result__1351
--@ unknown:-1:-1
end)()
result__176 = list_result__167
else
result__176 = false 
end
return result__176
end
local apply_result__1352 = invoke_symbol (processed_items__1, ".each", 1, fn__324)
--@ compiler/compile.luma:389:9
local result__177
--@ compiler/compile.luma:389:21
local apply_result__1353 = invoke_symbol (locals__1, ".empty?", 0)
local apply_result__1354 = invoke (not__0, 1, apply_result__1353)
if apply_result__1354 then
--@ compiler/compile.luma:390:43
local apply_result__1355 = comma_separate__0 (locals__1)
--@ compiler/compile.luma:390:49
local apply_result__1356 = emit__1.functions[".."] ("local ", apply_result__1355, "\
")
result__177 = apply_result__1356
else
result__177 = false 
end
--@ compiler/compile.luma:393:19
local apply_result__1357 = invoke (_list__0, 0)
fields__0 = apply_result__1357
--@ compiler/compile.luma:394:22
local apply_result__1358 = invoke (_list__0, 0)
functions__0 = apply_result__1358
--@ compiler/compile.luma:395:20
local apply_result__1359 = invoke (_list__0, 0)
methods__0 = apply_result__1359
--@ compiler/compile.luma:396:21
has_index__0 = false
--@ compiler/compile.luma:397:35
local fn__325 = function (param__405)
--@ compiler/compile.luma:398:11
local result__178
--@ compiler/compile.luma:399:30
local apply_result__1360 = invoke_symbol (_binding_node__0, ".?", 1, param__405)
if apply_result__1360 then
--@ compiler/compile.luma:399:32
local list_result__168
(function ()
local id__4, compiled_value__2
--@ compiler/compile.luma:400:39
local apply_result__1361 = invoke_symbol (param__405, ".id", 0)
--@ compiler/compile.luma:400:47
local apply_result__1362 = invoke_symbol (param__405, ".location", 0)
local apply_result__1363 = invoke_symbol (new_context__2, ".lookup", 2, apply_result__1361, apply_result__1362)
id__4 = apply_result__1363
--@ compiler/compile.luma:401:44
local apply_result__1364 = invoke_symbol (param__405, ".value", 0)
--@ compiler/compile.luma:401:62
local apply_result__1365 = invoke (compile_exp__0, 2, apply_result__1364, new_context__2)
compiled_value__2 = apply_result__1365
--@ compiler/compile.luma:402:44
local apply_result__1366 = emit__1.functions[".."] (id__4, " = ", compiled_value__2, "\
")
--@ compiler/compile.luma:403:37
local apply_result__1367 = invoke_symbol (compiled_value__2, ".type", 0)
--@ compiler/compile.luma:403:17
id__4 [".type"] = apply_result__1367
list_result__168 = true
--@ unknown:-1:-1
end)()
result__178 = list_result__168
else
--@ compiler/compile.luma:404:28
local apply_result__1368 = invoke_symbol (_field_node__0, ".?", 1, param__405)
if apply_result__1368 then
--@ compiler/compile.luma:404:30
local list_result__169
(function ()
local id__5
--@ compiler/compile.luma:405:31
local apply_result__1369 = invoke_symbol (param__405, ".value", 0)
--@ compiler/compile.luma:405:49
local apply_result__1370 = invoke (compile_exp__0, 2, apply_result__1369, new_context__2)
id__5 = apply_result__1370
--@ compiler/compile.luma:407:42
local apply_result__1371 = invoke_symbol (param__405, ".id", 0)
local apply_result__1372 = invoke (quote_string__0, 1, apply_result__1371)
--@ compiler/compile.luma:407:62
local apply_result__1373 = invoke (_list__0, 5, "[", apply_result__1372, "] = ", id__5, ",\
")
local apply_result__1374 = invoke_symbol (_list__0, ".append", 2, fields__0, apply_result__1373)
fields__0 = apply_result__1374
--@ compiler/compile.luma:408:19
local apply_result__1375 = table_id__0[".type"]
local apply_result__1376 = invoke_symbol (apply_result__1375, ".fields", 0)
--@ compiler/compile.luma:408:40
local apply_result__1377 = invoke_symbol (param__405, ".id", 0)
--@ compiler/compile.luma:408:48
local apply_result__1378 = invoke_symbol (apply_result__1376, ".set", 2, apply_result__1377, true)
list_result__169 = apply_result__1378
--@ unknown:-1:-1
end)()
result__178 = list_result__169
else
--@ compiler/compile.luma:409:31
local apply_result__1379 = invoke_symbol (_function_node__0, ".?", 1, param__405)
if apply_result__1379 then
--@ compiler/compile.luma:409:33
local list_result__170
(function ()
local fn_id__1, num_params__0
--@ compiler/compile.luma:410:51
local apply_result__1380 = compile_function__0 (param__405, new_context__2)
fn_id__1 = apply_result__1380
--@ compiler/compile.luma:411:27
local apply_result__1381 = invoke_symbol (param__405, ".params", 0)
local apply_result__1382 = invoke_symbol (apply_result__1381, ".length", 0)
num_params__0 = apply_result__1382
--@ compiler/compile.luma:412:15
local result__179
--@ compiler/compile.luma:413:38
local apply_result__1383 = is_function_vararg___0 (param__405)
if apply_result__1383 then
--@ compiler/compile.luma:413:40
local list_result__171
(function ()
--@ compiler/compile.luma:414:83
local apply_result__1384 = invoke (_list__0, 3, "[\"..\"] = ", fn_id__1, ",\
")
local apply_result__1385 = invoke_symbol (_list__0, ".append", 2, functions__0, apply_result__1384)
functions__0 = apply_result__1385
--@ compiler/compile.luma:415:23
local apply_result__1386 = table_id__0[".type"]
local apply_result__1387 = invoke_symbol (apply_result__1386, ".functions", 0)
--@ compiler/compile.luma:415:53
local apply_result__1388 = fn_id__1[".type"]
local apply_result__1389 = invoke_symbol (apply_result__1388, ".call", 0)
local apply_result__1390 = invoke_symbol (apply_result__1387, ".set", 2, "..", apply_result__1389)
list_result__171 = apply_result__1390
--@ unknown:-1:-1
end)()
result__179 = list_result__171
else
--@ compiler/compile.luma:416:17
if else__0 then
--@ compiler/compile.luma:416:18
local list_result__172
(function ()
--@ compiler/compile.luma:417:74
local apply_result__1391 = invoke_symbol (num_params__0, ".to-string", 0)
--@ compiler/compile.luma:417:103
local apply_result__1392 = invoke (_list__0, 5, "[", apply_result__1391, "] = ", fn_id__1, ",\
")
local apply_result__1393 = invoke_symbol (_list__0, ".append", 2, functions__0, apply_result__1392)
functions__0 = apply_result__1393
--@ compiler/compile.luma:418:23
local apply_result__1394 = table_id__0[".type"]
local apply_result__1395 = invoke_symbol (apply_result__1394, ".functions", 0)
--@ compiler/compile.luma:418:59
local apply_result__1396 = fn_id__1[".type"]
local apply_result__1397 = invoke_symbol (apply_result__1396, ".call", 0)
local apply_result__1398 = invoke_symbol (apply_result__1395, ".set", 2, num_params__0, apply_result__1397)
list_result__172 = apply_result__1398
--@ unknown:-1:-1
end)()
result__179 = list_result__172
else
result__179 = false 
end
end
list_result__170 = result__179
--@ unknown:-1:-1
end)()
result__178 = list_result__170
else
--@ compiler/compile.luma:419:38
local apply_result__1399 = invoke_symbol (_symbol_function_node__0, ".?", 1, param__405)
if apply_result__1399 then
--@ compiler/compile.luma:419:40
local list_result__173
(function ()
local fn_id__2
--@ compiler/compile.luma:420:51
local apply_result__1400 = compile_function__0 (param__405, new_context__2)
fn_id__2 = apply_result__1400
--@ compiler/compile.luma:422:42
local apply_result__1401 = invoke_symbol (param__405, ".symbol", 0)
local apply_result__1402 = invoke (quote_string__0, 1, apply_result__1401)
--@ compiler/compile.luma:422:69
local apply_result__1403 = invoke (_list__0, 5, "[", apply_result__1402, "] = ", fn_id__2, ",\
")
local apply_result__1404 = invoke_symbol (_list__0, ".append", 2, functions__0, apply_result__1403)
functions__0 = apply_result__1404
--@ compiler/compile.luma:423:19
local apply_result__1405 = table_id__0[".type"]
local apply_result__1406 = invoke_symbol (apply_result__1405, ".functions", 0)
--@ compiler/compile.luma:423:43
local apply_result__1407 = invoke_symbol (param__405, ".symbol", 0)
--@ compiler/compile.luma:423:56
local apply_result__1408 = fn_id__2[".type"]
local apply_result__1409 = invoke_symbol (apply_result__1406, ".set", 2, apply_result__1407, apply_result__1408)
list_result__173 = apply_result__1409
--@ unknown:-1:-1
end)()
result__178 = list_result__173
else
--@ compiler/compile.luma:424:36
local apply_result__1410 = invoke_symbol (_symbol_method_node__0, ".?", 1, param__405)
if apply_result__1410 then
--@ compiler/compile.luma:424:38
local list_result__174
(function ()
local fn_id__3
--@ compiler/compile.luma:425:51
local apply_result__1411 = compile_function__0 (param__405, new_context__2)
fn_id__3 = apply_result__1411
--@ compiler/compile.luma:427:42
local apply_result__1412 = invoke_symbol (param__405, ".symbol", 0)
local apply_result__1413 = invoke (quote_string__0, 1, apply_result__1412)
--@ compiler/compile.luma:427:69
local apply_result__1414 = invoke (_list__0, 5, "[", apply_result__1413, "] = ", fn_id__3, ",\
")
local apply_result__1415 = invoke_symbol (_list__0, ".append", 2, methods__0, apply_result__1414)
methods__0 = apply_result__1415
--@ compiler/compile.luma:428:19
local apply_result__1416 = table_id__0[".type"]
local apply_result__1417 = invoke_symbol (apply_result__1416, ".methods", 0)
--@ compiler/compile.luma:428:41
local apply_result__1418 = invoke_symbol (param__405, ".symbol", 0)
--@ compiler/compile.luma:428:54
local apply_result__1419 = fn_id__3[".type"]
local apply_result__1420 = invoke_symbol (apply_result__1417, ".set", 2, apply_result__1418, apply_result__1419)
list_result__174 = apply_result__1420
--@ unknown:-1:-1
end)()
result__178 = list_result__174
else
--@ compiler/compile.luma:429:13
if else__0 then
--@ compiler/compile.luma:429:14
local list_result__175
(function ()
local index_id__0
--@ compiler/compile.luma:430:35
local apply_result__1421 = invoke (not__0, 1, has_index__0)
--@ compiler/compile.luma:430:81
local apply_result__1422 = invoke (assert_at__0, 3, apply_result__1421, param__405, "table cant have multiple index values")
--@ compiler/compile.luma:431:29
has_index__0 = true
--@ compiler/compile.luma:432:49
local apply_result__1423 = invoke (compile_exp__0, 2, param__405, new_context__2)
index_id__0 = apply_result__1423
--@ compiler/compile.luma:434:49
local apply_result__1424 = invoke (_list__0, 3, "[\"index\"] = ", index_id__0, ",\
")
local apply_result__1425 = invoke_symbol (_list__0, ".append", 2, fields__0, apply_result__1424)
fields__0 = apply_result__1425
--@ compiler/compile.luma:435:43
local apply_result__1426 = invoke_symbol (index_id__0, ".type", 0)
--@ compiler/compile.luma:435:23
local apply_result__1427 = table_id__0[".type"]
apply_result__1427 [".index"] = apply_result__1426
list_result__175 = true
--@ unknown:-1:-1
end)()
result__178 = list_result__175
else
result__178 = false 
end
end
end
end
end
end
return result__178
end
local apply_result__1428 = invoke_symbol (processed_items__1, ".each", 1, fn__325)
--@ compiler/compile.luma:438:27
local apply_result__1429 = emit__1.functions[".."] (table_id__0, " = {\
")
--@ compiler/compile.luma:439:16
local apply_result__1430 = emit__1.functions[".."] (fields__0)
--@ compiler/compile.luma:440:9
local result__180
--@ compiler/compile.luma:440:24
local apply_result__1431 = invoke_symbol (functions__0, ".empty?", 0)
local apply_result__1432 = invoke (not__0, 1, apply_result__1431)
if apply_result__1432 then
--@ compiler/compile.luma:440:33
local list_result__176
(function ()
--@ compiler/compile.luma:441:29
local apply_result__1433 = emit__1.functions[".."] ("functions = {\
")
--@ compiler/compile.luma:442:21
local apply_result__1434 = emit__1.functions[".."] (functions__0)
--@ compiler/compile.luma:443:18
local apply_result__1435 = emit__1.functions[".."] ("},\
")
list_result__176 = apply_result__1435
--@ unknown:-1:-1
end)()
result__180 = list_result__176
else
result__180 = false 
end
--@ compiler/compile.luma:444:9
local result__181
--@ compiler/compile.luma:444:22
local apply_result__1436 = invoke_symbol (methods__0, ".empty?", 0)
local apply_result__1437 = invoke (not__0, 1, apply_result__1436)
if apply_result__1437 then
--@ compiler/compile.luma:444:31
local list_result__177
(function ()
--@ compiler/compile.luma:445:27
local apply_result__1438 = emit__1.functions[".."] ("methods = {\
")
--@ compiler/compile.luma:446:19
local apply_result__1439 = emit__1.functions[".."] (methods__0)
--@ compiler/compile.luma:447:18
local apply_result__1440 = emit__1.functions[".."] ("},\
")
list_result__177 = apply_result__1440
--@ unknown:-1:-1
end)()
result__181 = list_result__177
else
result__181 = false 
end
--@ compiler/compile.luma:448:15
local apply_result__1441 = emit__1.functions[".."] ("}\
")
--@ compiler/compile.luma:449:32
local apply_result__1442 = invoke_symbol (_location__0, ".unknown", 0)
local apply_result__1443 = set_location_info__0 (apply_result__1442)
--@ compiler/compile.luma:450:20
local apply_result__1444 = emit__1.functions[".."] ("end)()\
")
--@ compiler/compile.luma:451:13
list_result__166 = table_id__0
--@ unknown:-1:-1
end)()
return list_result__166
end
compile_table__0 = fn__323
--@ compiler/compile.luma:453:30
local fn__326 = function (param__406, param__407)
--@ compiler/compile.luma:453:30
local list_result__178
(function ()
--@ compiler/compile.luma:454:33
local apply_result__1445 = invoke_symbol (param__406, ".key", 0)
local apply_result__1446 = invoke_symbol (_apply_node__0, ".?", 1, apply_result__1445)
--@ compiler/compile.luma:454:42
local apply_result__1447 = invoke_symbol (param__406, ".key", 0)
--@ compiler/compile.luma:454:75
local apply_result__1448 = invoke (assert_at__0, 3, apply_result__1446, apply_result__1447, "invalid pair as expression")
--@ compiler/compile.luma:455:19
local apply_result__1449 = invoke_symbol (param__406, ".key", 0)
local apply_result__1450 = invoke_symbol (apply_result__1449, ".items", 0)
local apply_result__1451 = invoke_symbol (apply_result__1450, ".length", 0)
--@ compiler/compile.luma:455:41
local apply_result__1452 = invoke_symbol (apply_result__1451, ".>", 1, 0)
--@ compiler/compile.luma:455:46
local apply_result__1453 = invoke_symbol (param__406, ".key", 0)
--@ compiler/compile.luma:455:79
local apply_result__1454 = invoke (assert_at__0, 3, apply_result__1452, apply_result__1453, "invalid pair as expression")
--@ compiler/compile.luma:456:28
local apply_result__1455 = invoke_symbol (param__406, ".key", 0)
local apply_result__1456 = invoke_symbol (apply_result__1455, ".items", 0)
--@ compiler/compile.luma:456:44
local apply_result__1457 = invoke_symbol (apply_result__1456, ".get", 1, 0)
local apply_result__1458 = invoke_symbol (apply_result__1457, ".id", 0)
local op_result__22 = "." == apply_result__1458
--@ compiler/compile.luma:456:54
local apply_result__1459 = invoke_symbol (param__406, ".key", 0)
local apply_result__1460 = invoke_symbol (apply_result__1459, ".items", 0)
--@ compiler/compile.luma:456:70
local apply_result__1461 = invoke_symbol (apply_result__1460, ".get", 1, 0)
--@ compiler/compile.luma:456:100
local apply_result__1462 = invoke (assert_at__0, 3, op_result__22, apply_result__1461, "invalid pair as expression")
--@ compiler/compile.luma:457:44
local apply_result__1463 = process_plain_function__0 (param__406)
--@ compiler/compile.luma:457:53
local apply_result__1464 = invoke (compile_exp__0, 2, apply_result__1463, param__407)
list_result__178 = apply_result__1464
--@ unknown:-1:-1
end)()
return list_result__178
end
compile_pair__0 = fn__326
--@ compiler/compile.luma:459:29
local fn__327 = function (param__408, param__409)
--@ compiler/compile.luma:459:29
local list_result__179
(function ()
local result__182
--@ compiler/compile.luma:460:26
local apply_result__1465 = invoke_symbol (param__408, ".location", 0)
local apply_result__1466 = set_location_info__0 (apply_result__1465)
--@ compiler/compile.luma:462:11
local result__183
--@ compiler/compile.luma:463:30
local apply_result__1467 = invoke_symbol (_number_node__0, ".?", 1, param__408)
if apply_result__1467 then
--@ compiler/compile.luma:463:62
local apply_result__1468 = compile_number__0 (param__408, param__409)
result__183 = apply_result__1468
else
--@ compiler/compile.luma:464:30
local apply_result__1469 = invoke_symbol (_string_node__0, ".?", 1, param__408)
if apply_result__1469 then
--@ compiler/compile.luma:464:62
local apply_result__1470 = compile_string__0 (param__408, param__409)
result__183 = apply_result__1470
else
--@ compiler/compile.luma:465:30
local apply_result__1471 = invoke_symbol (_word_node__0, ".?", 1, param__408)
if apply_result__1471 then
--@ compiler/compile.luma:465:62
local apply_result__1472 = compile_word__0 (param__408, param__409)
result__183 = apply_result__1472
else
--@ compiler/compile.luma:466:30
local apply_result__1473 = invoke_symbol (_apply_node__0, ".?", 1, param__408)
if apply_result__1473 then
--@ compiler/compile.luma:466:62
local apply_result__1474 = compile_apply__0 (param__408, param__409)
result__183 = apply_result__1474
else
--@ compiler/compile.luma:467:30
local apply_result__1475 = invoke_symbol (_list_node__0, ".?", 1, param__408)
if apply_result__1475 then
--@ compiler/compile.luma:467:62
local apply_result__1476 = compile_list__0 (param__408, param__409)
result__183 = apply_result__1476
else
--@ compiler/compile.luma:468:30
local apply_result__1477 = invoke_symbol (_function_node__0, ".?", 1, param__408)
if apply_result__1477 then
--@ compiler/compile.luma:468:62
local apply_result__1478 = compile_function__0 (param__408, param__409)
result__183 = apply_result__1478
else
--@ compiler/compile.luma:469:30
local apply_result__1479 = invoke_symbol (_table_node__0, ".?", 1, param__408)
if apply_result__1479 then
--@ compiler/compile.luma:469:62
local apply_result__1480 = compile_table__0 (param__408, param__409)
result__183 = apply_result__1480
else
--@ compiler/compile.luma:470:30
local apply_result__1481 = invoke_symbol (_pair_node__0, ".?", 1, param__408)
if apply_result__1481 then
--@ compiler/compile.luma:470:62
local apply_result__1482 = compile_pair__0 (param__408, param__409)
result__183 = apply_result__1482
else
--@ compiler/compile.luma:471:13
if else__0 then
--@ compiler/compile.luma:471:79
local apply_result__1483 = invoke_symbol (param__408, ".to-string", 0)
local apply_result__1484 = invoke (combine_strings__0, 2, "unknown exp in compile-exp: ", apply_result__1483)
local apply_result__1485 = invoke (error_at__0, 2, param__408, apply_result__1484)
result__183 = apply_result__1485
else
result__183 = false 
end
end
end
end
end
end
end
end
end
result__182 = result__183
--@ compiler/compile.luma:472:9
local result__184
--@ compiler/compile.luma:472:35
local apply_result__1486 = _value__0.functions[".?"] (result__182)
local result__185 = apply_result__1486
if not result__185 then
--@ compiler/compile.luma:472:62
local apply_result__1487 = invoke_symbol (_primitive_node__0, ".?", 1, result__182)
result__185 = apply_result__1487
end
local apply_result__1488 = invoke (not__0, 1, result__185)
if apply_result__1488 then
--@ compiler/compile.luma:473:54
local apply_result__1489 = invoke (error_at__0, 2, param__408, "compile-exp should return #value")
result__184 = apply_result__1489
else
result__184 = false 
end
--@ compiler/compile.luma:474:11
list_result__179 = result__182
--@ unknown:-1:-1
end)()
return list_result__179
end
compile_exp__0 = fn__327
--@ compiler/compile.luma:476:16
local list_result__180
(function ()
local context__0, add_macro__0, add_fn__0, add_lua_fn__0, add_type_check__0, add_type_constructor__0, add_binop__0
--@ compiler/compile.luma:477:23
local apply_result__1490 = invoke (_context__0, 0)
context__0 = apply_result__1490
--@ compiler/compile.luma:479:43
local fn__328 = function (param__410, param__411, param__412)
--@ compiler/compile.luma:482:27
local fn__329 = function (param__413, param__414)
--@ compiler/compile.luma:482:27
local list_result__181
(function ()
local args__2
--@ compiler/compile.luma:483:22
local apply_result__1491 = invoke_symbol (param__413, ".items", 0)
--@ compiler/compile.luma:483:35
local apply_result__1492 = invoke_symbol (apply_result__1491, ".drop", 1, 1)
args__2 = apply_result__1492
--@ compiler/compile.luma:484:38
local apply_result__1493 = invoke (not__0, 1, param__411)
local result__186 = apply_result__1493
if not result__186 then
--@ compiler/compile.luma:484:54
local apply_result__1494 = invoke_symbol (args__2, ".length", 0)
local apply_result__1495 = invoke (___4, 2, param__411, apply_result__1494)
result__186 = apply_result__1495
end
--@ compiler/compile.luma:484:108
local apply_result__1496 = invoke (assert_at__0, 3, result__186, param__413, "wrong number of arguments to primitive")
--@ compiler/compile.luma:485:38
local apply_result__1497 = invoke (param__412, 2, param__413, param__414)
list_result__181 = apply_result__1497
--@ unknown:-1:-1
end)()
return list_result__181
end
local apply_result__1498 = invoke (_primitive_node__0, 1, fn__329)
local apply_result__1499 = invoke_symbol (context__0, ".add", 2, param__410, apply_result__1498)
return apply_result__1499
end
add_macro__0 = fn__328
--@ compiler/compile.luma:487:37
local fn__330 = function (param__415, param__416, param__417)
--@ compiler/compile.luma:488:45
local fn__331 = function (param__418, param__419)
--@ compiler/compile.luma:488:45
local list_result__182
(function ()
local args__3, arg_values__0
--@ compiler/compile.luma:489:18
local apply_result__1500 = invoke_symbol (param__418, ".items", 0)
--@ compiler/compile.luma:489:31
local apply_result__1501 = invoke_symbol (apply_result__1500, ".drop", 1, 1)
args__3 = apply_result__1501
--@ compiler/compile.luma:490:38
local fn__332 = function (param__420)
--@ compiler/compile.luma:491:34
local apply_result__1502 = compile_exp__0 (param__420, param__419)
return apply_result__1502
end
local apply_result__1503 = invoke_symbol (args__3, ".map", 1, fn__332)
arg_values__0 = apply_result__1503
--@ compiler/compile.luma:492:30
local apply_result__1504 = invoke (param__417, 1, arg_values__0)
list_result__182 = apply_result__1504
--@ unknown:-1:-1
end)()
return list_result__182
end
local apply_result__1505 = add_macro__0 (param__415, param__416, fn__331)
return apply_result__1505
end
add_fn__0 = fn__330
--@ compiler/compile.luma:494:37
local fn__333 = function (param__421, param__422, param__423)
--@ compiler/compile.luma:495:36
local fn__334 = function (param__424)
--@ compiler/compile.luma:495:36
local list_result__183
(function ()
local result_id__3
--@ compiler/compile.luma:496:58
local apply_result__1506 = invoke (combine_strings__0, 2, param__421, "_result")
local apply_result__1507 = gensym__0 (apply_result__1506)
result_id__3 = apply_result__1507
--@ compiler/compile.luma:497:71
local apply_result__1508 = comma_separate__0 (param__424)
--@ compiler/compile.luma:497:78
local apply_result__1509 = emit__1.functions[".."] ("local ", result_id__3, " = ", param__423, "(", apply_result__1508, ")\
")
--@ compiler/compile.luma:498:18
list_result__183 = result_id__3
--@ unknown:-1:-1
end)()
return list_result__183
end
local apply_result__1510 = add_fn__0 (param__421, param__422, fn__334)
return apply_result__1510
end
add_lua_fn__0 = fn__333
--@ compiler/compile.luma:500:33
local fn__335 = function (param__425)
--@ compiler/compile.luma:501:20
local apply_result__1511 = _value__0.functions[1] ("true")
return apply_result__1511
end
local apply_result__1512 = add_fn__0 ("import", 1, fn__335)
--@ compiler/compile.luma:503:47
local fn__336 = function (param__426, param__427)
--@ compiler/compile.luma:504:20
local apply_result__1513 = _value__0.functions[1] ("true")
return apply_result__1513
end
local apply_result__1514 = add_macro__0 ("provide", false, fn__336)
--@ compiler/compile.luma:506:36
local fn__337 = function (param__428, param__429)
--@ compiler/compile.luma:507:31
local fn__338 = function (param__430)
--@ compiler/compile.luma:507:31
local list_result__184
(function ()
local result_id__4
--@ compiler/compile.luma:508:57
local apply_result__1515 = invoke (combine_strings__0, 2, param__428, "result")
local apply_result__1516 = gensym__0 (apply_result__1515)
result_id__4 = apply_result__1516
--@ compiler/compile.luma:509:57
local apply_result__1517 = invoke_symbol (param__430, ".get", 1, 0)
--@ compiler/compile.luma:509:82
local apply_result__1518 = emit__1.functions[".."] ("local ", result_id__4, " = type (", apply_result__1517, ") == \"", param__429, "\"\
")
--@ compiler/compile.luma:510:18
list_result__184 = result_id__4
--@ unknown:-1:-1
end)()
return list_result__184
end
local apply_result__1519 = add_fn__0 (param__428, 1, fn__338)
return apply_result__1519
end
add_type_check__0 = fn__337
--@ compiler/compile.luma:512:39
local apply_result__1520 = add_type_check__0 ("&string?", "string")
--@ compiler/compile.luma:513:39
local apply_result__1521 = add_type_check__0 ("&number?", "number")
--@ compiler/compile.luma:514:40
local apply_result__1522 = add_type_check__0 ("&bool?", "boolean")
--@ compiler/compile.luma:517:42
local fn__339 = function (param__431, param__432)
--@ compiler/compile.luma:518:31
local fn__340 = function (param__433)
--@ compiler/compile.luma:519:20
local apply_result__1523 = invoke_symbol (param__433, ".get", 1, 0)
return apply_result__1523
end
local apply_result__1524 = add_fn__0 (param__431, 1, fn__340)
return apply_result__1524
end
add_type_constructor__0 = fn__339
--@ compiler/compile.luma:521:45
local apply_result__1525 = add_type_constructor__0 ("&#string", "string")
--@ compiler/compile.luma:522:45
local apply_result__1526 = add_type_constructor__0 ("&#number", "number")
--@ compiler/compile.luma:523:46
local apply_result__1527 = add_type_constructor__0 ("&#bool", "boolean")
--@ compiler/compile.luma:525:47
local apply_result__1528 = add_lua_fn__0 ("&value-to-string", 1, "tostring")
--@ compiler/compile.luma:526:48
local apply_result__1529 = add_lua_fn__0 ("&string-to-number", 1, "tonumber")
--@ compiler/compile.luma:528:41
local fn__341 = function (param__434)
--@ compiler/compile.luma:528:41
local list_result__185
(function ()
local result_id__5
--@ compiler/compile.luma:529:40
local apply_result__1530 = gensym__0 ("concat_result")
result_id__5 = apply_result__1530
--@ compiler/compile.luma:530:49
local apply_result__1531 = invoke_symbol (param__434, ".get", 1, 0)
--@ compiler/compile.luma:530:70
local apply_result__1532 = invoke_symbol (param__434, ".get", 1, 1)
--@ compiler/compile.luma:530:76
local apply_result__1533 = emit__1.functions[".."] ("local ", result_id__5, " = ", apply_result__1531, " .. ", apply_result__1532, "\
")
--@ compiler/compile.luma:531:16
list_result__185 = result_id__5
--@ unknown:-1:-1
end)()
return list_result__185
end
local apply_result__1534 = add_fn__0 ("&string-concat", 2, fn__341)
--@ compiler/compile.luma:533:41
local fn__342 = function (param__435)
--@ compiler/compile.luma:533:41
local list_result__186
(function ()
local result_id__6
--@ compiler/compile.luma:534:40
local apply_result__1535 = gensym__0 ("length_result")
result_id__6 = apply_result__1535
--@ compiler/compile.luma:535:50
local apply_result__1536 = invoke_symbol (param__435, ".get", 1, 0)
--@ compiler/compile.luma:535:56
local apply_result__1537 = emit__1.functions[".."] ("local ", result_id__6, " = #", apply_result__1536, "\
")
--@ compiler/compile.luma:536:16
list_result__186 = result_id__6
--@ unknown:-1:-1
end)()
return list_result__186
end
local apply_result__1538 = add_fn__0 ("&string-length", 1, fn__342)
--@ compiler/compile.luma:538:44
local fn__343 = function (param__436)
--@ compiler/compile.luma:538:44
local list_result__187
(function ()
local result_id__7
--@ compiler/compile.luma:539:43
local apply_result__1539 = gensym__0 ("substring_result")
result_id__7 = apply_result__1539
--@ compiler/compile.luma:540:49
local apply_result__1540 = invoke_symbol (param__436, ".get", 1, 0)
--@ compiler/compile.luma:540:72
local apply_result__1541 = invoke_symbol (param__436, ".get", 1, 1)
--@ compiler/compile.luma:540:95
local apply_result__1542 = invoke_symbol (param__436, ".get", 1, 2)
--@ compiler/compile.luma:540:102
local apply_result__1543 = emit__1.functions[".."] ("local ", result_id__7, " = ", apply_result__1540, ":sub (", apply_result__1541, " + 1, ", apply_result__1542, ")\
")
--@ compiler/compile.luma:541:16
list_result__187 = result_id__7
--@ unknown:-1:-1
end)()
return list_result__187
end
local apply_result__1544 = add_fn__0 ("&string-substring", 3, fn__343)
--@ compiler/compile.luma:543:40
local fn__344 = function (param__437)
--@ compiler/compile.luma:543:40
local list_result__188
(function ()
local result_id__8, char_pattern__0
--@ compiler/compile.luma:544:41
local apply_result__1545 = gensym__0 ("char_at_result")
result_id__8 = apply_result__1545
--@ compiler/compile.luma:545:65
char_pattern__0 = "\"^[%z\\01-\\127\\194-\\244][\\128-\\191]*\""
--@ compiler/compile.luma:546:49
local apply_result__1546 = invoke_symbol (param__437, ".get", 1, 0)
--@ compiler/compile.luma:546:92
local apply_result__1547 = invoke_symbol (param__437, ".get", 1, 1)
--@ compiler/compile.luma:546:103
local apply_result__1548 = emit__1.functions[".."] ("local ", result_id__8, " = ", apply_result__1546, ":match (", char_pattern__0, ", ", apply_result__1547, " + 1)\
")
--@ compiler/compile.luma:547:84
local apply_result__1549 = emit__1.functions[".."] ("assert (", result_id__8, ", \"couldnt find next utf8 character in string\")\
")
--@ compiler/compile.luma:548:16
list_result__188 = result_id__8
--@ unknown:-1:-1
end)()
return list_result__188
end
local apply_result__1550 = add_fn__0 ("&utf8-char-at", 2, fn__344)
--@ compiler/compile.luma:550:44
local fn__345 = function (param__438)
--@ compiler/compile.luma:550:44
local list_result__189
(function ()
local result_id__9
--@ compiler/compile.luma:551:42
local apply_result__1551 = gensym__0 ("contains_result")
result_id__9 = apply_result__1551
--@ compiler/compile.luma:552:49
local apply_result__1552 = invoke_symbol (param__438, ".get", 1, 0)
--@ compiler/compile.luma:552:73
local apply_result__1553 = invoke_symbol (param__438, ".get", 1, 1)
--@ compiler/compile.luma:552:96
local apply_result__1554 = emit__1.functions[".."] ("local ", result_id__9, " = ", apply_result__1552, ":find (", apply_result__1553, ", 1, true) ~= nil\
")
--@ compiler/compile.luma:553:16
list_result__189 = result_id__9
--@ unknown:-1:-1
end)()
return list_result__189
end
local apply_result__1555 = add_fn__0 ("&string-contains?", 2, fn__345)
--@ compiler/compile.luma:555:40
local fn__346 = function (param__439)
--@ compiler/compile.luma:555:40
local list_result__190
(function ()
local result_id__10
--@ compiler/compile.luma:556:39
local apply_result__1556 = gensym__0 ("quote_result")
result_id__10 = apply_result__1556
--@ compiler/compile.luma:557:70
local apply_result__1557 = invoke_symbol (param__439, ".get", 1, 0)
--@ compiler/compile.luma:557:77
local apply_result__1558 = emit__1.functions[".."] ("local ", result_id__10, " = string.format (\"%q\", ", apply_result__1557, ")\
")
--@ compiler/compile.luma:558:16
list_result__190 = result_id__10
--@ unknown:-1:-1
end)()
return list_result__190
end
local apply_result__1559 = add_fn__0 ("&quote-string", 1, fn__346)
--@ compiler/compile.luma:560:43
local fn__347 = function (param__440)
--@ compiler/compile.luma:560:43
local list_result__191
(function ()
local result_id__11
--@ compiler/compile.luma:561:41
local apply_result__1560 = gensym__0 ("safe_id_result")
result_id__11 = apply_result__1560
--@ compiler/compile.luma:562:62
local apply_result__1561 = invoke_symbol (param__440, ".get", 1, 0)
--@ compiler/compile.luma:562:91
local apply_result__1562 = emit__1.functions[".."] ("local ", result_id__11, " = string.gsub (", apply_result__1561, ", \"[^a-zA-Z0-9_]\", \"_\")\
")
--@ compiler/compile.luma:563:95
local apply_result__1563 = emit__1.functions[".."] ("if ", result_id__11, ":match (\"^[0-9]\") then ", result_id__11, " = \"_\" .. ", result_id__11, " end\
")
--@ compiler/compile.luma:564:16
list_result__191 = result_id__11
--@ unknown:-1:-1
end)()
return list_result__191
end
local apply_result__1564 = add_fn__0 ("&safe-identifier", 1, fn__347)
--@ compiler/compile.luma:566:37
local fn__348 = function (param__441)
--@ compiler/compile.luma:566:37
local list_result__192
(function ()
local file_id__0, result_id__12
--@ compiler/compile.luma:567:29
local apply_result__1565 = gensym__0 ("file")
file_id__0 = apply_result__1565
--@ compiler/compile.luma:568:38
local apply_result__1566 = gensym__0 ("read_result")
result_id__12 = apply_result__1566
--@ compiler/compile.luma:569:64
local apply_result__1567 = invoke_symbol (param__441, ".get", 1, 0)
--@ compiler/compile.luma:569:77
local apply_result__1568 = emit__1.functions[".."] ("local ", file_id__0, " = assert (io.open (", apply_result__1567, ", \"r\"))\
")
--@ compiler/compile.luma:570:61
local apply_result__1569 = emit__1.functions[".."] ("local ", result_id__12, " = ", file_id__0, ":read (\"*a\")\
")
--@ compiler/compile.luma:571:33
local apply_result__1570 = emit__1.functions[".."] (file_id__0, ":close ()\
")
--@ compiler/compile.luma:572:16
list_result__192 = result_id__12
--@ unknown:-1:-1
end)()
return list_result__192
end
local apply_result__1571 = add_fn__0 ("&read-file", 1, fn__348)
--@ compiler/compile.luma:574:38
local fn__349 = function (param__442)
--@ compiler/compile.luma:574:38
local list_result__193
(function ()
local file_id__1, result_id__13
--@ compiler/compile.luma:575:29
local apply_result__1572 = gensym__0 ("file")
file_id__1 = apply_result__1572
--@ compiler/compile.luma:576:38
local apply_result__1573 = gensym__0 ("read_result")
result_id__13 = apply_result__1573
--@ compiler/compile.luma:577:64
local apply_result__1574 = invoke_symbol (param__442, ".get", 1, 0)
--@ compiler/compile.luma:577:77
local apply_result__1575 = emit__1.functions[".."] ("local ", file_id__1, " = assert (io.open (", apply_result__1574, ", \"w\"))\
")
--@ compiler/compile.luma:578:43
local apply_result__1576 = invoke_symbol (param__442, ".get", 1, 1)
--@ compiler/compile.luma:578:50
local apply_result__1577 = emit__1.functions[".."] (file_id__1, ":write (", apply_result__1576, ")\
")
--@ compiler/compile.luma:579:33
local apply_result__1578 = emit__1.functions[".."] (file_id__1, ":close ()\
")
--@ compiler/compile.luma:580:20
local apply_result__1579 = _value__0.functions[1] ("true")
list_result__193 = apply_result__1579
--@ unknown:-1:-1
end)()
return list_result__193
end
local apply_result__1580 = add_fn__0 ("&write-file", 2, fn__349)
--@ compiler/compile.luma:582:27
local fn__350 = function (param__443, param__444)
--@ compiler/compile.luma:583:29
local fn__351 = function (param__445)
--@ compiler/compile.luma:583:29
local list_result__194
(function ()
local id__6
--@ compiler/compile.luma:584:32
local apply_result__1581 = gensym__0 ("op_result")
id__6 = apply_result__1581
--@ compiler/compile.luma:585:44
local apply_result__1582 = invoke_symbol (param__445, ".get", 1, 0)
--@ compiler/compile.luma:585:73
local apply_result__1583 = invoke_symbol (param__445, ".get", 1, 1)
--@ compiler/compile.luma:585:79
local apply_result__1584 = emit__1.functions[".."] ("local ", id__6, " = ", apply_result__1582, " ", param__444, " ", apply_result__1583, "\
")
--@ compiler/compile.luma:586:11
list_result__194 = id__6
--@ unknown:-1:-1
end)()
return list_result__194
end
local apply_result__1585 = add_fn__0 (param__443, 2, fn__351)
return apply_result__1585
end
add_binop__0 = fn__350
--@ compiler/compile.luma:588:23
local apply_result__1586 = add_binop__0 ("&+", "+")
--@ compiler/compile.luma:589:23
local apply_result__1587 = add_binop__0 ("&-", "-")
--@ compiler/compile.luma:590:23
local apply_result__1588 = add_binop__0 ("&*", "*")
--@ compiler/compile.luma:591:23
local apply_result__1589 = add_binop__0 ("&/", "/")
--@ compiler/compile.luma:592:24
local apply_result__1590 = add_binop__0 ("&=", "==")
--@ compiler/compile.luma:593:25
local apply_result__1591 = add_binop__0 ("&~=", "~=")
--@ compiler/compile.luma:594:23
local apply_result__1592 = add_binop__0 ("&<", "<")
--@ compiler/compile.luma:595:23
local apply_result__1593 = add_binop__0 ("&>", ">")
--@ compiler/compile.luma:596:25
local apply_result__1594 = add_binop__0 ("&<=", "<=")
--@ compiler/compile.luma:597:25
local apply_result__1595 = add_binop__0 ("&>=", ">=")
--@ compiler/compile.luma:599:38
local apply_result__1596 = _value__0.functions[1] ("true")
local apply_result__1597 = invoke_symbol (context__0, ".add", 2, "true", apply_result__1596)
--@ compiler/compile.luma:600:40
local apply_result__1598 = _value__0.functions[1] ("false")
local apply_result__1599 = invoke_symbol (context__0, ".add", 2, "false", apply_result__1598)
--@ compiler/compile.luma:602:40
local apply_result__1600 = _value__0.functions[1] ("print")
local apply_result__1601 = invoke_symbol (context__0, ".add", 2, "print", apply_result__1600)
--@ compiler/compile.luma:604:25
local apply_result__1602 = add_binop__0 ("is?", "==")
--@ compiler/compile.luma:606:39
local fn__352 = function (param__446, param__447)
--@ compiler/compile.luma:606:39
local list_result__195
(function ()
local args__4, target__0, val_exp__0, value_id__0
--@ compiler/compile.luma:607:16
local apply_result__1603 = invoke_symbol (param__446, ".items", 0)
--@ compiler/compile.luma:607:29
local apply_result__1604 = invoke_symbol (apply_result__1603, ".drop", 1, 1)
args__4 = apply_result__1604
--@ compiler/compile.luma:608:25
local apply_result__1605 = invoke_symbol (args__4, ".get", 1, 0)
target__0 = apply_result__1605
--@ compiler/compile.luma:609:26
local apply_result__1606 = invoke_symbol (args__4, ".get", 1, 1)
val_exp__0 = apply_result__1606
--@ compiler/compile.luma:610:44
local apply_result__1607 = compile_exp__0 (val_exp__0, param__447)
value_id__0 = apply_result__1607
--@ compiler/compile.luma:611:11
local result__187
--@ compiler/compile.luma:612:29
local apply_result__1608 = invoke_symbol (_word_node__0, ".?", 1, target__0)
if apply_result__1608 then
--@ compiler/compile.luma:612:31
local list_result__196
(function ()
local target_id__0
--@ compiler/compile.luma:614:43
local apply_result__1609 = invoke_symbol (target__0, ".id", 0)
--@ compiler/compile.luma:614:53
local apply_result__1610 = invoke_symbol (target__0, ".location", 0)
local apply_result__1611 = invoke_symbol (param__447, ".lookup", 2, apply_result__1609, apply_result__1610)
target_id__0 = apply_result__1611
--@ compiler/compile.luma:615:45
local apply_result__1612 = emit__1.functions[".."] (target_id__0, " = ", value_id__0, "\
")
--@ compiler/compile.luma:616:24
local apply_result__1613 = _value__0.functions[1] ("true")
list_result__196 = apply_result__1613
--@ unknown:-1:-1
end)()
result__187 = list_result__196
else
--@ compiler/compile.luma:617:35
local apply_result__1614 = invoke_symbol (_apply_node__0, ".?", 1, target__0)
local result__188 = apply_result__1614
if result__188 then
--@ compiler/compile.luma:617:53
local apply_result__1615 = invoke_symbol (target__0, ".items", 0)
local apply_result__1616 = invoke_symbol (apply_result__1615, ".length", 0)
local apply_result__1617 = invoke (___4, 2, 2, apply_result__1616)
local result__189 = apply_result__1617
if result__189 then
--@ compiler/compile.luma:617:91
local apply_result__1618 = invoke_symbol (target__0, ".items", 0)
--@ compiler/compile.luma:617:103
local apply_result__1619 = invoke_symbol (apply_result__1618, ".get", 1, 1)
local apply_result__1620 = invoke_symbol (_symbol_node__0, ".?", 1, apply_result__1619)
result__189 = apply_result__1620
end
result__188 = result__189
end
if result__188 then
--@ compiler/compile.luma:617:108
local list_result__197
(function ()
local target_obj_id__0, sym_id__0
--@ compiler/compile.luma:619:45
local apply_result__1621 = invoke_symbol (target__0, ".items", 0)
--@ compiler/compile.luma:619:57
local apply_result__1622 = invoke_symbol (apply_result__1621, ".get", 1, 0)
--@ compiler/compile.luma:619:66
local apply_result__1623 = compile_exp__0 (apply_result__1622, param__447)
target_obj_id__0 = apply_result__1623
--@ compiler/compile.luma:620:26
local apply_result__1624 = invoke_symbol (target__0, ".items", 0)
--@ compiler/compile.luma:620:38
local apply_result__1625 = invoke_symbol (apply_result__1624, ".get", 1, 1)
local apply_result__1626 = invoke_symbol (apply_result__1625, ".id", 0)
sym_id__0 = apply_result__1626
--@ compiler/compile.luma:621:64
local apply_result__1627 = emit__1.functions[".."] (target_obj_id__0, " [\"", sym_id__0, "\"] = ", value_id__0, "\
")
--@ compiler/compile.luma:622:24
local apply_result__1628 = _value__0.functions[1] ("true")
list_result__197 = apply_result__1628
--@ unknown:-1:-1
end)()
result__187 = list_result__197
else
--@ compiler/compile.luma:624:13
if else__0 then
--@ compiler/compile.luma:624:80
local apply_result__1629 = invoke_symbol (target__0, ".to-string", 0)
local apply_result__1630 = invoke (combine_strings__0, 2, "unknown target in set: ", apply_result__1629)
local apply_result__1631 = invoke (error_at__0, 2, target__0, apply_result__1630)
result__187 = apply_result__1631
else
result__187 = false 
end
end
end
list_result__195 = result__187
--@ unknown:-1:-1
end)()
return list_result__195
end
local apply_result__1632 = add_macro__0 ("set", 2, fn__352)
--@ compiler/compile.luma:626:38
local fn__353 = function (param__448, param__449)
--@ compiler/compile.luma:626:38
local list_result__198
(function ()
local args__5, num_args__0, condition_id__0, result_id__14
--@ compiler/compile.luma:627:16
local apply_result__1633 = invoke_symbol (param__448, ".items", 0)
--@ compiler/compile.luma:627:29
local apply_result__1634 = invoke_symbol (apply_result__1633, ".drop", 1, 1)
args__5 = apply_result__1634
--@ compiler/compile.luma:628:21
local apply_result__1635 = invoke_symbol (args__5, ".length", 0)
num_args__0 = apply_result__1635
--@ compiler/compile.luma:629:44
local apply_result__1636 = invoke_symbol (args__5, ".get", 1, 0)
--@ compiler/compile.luma:629:53
local apply_result__1637 = compile_exp__0 (apply_result__1636, param__449)
condition_id__0 = apply_result__1637
--@ compiler/compile.luma:630:33
local apply_result__1638 = gensym__0 ("result")
result_id__14 = apply_result__1638
--@ compiler/compile.luma:631:35
local apply_result__1639 = emit__1.functions[".."] ("local ", result_id__14, "\
")
--@ compiler/compile.luma:632:40
local apply_result__1640 = emit__1.functions[".."] ("if ", condition_id__0, " then\
")
--@ compiler/compile.luma:633:52
local apply_result__1641 = invoke_symbol (args__5, ".get", 1, 1)
--@ compiler/compile.luma:633:61
local apply_result__1642 = compile_exp__0 (apply_result__1641, param__449)
--@ compiler/compile.luma:633:67
local apply_result__1643 = emit__1.functions[".."] (result_id__14, " = ", apply_result__1642, "\
")
--@ compiler/compile.luma:634:20
local apply_result__1644 = emit__1.functions[".."] ("else\
")
--@ compiler/compile.luma:635:52
local apply_result__1645 = invoke_symbol (args__5, ".get", 1, 2)
--@ compiler/compile.luma:635:61
local apply_result__1646 = compile_exp__0 (apply_result__1645, param__449)
--@ compiler/compile.luma:635:67
local apply_result__1647 = emit__1.functions[".."] (result_id__14, " = ", apply_result__1646, "\
")
--@ compiler/compile.luma:636:19
local apply_result__1648 = emit__1.functions[".."] ("end\
")
--@ compiler/compile.luma:637:16
list_result__198 = result_id__14
--@ unknown:-1:-1
end)()
return list_result__198
end
local apply_result__1649 = add_macro__0 ("if", 3, fn__353)
--@ compiler/compile.luma:639:44
local fn__354 = function (param__450, param__451)
--@ compiler/compile.luma:639:44
local list_result__199
(function ()
local args__6, result_id__15, compile_branch__0
--@ compiler/compile.luma:640:16
local apply_result__1650 = invoke_symbol (param__450, ".items", 0)
--@ compiler/compile.luma:640:29
local apply_result__1651 = invoke_symbol (apply_result__1650, ".drop", 1, 1)
args__6 = apply_result__1651
--@ compiler/compile.luma:641:33
local apply_result__1652 = gensym__0 ("result")
result_id__15 = apply_result__1652
--@ compiler/compile.luma:642:35
local apply_result__1653 = emit__1.functions[".."] ("local ", result_id__15, "\
")
--@ compiler/compile.luma:643:22
local apply_result__1654 = invoke_symbol (args__6, ".length", 0)
--@ compiler/compile.luma:643:34
local apply_result__1655 = invoke_symbol (apply_result__1654, ".>", 1, 0)
--@ compiler/compile.luma:643:52
local apply_result__1656 = invoke (assert_at__0, 3, apply_result__1655, param__450, "empty when")
--@ compiler/compile.luma:645:29
local fn__355 = function (param__452)
--@ compiler/compile.luma:645:29
local list_result__200
(function ()
local first__5, condition_id__1
--@ compiler/compile.luma:646:20
local apply_result__1657 = invoke_symbol (param__452, ".item", 0)
first__5 = apply_result__1657
--@ compiler/compile.luma:647:13
local apply_result__1658 = invoke_symbol (param__452, ".advance", 0)
--@ compiler/compile.luma:648:38
local apply_result__1659 = invoke_symbol (_pair_node__0, ".?", 1, first__5)
--@ compiler/compile.luma:648:66
local apply_result__1660 = invoke (assert_at__0, 3, apply_result__1659, first__5, "when expects pairs")
--@ compiler/compile.luma:649:40
local apply_result__1661 = invoke_symbol (first__5, ".key", 0)
--@ compiler/compile.luma:649:52
local apply_result__1662 = compile_exp__0 (apply_result__1661, param__451)
condition_id__1 = apply_result__1662
--@ compiler/compile.luma:650:42
local apply_result__1663 = emit__1.functions[".."] ("if ", condition_id__1, " then\
")
--@ compiler/compile.luma:651:48
local apply_result__1664 = invoke_symbol (first__5, ".value", 0)
--@ compiler/compile.luma:651:62
local apply_result__1665 = compile_exp__0 (apply_result__1664, param__451)
--@ compiler/compile.luma:651:68
local apply_result__1666 = emit__1.functions[".."] (result_id__15, " = ", apply_result__1665, "\
")
--@ compiler/compile.luma:652:22
local apply_result__1667 = emit__1.functions[".."] ("else\
")
--@ compiler/compile.luma:653:21
local apply_result__1668 = invoke_symbol (param__452, ".empty?", 0)
local apply_result__1669 = invoke (not__0, 1, apply_result__1668)
local result__190
if apply_result__1669 then
--@ compiler/compile.luma:654:30
local apply_result__1670 = invoke (compile_branch__0, 1, param__452)
result__190 = apply_result__1670
else
--@ compiler/compile.luma:655:39
local apply_result__1671 = emit__1.functions[".."] (result_id__15, " = false \
")
result__190 = apply_result__1671
end
--@ compiler/compile.luma:656:21
local apply_result__1672 = emit__1.functions[".."] ("end\
")
list_result__200 = apply_result__1672
--@ unknown:-1:-1
end)()
return list_result__200
end
compile_branch__0 = fn__355
--@ compiler/compile.luma:657:27
local apply_result__1673 = invoke_symbol (args__6, ".iterator", 0)
local apply_result__1674 = compile_branch__0 (apply_result__1673)
--@ compiler/compile.luma:658:16
list_result__199 = result_id__15
--@ unknown:-1:-1
end)()
return list_result__199
end
local apply_result__1675 = add_macro__0 ("when", false, fn__354)
--@ compiler/compile.luma:660:56
local apply_result__1676 = invoke_symbol (_location__0, ".unknown", 0)
local apply_result__1677 = invoke_symbol (context__0, ".lookup", 2, "when", apply_result__1676)
local apply_result__1678 = invoke_symbol (context__0, ".add", 2, "cond", apply_result__1677)
--@ compiler/compile.luma:663:41
local fn__356 = function (param__453, param__454)
--@ compiler/compile.luma:663:41
local list_result__201
(function ()
local args__7, condition_id__2, first__6
--@ compiler/compile.luma:664:16
local apply_result__1679 = invoke_symbol (param__453, ".items", 0)
--@ compiler/compile.luma:664:29
local apply_result__1680 = invoke_symbol (apply_result__1679, ".drop", 1, 1)
args__7 = apply_result__1680
--@ compiler/compile.luma:665:45
local apply_result__1681 = gensym__0 ("while_condition")
condition_id__2 = apply_result__1681
--@ compiler/compile.luma:666:22
local apply_result__1682 = invoke_symbol (args__7, ".length", 0)
--@ compiler/compile.luma:666:34
local apply_result__1683 = invoke_symbol (apply_result__1682, ".>", 1, 0)
--@ compiler/compile.luma:666:53
local apply_result__1684 = invoke (assert_at__0, 3, apply_result__1683, param__453, "empty while")
--@ compiler/compile.luma:667:24
local apply_result__1685 = invoke_symbol (args__7, ".get", 1, 0)
first__6 = apply_result__1685
--@ compiler/compile.luma:668:36
local apply_result__1686 = invoke_symbol (_pair_node__0, ".?", 1, first__6)
--@ compiler/compile.luma:668:66
local apply_result__1687 = invoke (assert_at__0, 3, apply_result__1686, first__6, "while expects a pair")
--@ compiler/compile.luma:669:58
local apply_result__1688 = invoke_symbol (first__6, ".key", 0)
--@ compiler/compile.luma:669:70
local apply_result__1689 = compile_exp__0 (apply_result__1688, param__454)
--@ compiler/compile.luma:669:76
local apply_result__1690 = emit__1.functions[".."] ("local ", condition_id__2, " = ", apply_result__1689, "\
")
--@ compiler/compile.luma:670:41
local apply_result__1691 = emit__1.functions[".."] ("while ", condition_id__2, " do\
")
--@ compiler/compile.luma:671:43
local apply_result__1692 = invoke_symbol (first__6, ".value", 0)
--@ compiler/compile.luma:671:57
local apply_result__1693 = compile_exp__0 (apply_result__1692, param__454)
--@ compiler/compile.luma:671:63
local apply_result__1694 = emit__1.functions[".."] ("local _ = ", apply_result__1693, "\
")
--@ compiler/compile.luma:672:49
local apply_result__1695 = invoke_symbol (first__6, ".key", 0)
--@ compiler/compile.luma:672:61
local apply_result__1696 = compile_exp__0 (apply_result__1695, param__454)
--@ compiler/compile.luma:672:67
local apply_result__1697 = emit__1.functions[".."] (condition_id__2, " = ", apply_result__1696, "\
")
--@ compiler/compile.luma:673:19
local apply_result__1698 = emit__1.functions[".."] ("end\
")
--@ compiler/compile.luma:674:21
local apply_result__1699 = _value__0.functions[1] ("false")
list_result__201 = apply_result__1699
--@ unknown:-1:-1
end)()
return list_result__201
end
local apply_result__1700 = add_macro__0 ("while", 1, fn__356)
--@ compiler/compile.luma:676:39
local fn__357 = function (param__455, param__456)
--@ compiler/compile.luma:676:39
local list_result__202
(function ()
local args__8, condition_id__3, result_id__16, second_condition_id__0
--@ compiler/compile.luma:677:16
local apply_result__1701 = invoke_symbol (param__455, ".items", 0)
--@ compiler/compile.luma:677:29
local apply_result__1702 = invoke_symbol (apply_result__1701, ".drop", 1, 1)
args__8 = apply_result__1702
--@ compiler/compile.luma:678:44
local apply_result__1703 = invoke_symbol (args__8, ".get", 1, 0)
--@ compiler/compile.luma:678:53
local apply_result__1704 = compile_exp__0 (apply_result__1703, param__456)
condition_id__3 = apply_result__1704
--@ compiler/compile.luma:679:33
local apply_result__1705 = gensym__0 ("result")
result_id__16 = apply_result__1705
--@ compiler/compile.luma:680:54
local apply_result__1706 = emit__1.functions[".."] ("local ", result_id__16, " = ", condition_id__3, "\
")
--@ compiler/compile.luma:681:37
local apply_result__1707 = emit__1.functions[".."] ("if ", result_id__16, " then\
")
--@ compiler/compile.luma:682:51
local apply_result__1708 = invoke_symbol (args__8, ".get", 1, 1)
--@ compiler/compile.luma:682:60
local apply_result__1709 = compile_exp__0 (apply_result__1708, param__456)
second_condition_id__0 = apply_result__1709
--@ compiler/compile.luma:683:52
local apply_result__1710 = emit__1.functions[".."] (result_id__16, " = ", second_condition_id__0, "\
")
--@ compiler/compile.luma:684:19
local apply_result__1711 = emit__1.functions[".."] ("end\
")
--@ compiler/compile.luma:685:16
list_result__202 = result_id__16
--@ unknown:-1:-1
end)()
return list_result__202
end
local apply_result__1712 = add_macro__0 ("and", 2, fn__357)
--@ compiler/compile.luma:687:38
local fn__358 = function (param__457, param__458)
--@ compiler/compile.luma:687:38
local list_result__203
(function ()
local args__9, condition_id__4, result_id__17, second_condition_id__1
--@ compiler/compile.luma:688:16
local apply_result__1713 = invoke_symbol (param__457, ".items", 0)
--@ compiler/compile.luma:688:29
local apply_result__1714 = invoke_symbol (apply_result__1713, ".drop", 1, 1)
args__9 = apply_result__1714
--@ compiler/compile.luma:689:44
local apply_result__1715 = invoke_symbol (args__9, ".get", 1, 0)
--@ compiler/compile.luma:689:53
local apply_result__1716 = compile_exp__0 (apply_result__1715, param__458)
condition_id__4 = apply_result__1716
--@ compiler/compile.luma:690:33
local apply_result__1717 = gensym__0 ("result")
result_id__17 = apply_result__1717
--@ compiler/compile.luma:691:54
local apply_result__1718 = emit__1.functions[".."] ("local ", result_id__17, " = ", condition_id__4, "\
")
--@ compiler/compile.luma:692:41
local apply_result__1719 = emit__1.functions[".."] ("if not ", result_id__17, " then\
")
--@ compiler/compile.luma:693:51
local apply_result__1720 = invoke_symbol (args__9, ".get", 1, 1)
--@ compiler/compile.luma:693:60
local apply_result__1721 = compile_exp__0 (apply_result__1720, param__458)
second_condition_id__1 = apply_result__1721
--@ compiler/compile.luma:694:52
local apply_result__1722 = emit__1.functions[".."] (result_id__17, " = ", second_condition_id__1, "\
")
--@ compiler/compile.luma:695:19
local apply_result__1723 = emit__1.functions[".."] ("end\
")
--@ compiler/compile.luma:696:16
list_result__203 = result_id__17
--@ unknown:-1:-1
end)()
return list_result__203
end
local apply_result__1724 = add_macro__0 ("or", 2, fn__358)
--@ compiler/compile.luma:698:40
local fn__359 = function (param__459, param__460)
--@ compiler/compile.luma:698:40
local list_result__204
(function ()
local args__10, table__81, item__0, result_id__18
--@ compiler/compile.luma:701:16
local apply_result__1725 = invoke_symbol (param__459, ".items", 0)
--@ compiler/compile.luma:701:29
local apply_result__1726 = invoke_symbol (apply_result__1725, ".drop", 1, 1)
args__10 = apply_result__1726
--@ compiler/compile.luma:702:37
local apply_result__1727 = invoke_symbol (args__10, ".get", 1, 0)
--@ compiler/compile.luma:702:46
local apply_result__1728 = compile_exp__0 (apply_result__1727, param__460)
table__81 = apply_result__1728
--@ compiler/compile.luma:704:36
local apply_result__1729 = invoke_symbol (args__10, ".get", 1, 1)
--@ compiler/compile.luma:704:45
local apply_result__1730 = compile_exp__0 (apply_result__1729, param__460)
item__0 = apply_result__1730
--@ compiler/compile.luma:705:33
local apply_result__1731 = gensym__0 ("result")
result_id__18 = apply_result__1731
--@ compiler/compile.luma:706:129
local apply_result__1732 = emit__1.functions[".."] ("local ", result_id__18, " = type (", table__81, ") == \"table\" and (", table__81, ".index == ", item__0, " or ", table__81, "[", item__0, "] ~= nil)\
")
--@ compiler/compile.luma:707:16
list_result__204 = result_id__18
--@ unknown:-1:-1
end)()
return list_result__204
end
local apply_result__1733 = add_macro__0 ("has?", 2, fn__359)
--@ compiler/compile.luma:709:37
local apply_result__1734 = add_lua_fn__0 ("&sqrt", 1, "math.sqrt")
--@ compiler/compile.luma:710:39
local apply_result__1735 = add_lua_fn__0 ("assert", false, "assert")
--@ compiler/compile.luma:711:54
local apply_result__1736 = add_lua_fn__0 ("&get-time", false, "love.timer.getTime")
--@ compiler/compile.luma:713:45
local fn__360 = function (param__461, param__462)
--@ compiler/compile.luma:713:45
local list_result__205
(function ()
local args__11, result_id__19
--@ compiler/compile.luma:714:16
local apply_result__1737 = invoke_symbol (param__461, ".items", 0)
--@ compiler/compile.luma:714:29
local apply_result__1738 = invoke_symbol (apply_result__1737, ".drop", 1, 1)
args__11 = apply_result__1738
--@ compiler/compile.luma:715:33
local apply_result__1739 = gensym__0 ("result")
result_id__19 = apply_result__1739
--@ compiler/compile.luma:716:36
local apply_result__1740 = emit__1.functions[".."] ("local ", result_id__19, " = ")
--@ compiler/compile.luma:717:11
local result__191
--@ compiler/compile.luma:718:14
local apply_result__1741 = invoke_symbol (args__11, ".length", 0)
--@ compiler/compile.luma:718:26
local apply_result__1742 = invoke_symbol (apply_result__1741, ".=", 1, 0)
if apply_result__1742 then
--@ compiler/compile.luma:719:24
local apply_result__1743 = emit__1.functions[".."] ("#arg\
")
result__191 = apply_result__1743
else
--@ compiler/compile.luma:720:13
if else__0 then
--@ compiler/compile.luma:720:14
local list_result__206
(function ()
local index__1
--@ compiler/compile.luma:721:41
local apply_result__1744 = invoke_symbol (args__11, ".get", 1, 0)
--@ compiler/compile.luma:721:50
local apply_result__1745 = compile_exp__0 (apply_result__1744, param__462)
index__1 = apply_result__1745
--@ compiler/compile.luma:722:44
local apply_result__1746 = emit__1.functions[".."] ("arg [", index__1, "] or false\
")
list_result__206 = apply_result__1746
--@ unknown:-1:-1
end)()
result__191 = list_result__206
else
result__191 = false 
end
end
--@ compiler/compile.luma:723:16
list_result__205 = result_id__19
--@ unknown:-1:-1
end)()
return list_result__205
end
local apply_result__1747 = add_macro__0 ("&args", false, fn__360)
--@ compiler/compile.luma:725:44
local fn__361 = function (param__463, param__464)
--@ compiler/compile.luma:725:44
local list_result__207
(function ()
local args__12, str__1
--@ compiler/compile.luma:726:16
local apply_result__1748 = invoke_symbol (param__463, ".items", 0)
--@ compiler/compile.luma:726:29
local apply_result__1749 = invoke_symbol (apply_result__1748, ".drop", 1, 1)
args__12 = apply_result__1749
--@ compiler/compile.luma:727:22
local apply_result__1750 = invoke_symbol (args__12, ".get", 1, 0)
str__1 = apply_result__1750
--@ compiler/compile.luma:728:36
local apply_result__1751 = invoke_symbol (_string_node__0, ".?", 1, str__1)
--@ compiler/compile.luma:728:75
local apply_result__1752 = invoke (assert_at__0, 3, apply_result__1751, str__1, "&lua-get expects string literal")
--@ compiler/compile.luma:729:17
local apply_result__1753 = invoke_symbol (str__1, ".value", 0)
local apply_result__1754 = _value__0.functions[1] (apply_result__1753)
list_result__207 = apply_result__1754
--@ unknown:-1:-1
end)()
return list_result__207
end
local apply_result__1755 = add_macro__0 ("&lua-get", 1, fn__361)
--@ compiler/compile.luma:731:44
local fn__362 = function (param__465, param__466)
--@ compiler/compile.luma:731:44
local list_result__208
(function ()
local args__13, str__2, val__0
--@ compiler/compile.luma:732:16
local apply_result__1756 = invoke_symbol (param__465, ".items", 0)
--@ compiler/compile.luma:732:29
local apply_result__1757 = invoke_symbol (apply_result__1756, ".drop", 1, 1)
args__13 = apply_result__1757
--@ compiler/compile.luma:733:22
local apply_result__1758 = invoke_symbol (args__13, ".get", 1, 0)
str__2 = apply_result__1758
--@ compiler/compile.luma:734:22
local apply_result__1759 = invoke_symbol (args__13, ".get", 1, 1)
val__0 = apply_result__1759
--@ compiler/compile.luma:735:36
local apply_result__1760 = invoke_symbol (_string_node__0, ".?", 1, str__2)
--@ compiler/compile.luma:735:75
local apply_result__1761 = invoke (assert_at__0, 3, apply_result__1760, str__2, "&lua-set expects string literal")
--@ compiler/compile.luma:736:15
local apply_result__1762 = invoke_symbol (str__2, ".value", 0)
--@ compiler/compile.luma:736:52
local apply_result__1763 = compile_exp__0 (val__0, param__466)
--@ compiler/compile.luma:736:58
local apply_result__1764 = emit__1.functions[".."] (apply_result__1762, " = ", apply_result__1763, "\
")
--@ compiler/compile.luma:737:21
local apply_result__1765 = _value__0.functions[1] ("false")
list_result__208 = apply_result__1765
--@ unknown:-1:-1
end)()
return list_result__208
end
local apply_result__1766 = add_macro__0 ("&lua-set", 2, fn__362)
--@ compiler/compile.luma:739:51
local fn__363 = function (param__467, param__468)
--@ compiler/compile.luma:739:51
local list_result__209
(function ()
local args__14, table__82, index__2, result_id__20
--@ compiler/compile.luma:740:16
local apply_result__1767 = invoke_symbol (param__467, ".items", 0)
--@ compiler/compile.luma:740:29
local apply_result__1768 = invoke_symbol (apply_result__1767, ".drop", 1, 1)
args__14 = apply_result__1768
--@ compiler/compile.luma:741:38
local apply_result__1769 = invoke_symbol (args__14, ".get", 1, 0)
--@ compiler/compile.luma:741:47
local apply_result__1770 = compile_exp__0 (apply_result__1769, param__468)
table__82 = apply_result__1770
--@ compiler/compile.luma:742:38
local apply_result__1771 = invoke_symbol (args__14, ".get", 1, 1)
--@ compiler/compile.luma:742:47
local apply_result__1772 = compile_exp__0 (apply_result__1771, param__468)
index__2 = apply_result__1772
--@ compiler/compile.luma:743:33
local apply_result__1773 = gensym__0 ("result")
result_id__20 = apply_result__1773
--@ compiler/compile.luma:744:66
local apply_result__1774 = emit__1.functions[".."] ("local ", result_id__20, " = ", table__82, " [", index__2, "] ~= nil\
")
--@ compiler/compile.luma:745:16
list_result__209 = result_id__20
--@ unknown:-1:-1
end)()
return list_result__209
end
local apply_result__1775 = add_macro__0 ("&lua-has-index?", 2, fn__363)
--@ compiler/compile.luma:747:50
local fn__364 = function (param__469, param__470)
--@ compiler/compile.luma:747:50
local list_result__210
(function ()
local args__15, table__83, index__3, result_id__21
--@ compiler/compile.luma:748:16
local apply_result__1776 = invoke_symbol (param__469, ".items", 0)
--@ compiler/compile.luma:748:29
local apply_result__1777 = invoke_symbol (apply_result__1776, ".drop", 1, 1)
args__15 = apply_result__1777
--@ compiler/compile.luma:749:38
local apply_result__1778 = invoke_symbol (args__15, ".get", 1, 0)
--@ compiler/compile.luma:749:47
local apply_result__1779 = compile_exp__0 (apply_result__1778, param__470)
table__83 = apply_result__1779
--@ compiler/compile.luma:750:38
local apply_result__1780 = invoke_symbol (args__15, ".get", 1, 1)
--@ compiler/compile.luma:750:47
local apply_result__1781 = compile_exp__0 (apply_result__1780, param__470)
index__3 = apply_result__1781
--@ compiler/compile.luma:751:33
local apply_result__1782 = gensym__0 ("result")
result_id__21 = apply_result__1782
--@ compiler/compile.luma:752:59
local apply_result__1783 = emit__1.functions[".."] ("local ", result_id__21, " = ", table__83, " [", index__3, "]\
")
--@ compiler/compile.luma:753:68
local apply_result__1784 = emit__1.functions[".."] ("assert (", result_id__21, " ~= nil, \"getting invalid index\")")
--@ compiler/compile.luma:754:16
list_result__210 = result_id__21
--@ unknown:-1:-1
end)()
return list_result__210
end
local apply_result__1785 = add_macro__0 ("&lua-get-index", 2, fn__364)
--@ compiler/compile.luma:756:50
local fn__365 = function (param__471, param__472)
--@ compiler/compile.luma:756:50
local list_result__211
(function ()
local args__16, table__84, index__4, value__2
--@ compiler/compile.luma:757:16
local apply_result__1786 = invoke_symbol (param__471, ".items", 0)
--@ compiler/compile.luma:757:29
local apply_result__1787 = invoke_symbol (apply_result__1786, ".drop", 1, 1)
args__16 = apply_result__1787
--@ compiler/compile.luma:758:38
local apply_result__1788 = invoke_symbol (args__16, ".get", 1, 0)
--@ compiler/compile.luma:758:47
local apply_result__1789 = compile_exp__0 (apply_result__1788, param__472)
table__84 = apply_result__1789
--@ compiler/compile.luma:759:38
local apply_result__1790 = invoke_symbol (args__16, ".get", 1, 1)
--@ compiler/compile.luma:759:47
local apply_result__1791 = compile_exp__0 (apply_result__1790, param__472)
index__4 = apply_result__1791
--@ compiler/compile.luma:760:38
local apply_result__1792 = invoke_symbol (args__16, ".get", 1, 2)
--@ compiler/compile.luma:760:47
local apply_result__1793 = compile_exp__0 (apply_result__1792, param__472)
value__2 = apply_result__1793
--@ compiler/compile.luma:761:46
local apply_result__1794 = emit__1.functions[".."] (table__84, " [", index__4, "] = ", value__2, "\
")
--@ compiler/compile.luma:762:21
local apply_result__1795 = _value__0.functions[1] ("false")
list_result__211 = apply_result__1795
--@ unknown:-1:-1
end)()
return list_result__211
end
local apply_result__1796 = add_macro__0 ("&lua-set-index", 3, fn__365)
--@ compiler/compile.luma:764:53
local fn__366 = function (param__473, param__474)
--@ compiler/compile.luma:764:53
local list_result__212
(function ()
local args__17, table__85, index__5
--@ compiler/compile.luma:765:16
local apply_result__1797 = invoke_symbol (param__473, ".items", 0)
--@ compiler/compile.luma:765:29
local apply_result__1798 = invoke_symbol (apply_result__1797, ".drop", 1, 1)
args__17 = apply_result__1798
--@ compiler/compile.luma:766:38
local apply_result__1799 = invoke_symbol (args__17, ".get", 1, 0)
--@ compiler/compile.luma:766:47
local apply_result__1800 = compile_exp__0 (apply_result__1799, param__474)
table__85 = apply_result__1800
--@ compiler/compile.luma:767:38
local apply_result__1801 = invoke_symbol (args__17, ".get", 1, 1)
--@ compiler/compile.luma:767:47
local apply_result__1802 = compile_exp__0 (apply_result__1801, param__474)
index__5 = apply_result__1802
--@ compiler/compile.luma:768:40
local apply_result__1803 = emit__1.functions[".."] (table__85, " [", index__5, "] = nil\
")
--@ compiler/compile.luma:769:21
local apply_result__1804 = _value__0.functions[1] ("false")
list_result__212 = apply_result__1804
--@ unknown:-1:-1
end)()
return list_result__212
end
local apply_result__1805 = add_macro__0 ("&lua-remove-index", 2, fn__366)
--@ compiler/compile.luma:771:60
local fn__367 = function (param__475, param__476)
--@ compiler/compile.luma:771:60
local list_result__213
(function ()
local args__18, table__86, result_id__22, index__6
--@ compiler/compile.luma:772:16
local apply_result__1806 = invoke_symbol (param__475, ".items", 0)
--@ compiler/compile.luma:772:29
local apply_result__1807 = invoke_symbol (apply_result__1806, ".drop", 1, 1)
args__18 = apply_result__1807
--@ compiler/compile.luma:773:38
local apply_result__1808 = invoke_symbol (args__18, ".get", 1, 0)
--@ compiler/compile.luma:773:47
local apply_result__1809 = compile_exp__0 (apply_result__1808, param__476)
table__86 = apply_result__1809
--@ compiler/compile.luma:774:33
local apply_result__1810 = gensym__0 ("result")
result_id__22 = apply_result__1810
--@ compiler/compile.luma:775:22
local apply_result__1811 = invoke_symbol (args__18, ".length", 0)
--@ compiler/compile.luma:775:34
local apply_result__1812 = invoke_symbol (apply_result__1811, ".=", 1, 1)
local result__192
if apply_result__1812 then
--@ compiler/compile.luma:776:14
result__192 = "nil"
else
--@ compiler/compile.luma:777:33
local apply_result__1813 = invoke_symbol (args__18, ".get", 1, 1)
--@ compiler/compile.luma:777:42
local apply_result__1814 = compile_exp__0 (apply_result__1813, param__476)
result__192 = apply_result__1814
end
index__6 = result__192
--@ compiler/compile.luma:778:72
local apply_result__1815 = emit__1.functions[".."] ("local ", result_id__22, " = next (", table__86, ", ", index__6, ") ~= nil\
")
--@ compiler/compile.luma:779:16
list_result__213 = result_id__22
--@ unknown:-1:-1
end)()
return list_result__213
end
local apply_result__1816 = add_macro__0 ("&lua-has-next-index?", false, fn__367)
--@ compiler/compile.luma:781:55
local fn__368 = function (param__477, param__478)
--@ compiler/compile.luma:781:55
local list_result__214
(function ()
local args__19, table__87, result_id__23, index__7
--@ compiler/compile.luma:782:16
local apply_result__1817 = invoke_symbol (param__477, ".items", 0)
--@ compiler/compile.luma:782:29
local apply_result__1818 = invoke_symbol (apply_result__1817, ".drop", 1, 1)
args__19 = apply_result__1818
--@ compiler/compile.luma:783:38
local apply_result__1819 = invoke_symbol (args__19, ".get", 1, 0)
--@ compiler/compile.luma:783:47
local apply_result__1820 = compile_exp__0 (apply_result__1819, param__478)
table__87 = apply_result__1820
--@ compiler/compile.luma:784:33
local apply_result__1821 = gensym__0 ("result")
result_id__23 = apply_result__1821
--@ compiler/compile.luma:785:22
local apply_result__1822 = invoke_symbol (args__19, ".length", 0)
--@ compiler/compile.luma:785:34
local apply_result__1823 = invoke_symbol (apply_result__1822, ".=", 1, 1)
local result__193
if apply_result__1823 then
--@ compiler/compile.luma:786:14
result__193 = "nil"
else
--@ compiler/compile.luma:787:33
local apply_result__1824 = invoke_symbol (args__19, ".get", 1, 1)
--@ compiler/compile.luma:787:42
local apply_result__1825 = compile_exp__0 (apply_result__1824, param__478)
result__193 = apply_result__1825
end
index__7 = result__193
--@ compiler/compile.luma:788:65
local apply_result__1826 = emit__1.functions[".."] ("local ", result_id__23, " = next (", table__87, ", ", index__7, ")\
")
--@ compiler/compile.luma:789:60
local apply_result__1827 = emit__1.functions[".."] ("assert (", result_id__23, " ~= nil, \"no next index\")")
--@ compiler/compile.luma:790:16
list_result__214 = result_id__23
--@ unknown:-1:-1
end)()
return list_result__214
end
local apply_result__1828 = add_macro__0 ("&lua-next-index", false, fn__368)
--@ compiler/compile.luma:792:47
local fn__369 = function (param__479, param__480)
--@ compiler/compile.luma:792:47
local list_result__215
(function ()
local arg__1, table__88, result_id__24
--@ compiler/compile.luma:793:15
local apply_result__1829 = invoke_symbol (param__479, ".items", 0)
--@ compiler/compile.luma:793:27
local apply_result__1830 = invoke_symbol (apply_result__1829, ".get", 1, 1)
arg__1 = apply_result__1830
--@ compiler/compile.luma:794:38
local apply_result__1831 = compile_exp__0 (arg__1, param__480)
table__88 = apply_result__1831
--@ compiler/compile.luma:795:33
local apply_result__1832 = gensym__0 ("result")
result_id__24 = apply_result__1832
--@ compiler/compile.luma:796:35
local apply_result__1833 = emit__1.functions[".."] ("local ", result_id__24, "\
")
--@ compiler/compile.luma:797:43
local apply_result__1834 = emit__1.functions[".."] ("if ", table__88, "[0] == nil then\
")
--@ compiler/compile.luma:798:31
local apply_result__1835 = emit__1.functions[".."] (result_id__24, " = \"\"\
")
--@ compiler/compile.luma:799:20
local apply_result__1836 = emit__1.functions[".."] ("else\
")
--@ compiler/compile.luma:800:70
local apply_result__1837 = emit__1.functions[".."] (result_id__24, " = ", table__88, " [0] .. table.concat (", table__88, ")\
")
--@ compiler/compile.luma:801:19
local apply_result__1838 = emit__1.functions[".."] ("end\
")
--@ compiler/compile.luma:802:16
list_result__215 = result_id__24
--@ unknown:-1:-1
end)()
return list_result__215
end
local apply_result__1839 = add_macro__0 ("&lua-concat", 1, fn__369)
--@ compiler/compile.luma:804:47
local fn__370 = function (param__481, param__482)
--@ compiler/compile.luma:804:47
local list_result__216
(function ()
local arg__2, result_id__25
--@ compiler/compile.luma:805:15
local apply_result__1840 = invoke_symbol (param__481, ".items", 0)
--@ compiler/compile.luma:805:27
local apply_result__1841 = invoke_symbol (apply_result__1840, ".get", 1, 1)
arg__2 = apply_result__1841
--@ compiler/compile.luma:806:36
local apply_result__1842 = invoke_symbol (_string_node__0, ".?", 1, arg__2)
--@ compiler/compile.luma:806:81
local apply_result__1843 = invoke (assert_at__0, 3, apply_result__1842, arg__2, "&embed expects string literal as path")
--@ compiler/compile.luma:807:42
local apply_result__1844 = gensym__0 ("embedded_string")
result_id__25 = apply_result__1844
--@ compiler/compile.luma:808:65
local apply_result__1845 = invoke_symbol (arg__2, ".value", 0)
local apply_result__1846 = invoke (read_file__0, 1, apply_result__1845)
local apply_result__1847 = invoke (quote_string__0, 1, apply_result__1846)
--@ compiler/compile.luma:808:78
local apply_result__1848 = emit__1.functions[".."] ("local ", result_id__25, " = ", apply_result__1847, "\
")
--@ compiler/compile.luma:809:16
list_result__216 = result_id__25
--@ unknown:-1:-1
end)()
return list_result__216
end
local apply_result__1849 = add_macro__0 ("&embed-file", 1, fn__370)
--@ compiler/compile.luma:811:43
local fn__371 = function (param__483, param__484)
--@ compiler/compile.luma:811:43
local list_result__217
(function ()
local items__7, fields__1
--@ compiler/compile.luma:813:26
local apply_result__1850 = invoke_symbol (param__483, ".items", 0)
local apply_result__1851 = invoke_symbol (apply_result__1850, ".length", 0)
local apply_result__1852 = invoke (____1, 2, 2, apply_result__1851)
--@ compiler/compile.luma:813:78
local apply_result__1853 = invoke (assert_at__0, 3, apply_result__1852, param__483, "new takes at least one argument")
--@ compiler/compile.luma:814:21
local apply_result__1854 = invoke (_array__0, 0)
items__7 = apply_result__1854
--@ compiler/compile.luma:815:18
local apply_result__1855 = invoke_symbol (param__483, ".items", 0)
--@ compiler/compile.luma:815:31
local apply_result__1856 = invoke_symbol (apply_result__1855, ".drop", 1, 1)
fields__1 = apply_result__1856
--@ compiler/compile.luma:816:11
local result__194
--@ compiler/compile.luma:816:44
local apply_result__1857 = invoke_symbol (fields__1, ".get", 1, 0)
local apply_result__1858 = invoke_symbol (_pair_node__0, ".?", 1, apply_result__1857)
local apply_result__1859 = invoke (not__0, 1, apply_result__1858)
if apply_result__1859 then
--@ compiler/compile.luma:816:48
local list_result__218
(function ()
--@ compiler/compile.luma:817:33
local apply_result__1860 = invoke_symbol (fields__1, ".get", 1, 0)
local apply_result__1861 = invoke_symbol (items__7, ".push", 1, apply_result__1860)
--@ compiler/compile.luma:818:34
local apply_result__1862 = invoke_symbol (fields__1, ".drop", 1, 1)
fields__1 = apply_result__1862
list_result__218 = true
--@ unknown:-1:-1
end)()
result__194 = list_result__218
else
result__194 = false 
end
--@ compiler/compile.luma:820:29
local fn__372 = function (param__485)
--@ compiler/compile.luma:820:29
local list_result__219
(function ()
local pair__0
--@ compiler/compile.luma:821:38
local apply_result__1863 = invoke_symbol (_pair_node__0, ".?", 1, param__485)
--@ compiler/compile.luma:821:84
local apply_result__1864 = invoke (assert_at__0, 3, apply_result__1863, param__485, "new takes pairs after first argument")
--@ compiler/compile.luma:822:38
local apply_result__1865 = invoke_symbol (param__485, ".key", 0)
local apply_result__1866 = invoke_symbol (_word_node__0, ".?", 1, apply_result__1865)
--@ compiler/compile.luma:822:49
local apply_result__1867 = invoke_symbol (param__485, ".key", 0)
--@ compiler/compile.luma:822:103
local apply_result__1868 = invoke (assert_at__0, 3, apply_result__1866, apply_result__1867, "new takes word-keyed pairs after first argument")
--@ compiler/compile.luma:823:67
local apply_result__1869 = invoke_symbol (param__485, ".key", 0)
local apply_result__1870 = invoke_symbol (apply_result__1869, ".id", 0)
local apply_result__1871 = invoke (combine_strings__0, 2, ".", apply_result__1870)
local apply_result__1872 = invoke (_symbol_node__0, 1, apply_result__1871)
--@ compiler/compile.luma:823:82
local apply_result__1873 = invoke_symbol (param__485, ".value", 0)
local apply_result__1874 = invoke (_pair_node__0, 2, apply_result__1872, apply_result__1873)
pair__0 = apply_result__1874
--@ compiler/compile.luma:824:24
local apply_result__1875 = invoke_symbol (items__7, ".push", 1, pair__0)
list_result__219 = apply_result__1875
--@ unknown:-1:-1
end)()
return list_result__219
end
local apply_result__1876 = invoke_symbol (fields__1, ".each", 1, fn__372)
--@ compiler/compile.luma:826:37
local apply_result__1877 = invoke (_table_node__0, 1, items__7)
--@ compiler/compile.luma:826:46
local apply_result__1878 = compile_exp__0 (apply_result__1877, param__484)
list_result__217 = apply_result__1878
--@ unknown:-1:-1
end)()
return list_result__217
end
local apply_result__1879 = add_macro__0 ("new", false, fn__371)
--@ compiler/compile.luma:828:12
list_result__180 = context__0
--@ unknown:-1:-1
end)()
base_context__0 = list_result__180
--@ compiler/compile.luma:830:20
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
local apply_result__1880 = emit__1.functions[".."] (embedded_string__0)
--@ compiler/compile.luma:831:39
local apply_result__1881 = emit__1.functions[".."] ("local function top_level ()\
")
--@ compiler/compile.luma:832:47
local apply_result__1882 = compile_exp__0 (param__374, base_context__0)
--@ compiler/compile.luma:832:53
local apply_result__1883 = emit__1.functions[".."] ("return ", apply_result__1882, "\
")
--@ compiler/compile.luma:833:15
local apply_result__1884 = emit__1.functions[".."] ("end\
")
--@ compiler/compile.luma:834:53
local apply_result__1885 = emit__1.functions[".."] ("return run_with_error_handler (top_level)\
")
--@ compiler/compile.luma:835:9
local apply_result__1886 = invoke_symbol (buffer__0, ".concat", 0)
list_result__137 = apply_result__1886
--@ unknown:-1:-1
end)()
return list_result__137
end
compile__1 = fn__303
--@ compiler/compile.luma:837:2
local table__89
(function ()
--@ compiler/compile.luma:838:20
table__89 = {
[".compile"] = compile__1,
}
--@ unknown:-1:-1
end)()
list_result__116 = table__89
--@ unknown:-1:-1
end)()
_modules_compiler_compile__0 = list_result__116
--@ unknown:-1:-1
local apply_result__1887 = _modules_compiler_compile__0[".compile"]
compile__0 = apply_result__1887
--@ unknown:-1:-1
local list_result__220
(function ()
local in_file__0, out_file__0, src__0, compiled__0
--@ compiler/command.luma:11:30
local apply_result__1888 = invoke_symbol (command_line_args__0, ".length", 0)
local apply_result__1889 = invoke (___4, 2, 2, apply_result__1888)
--@ compiler/command.luma:11:74
local assert_result__28 = assert(apply_result__1889, "usage: compile <infile> <outfile>")
--@ compiler/command.luma:13:27
local apply_result__1890 = invoke_symbol (command_line_args__0, ".first", 0)
in_file__0 = apply_result__1890
--@ compiler/command.luma:14:28
local apply_result__1891 = invoke_symbol (command_line_args__0, ".rest", 0)
local apply_result__1892 = invoke_symbol (apply_result__1891, ".first", 0)
out_file__0 = apply_result__1892
--@ compiler/command.luma:16:23
local apply_result__1893 = invoke (read_file__0, 1, in_file__0)
src__0 = apply_result__1893
--@ compiler/command.luma:18:58
local apply_result__1894 = invoke (read__0, 2, src__0, in_file__0)
local apply_result__1895 = invoke (parse__0, 1, apply_result__1894)
local apply_result__1896 = invoke (resolve__0, 1, apply_result__1895)
local apply_result__1897 = invoke (link__0, 1, apply_result__1896)
local apply_result__1898 = invoke (compile__0, 1, apply_result__1897)
compiled__0 = apply_result__1898
--@ compiler/command.luma:20:29
local apply_result__1899 = invoke (write_file__0, 2, out_file__0, compiled__0)
list_result__220 = apply_result__1899
--@ unknown:-1:-1
end)()
list_result__0 = list_result__220
--@ unknown:-1:-1
end)()
return list_result__0
end
return run_with_error_handler (top_level)
