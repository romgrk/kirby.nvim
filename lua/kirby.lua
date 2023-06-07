--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]

local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        ____moduleCache[file] = { value = (select("#", ...) > 0) and module(...) or module(file) }
        return ____moduleCache[file].value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lualib_bundle"] = function(...) 
local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__ArrayEntries(array)
    local key = 0
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            local result = {done = array[key + 1] == nil, value = {key, array[key + 1]}}
            key = key + 1
            return result
        end
    }
end

local function __TS__ArrayEvery(self, callbackfn, thisArg)
    for i = 1, #self do
        if not callbackfn(thisArg, self[i], i - 1, self) then
            return false
        end
    end
    return true
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end

local function __TS__ArrayFind(self, predicate, thisArg)
    for i = 1, #self do
        local elem = self[i]
        if predicate(thisArg, elem, i - 1, self) then
            return elem
        end
    end
    return nil
end

local function __TS__ArrayFindIndex(self, callbackFn, thisArg)
    for i = 1, #self do
        if callbackFn(thisArg, self[i], i - 1, self) then
            return i - 1
        end
    end
    return -1
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local __TS__ArrayFrom
do
    local function arrayLikeStep(self, index)
        index = index + 1
        if index > self.length then
            return
        end
        return index, self[index]
    end
    local function arrayLikeIterator(arr)
        if type(arr.length) == "number" then
            return arrayLikeStep, arr, 0
        end
        return __TS__Iterator(arr)
    end
    function __TS__ArrayFrom(arrayLike, mapFn, thisArg)
        local result = {}
        if mapFn == nil then
            for ____, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = v
            end
        else
            for i, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = mapFn(thisArg, v, i - 1)
            end
        end
        return result
    end
end

local function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k + 1, len do
        if self[i] == searchElement then
            return true
        end
    end
    return false
end

local function __TS__ArrayIndexOf(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    if len == 0 then
        return -1
    end
    if fromIndex >= len then
        return -1
    end
    if fromIndex < 0 then
        fromIndex = len + fromIndex
        if fromIndex < 0 then
            fromIndex = 0
        end
    end
    for i = fromIndex + 1, len do
        if self[i] == searchElement then
            return i - 1
        end
    end
    return -1
end

local function __TS__ArrayJoin(self, separator)
    if separator == nil then
        separator = ","
    end
    local parts = {}
    for i = 1, #self do
        parts[i] = tostring(self[i])
    end
    return table.concat(parts, separator)
end

local function __TS__ArrayMap(self, callbackfn, thisArg)
    local result = {}
    for i = 1, #self do
        result[i] = callbackfn(thisArg, self[i], i - 1, self)
    end
    return result
end

local function __TS__ArrayPush(self, ...)
    local items = {...}
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__ArrayPushArray(self, items)
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local function __TS__ArrayReduce(self, callbackFn, ...)
    local len = #self
    local k = 0
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, len do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReduceRight(self, callbackFn, ...)
    local len = #self
    local k = len - 1
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[k + 1]
        k = k - 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, 1, -1 do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReverse(self)
    local i = 1
    local j = #self
    while i < j do
        local temp = self[j]
        self[j] = self[i]
        self[i] = temp
        i = i + 1
        j = j - 1
    end
    return self
end

local function __TS__ArrayUnshift(self, ...)
    local items = {...}
    local numItemsToInsert = #items
    if numItemsToInsert == 0 then
        return #self
    end
    for i = #self, 1, -1 do
        self[i + numItemsToInsert] = self[i]
    end
    for i = 1, numItemsToInsert do
        self[i] = items[i]
    end
    return #self
end

local function __TS__ArraySort(self, compareFn)
    if compareFn ~= nil then
        table.sort(
            self,
            function(a, b) return compareFn(nil, a, b) < 0 end
        )
    else
        table.sort(self)
    end
    return self
end

local function __TS__ArraySlice(self, first, last)
    local len = #self
    first = first or 0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    last = last or len
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
end

local function __TS__ArraySome(self, callbackfn, thisArg)
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            return true
        end
    end
    return false
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end

local function __TS__ArrayToObject(self)
    local object = {}
    for i = 1, #self do
        object[i - 1] = self[i]
    end
    return object
end

local function __TS__ArrayFlat(self, depth)
    if depth == nil then
        depth = 1
    end
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = self[i]
        if depth > 0 and __TS__ArrayIsArray(value) then
            local toAdd
            if depth == 1 then
                toAdd = value
            else
                toAdd = __TS__ArrayFlat(value, depth - 1)
            end
            for j = 1, #toAdd do
                local val = toAdd[j]
                len = len + 1
                result[len] = val
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArrayFlatMap(self, callback, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = callback(thisArg, self[i], i - 1, self)
        if __TS__ArrayIsArray(value) then
            for j = 1, #value do
                len = len + 1
                result[len] = value[j]
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArraySetLength(self, length)
    if length < 0 or length ~= length or length == math.huge or math.floor(length) ~= length then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    for i = length + 1, #self do
        self[i] = nil
    end
    return length
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__Unpack = table.unpack or unpack

local function __TS__FunctionBind(fn, ...)
    local boundArgs = {...}
    return function(____, ...)
        local args = {...}
        __TS__ArrayUnshift(
            args,
            __TS__Unpack(boundArgs)
        )
        return fn(__TS__Unpack(args))
    end
end

local __TS__Promise
do
    local function promiseDeferred(self)
        local resolve
        local reject
        local promise = __TS__New(
            __TS__Promise,
            function(____, res, rej)
                resolve = res
                reject = rej
            end
        )
        return {promise = promise, resolve = resolve, reject = reject}
    end
    local function isPromiseLike(self, thing)
        return __TS__InstanceOf(thing, __TS__Promise)
    end
    __TS__Promise = __TS__Class()
    __TS__Promise.name = "__TS__Promise"
    function __TS__Promise.prototype.____constructor(self, executor)
        self.state = 0
        self.fulfilledCallbacks = {}
        self.rejectedCallbacks = {}
        self.finallyCallbacks = {}
        do
            local function ____catch(e)
                self:reject(e)
            end
            local ____try, ____hasReturned = pcall(function()
                executor(
                    nil,
                    __TS__FunctionBind(self.resolve, self),
                    __TS__FunctionBind(self.reject, self)
                )
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
    end
    function __TS__Promise.resolve(data)
        local promise = __TS__New(
            __TS__Promise,
            function()
            end
        )
        promise.state = 1
        promise.value = data
        return promise
    end
    function __TS__Promise.reject(reason)
        local promise = __TS__New(
            __TS__Promise,
            function()
            end
        )
        promise.state = 2
        promise.rejectionReason = reason
        return promise
    end
    __TS__Promise.prototype["then"] = function(self, onFulfilled, onRejected)
        local ____promiseDeferred_result_0 = promiseDeferred(nil)
        local promise = ____promiseDeferred_result_0.promise
        local resolve = ____promiseDeferred_result_0.resolve
        local reject = ____promiseDeferred_result_0.reject
        local isFulfilled = self.state == 1
        local isRejected = self.state == 2
        if onFulfilled then
            local internalCallback = self:createPromiseResolvingCallback(onFulfilled, resolve, reject)
            local ____self_fulfilledCallbacks_1 = self.fulfilledCallbacks
            ____self_fulfilledCallbacks_1[#____self_fulfilledCallbacks_1 + 1] = internalCallback
            if isFulfilled then
                internalCallback(nil, self.value)
            end
        else
            local ____self_fulfilledCallbacks_2 = self.fulfilledCallbacks
            ____self_fulfilledCallbacks_2[#____self_fulfilledCallbacks_2 + 1] = function(____, v) return resolve(nil, v) end
        end
        if onRejected then
            local internalCallback = self:createPromiseResolvingCallback(onRejected, resolve, reject)
            local ____self_rejectedCallbacks_3 = self.rejectedCallbacks
            ____self_rejectedCallbacks_3[#____self_rejectedCallbacks_3 + 1] = internalCallback
            if isRejected then
                internalCallback(nil, self.rejectionReason)
            end
        else
            local ____self_rejectedCallbacks_4 = self.rejectedCallbacks
            ____self_rejectedCallbacks_4[#____self_rejectedCallbacks_4 + 1] = function(____, err) return reject(nil, err) end
        end
        if isFulfilled then
            resolve(nil, self.value)
        end
        if isRejected then
            reject(nil, self.rejectionReason)
        end
        return promise
    end
    function __TS__Promise.prototype.catch(self, onRejected)
        return self["then"](self, nil, onRejected)
    end
    function __TS__Promise.prototype.finally(self, onFinally)
        if onFinally then
            local ____self_finallyCallbacks_5 = self.finallyCallbacks
            ____self_finallyCallbacks_5[#____self_finallyCallbacks_5 + 1] = onFinally
            if self.state ~= 0 then
                onFinally(nil)
            end
        end
        return self
    end
    function __TS__Promise.prototype.resolve(self, data)
        if __TS__InstanceOf(data, __TS__Promise) then
            data["then"](
                data,
                function(____, v) return self:resolve(v) end,
                function(____, err) return self:reject(err) end
            )
            return
        end
        if self.state == 0 then
            self.state = 1
            self.value = data
            for ____, callback in ipairs(self.fulfilledCallbacks) do
                callback(nil, data)
            end
            for ____, callback in ipairs(self.finallyCallbacks) do
                callback(nil)
            end
        end
    end
    function __TS__Promise.prototype.reject(self, reason)
        if self.state == 0 then
            self.state = 2
            self.rejectionReason = reason
            for ____, callback in ipairs(self.rejectedCallbacks) do
                callback(nil, reason)
            end
            for ____, callback in ipairs(self.finallyCallbacks) do
                callback(nil)
            end
        end
    end
    function __TS__Promise.prototype.createPromiseResolvingCallback(self, f, resolve, reject)
        return function(____, value)
            do
                local function ____catch(e)
                    reject(nil, e)
                end
                local ____try, ____hasReturned = pcall(function()
                    self:handleCallbackData(
                        f(nil, value),
                        resolve,
                        reject
                    )
                end)
                if not ____try then
                    ____catch(____hasReturned)
                end
            end
        end
    end
    function __TS__Promise.prototype.handleCallbackData(self, data, resolve, reject)
        if isPromiseLike(nil, data) then
            local nextpromise = data
            if nextpromise.state == 1 then
                resolve(nil, nextpromise.value)
            elseif nextpromise.state == 2 then
                reject(nil, nextpromise.rejectionReason)
            else
                data["then"](data, resolve, reject)
            end
        else
            resolve(nil, data)
        end
    end
end

local function __TS__AsyncAwaiter(generator)
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            local adopt, fulfilled, step, resolved, asyncCoroutine
            function adopt(self, value)
                local ____temp_0
                if __TS__InstanceOf(value, __TS__Promise) then
                    ____temp_0 = value
                else
                    ____temp_0 = __TS__Promise.resolve(value)
                end
                return ____temp_0
            end
            function fulfilled(self, value)
                local success, resultOrError = coroutine.resume(asyncCoroutine, value)
                if success then
                    step(nil, resultOrError)
                else
                    reject(nil, resultOrError)
                end
            end
            function step(self, result)
                if resolved then
                    return
                end
                if coroutine.status(asyncCoroutine) == "dead" then
                    resolve(nil, result)
                else
                    local ____self_1 = adopt(nil, result)
                    ____self_1["then"](____self_1, fulfilled, reject)
                end
            end
            resolved = false
            asyncCoroutine = coroutine.create(generator)
            local success, resultOrError = coroutine.resume(
                asyncCoroutine,
                function(____, v)
                    resolved = true
                    local ____self_2 = adopt(nil, v)
                    ____self_2["then"](____self_2, resolve, reject)
                end
            )
            if success then
                step(nil, resultOrError)
            else
                reject(nil, resultOrError)
            end
        end
    )
end
local function __TS__Await(thing)
    return coroutine.yield(thing)
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local function __TS__CloneDescriptor(____bindingPattern0)
    local value
    local writable
    local set
    local get
    local configurable
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    configurable = ____bindingPattern0.configurable
    get = ____bindingPattern0.get
    set = ____bindingPattern0.set
    writable = ____bindingPattern0.writable
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = get ~= nil or set ~= nil
    local hasValueOrWritableAttribute = writable ~= nil or value ~= nil
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

local function __TS__ObjectAssign(target, ...)
    local sources = {...}
    for i = 1, #sources do
        local source = sources[i]
        for key in pairs(source) do
            target[key] = source[key]
        end
    end
    return target
end

local function __TS__ObjectGetOwnPropertyDescriptor(object, key)
    local metatable = getmetatable(object)
    if not metatable then
        return
    end
    if not rawget(metatable, "_descriptors") then
        return
    end
    return rawget(metatable, "_descriptors")[key]
end

local __TS__SetDescriptor
do
    local function descriptorIndex(self, key)
        local value = rawget(self, key)
        if value ~= nil then
            return value
        end
        local metatable = getmetatable(self)
        while metatable do
            local rawResult = rawget(metatable, key)
            if rawResult ~= nil then
                return rawResult
            end
            local descriptors = rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor then
                    if descriptor.get then
                        return descriptor.get(self)
                    end
                    return descriptor.value
                end
            end
            metatable = getmetatable(metatable)
        end
    end
    local function descriptorNewIndex(self, key, value)
        local metatable = getmetatable(self)
        while metatable do
            local descriptors = rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor then
                    if descriptor.set then
                        descriptor.set(self, value)
                    else
                        if descriptor.writable == false then
                            error(
                                ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                                0
                            )
                        end
                        descriptor.value = value
                    end
                    return
                end
            end
            metatable = getmetatable(metatable)
        end
        rawset(self, key, value)
    end
    function __TS__SetDescriptor(target, key, desc, isPrototype)
        if isPrototype == nil then
            isPrototype = false
        end
        local ____isPrototype_0
        if isPrototype then
            ____isPrototype_0 = target
        else
            ____isPrototype_0 = getmetatable(target)
        end
        local metatable = ____isPrototype_0
        if not metatable then
            metatable = {}
            setmetatable(target, metatable)
        end
        local value = rawget(target, key)
        if value ~= nil then
            rawset(target, key, nil)
        end
        if not rawget(metatable, "_descriptors") then
            metatable._descriptors = {}
        end
        metatable._descriptors[key] = __TS__CloneDescriptor(desc)
        metatable.__index = descriptorIndex
        metatable.__newindex = descriptorNewIndex
    end
end

local function __TS__Decorate(decorators, target, key, desc)
    local result = target
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator then
                local oldResult = result
                if key == nil then
                    result = decorator(nil, result)
                elseif desc == true then
                    local value = rawget(target, key)
                    local descriptor = __TS__ObjectGetOwnPropertyDescriptor(target, key) or ({configurable = true, writable = true, value = value})
                    local desc = decorator(nil, target, key, descriptor) or descriptor
                    local isSimpleValue = desc.configurable == true and desc.writable == true and not desc.get and not desc.set
                    if isSimpleValue then
                        rawset(target, key, desc.value)
                    else
                        __TS__SetDescriptor(
                            target,
                            key,
                            __TS__ObjectAssign({}, descriptor, desc)
                        )
                    end
                elseif desc == false then
                    result = decorator(nil, target, key, desc)
                else
                    result = decorator(nil, target, key)
                end
                result = result or oldResult
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__DecorateParam(paramIndex, decorator)
    return function(____, target, key) return decorator(nil, target, key, paramIndex) end
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (tostring(description) .. "\n") .. self.stack
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_2 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        local ____temp_1
        if self.message ~= "" then
            ____temp_1 = (self.name .. ": ") .. self.message
        else
            ____temp_1 = self.name
        end
        return ____temp_1
    end
    Error = ____initErrorClass_2(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_4 = initErrorClass
        local ____class_3 = __TS__Class()
        ____class_3.name = ____class_3.name
        __TS__ClassExtends(____class_3, Error)
        function ____class_3.prototype.____constructor(self, ...)
            ____class_3.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_4(nil, ____class_3, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local function __TS__StringAccess(self, index)
    if index >= 0 and index < #self then
        return string.sub(self, index + 1, index + 1)
    end
end

local function __TS__DelegatedYield(iterable)
    if type(iterable) == "string" then
        for index = 0, #iterable - 1 do
            coroutine.yield(__TS__StringAccess(iterable, index))
        end
    elseif iterable.____coroutine ~= nil then
        local co = iterable.____coroutine
        while true do
            local status, value = coroutine.resume(co)
            if not status then
                error(value, 0)
            end
            if coroutine.status(co) == "dead" then
                return value
            else
                coroutine.yield(value)
            end
        end
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                return result.value
            else
                coroutine.yield(result.value)
            end
        end
    else
        for ____, value in ipairs(iterable) do
            coroutine.yield(value)
        end
    end
end

local __TS__Generator
do
    local function generatorIterator(self)
        return self
    end
    local function generatorNext(self, ...)
        local co = self.____coroutine
        if coroutine.status(co) == "dead" then
            return {done = true}
        end
        local status, value = coroutine.resume(co, ...)
        if not status then
            error(value, 0)
        end
        return {
            value = value,
            done = coroutine.status(co) == "dead"
        }
    end
    function __TS__Generator(fn)
        return function(...)
            local args = {...}
            local argsLength = __TS__CountVarargs(...)
            return {
                ____coroutine = coroutine.create(function() return fn(__TS__Unpack(args, 1, argsLength)) end),
                [Symbol.iterator] = generatorIterator,
                next = generatorNext
            }
        end
    end
end

local function __TS__InstanceOfObject(value)
    local valueType = type(value)
    return valueType == "table" or valueType == "function"
end

local function __TS__LuaIteratorSpread(self, state, firstKey)
    local results = {}
    local key, value = self(state, firstKey)
    while key do
        results[#results + 1] = {key, value}
        key, value = self(state, key)
    end
    return __TS__Unpack(results)
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next and previous then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
end

local __TS__Match = string.match

local __TS__MathAtan2 = math.atan2 or math.atan

local __TS__MathModf = math.modf

local function __TS__MathSign(val)
    if val > 0 then
        return 1
    elseif val < 0 then
        return -1
    end
    return 0
end

local function __TS__Number(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        local numberValue = tonumber(value)
        if numberValue then
            return numberValue
        end
        if value == "Infinity" then
            return math.huge
        end
        if value == "-Infinity" then
            return -math.huge
        end
        local stringWithoutSpaces = string.gsub(value, "%s", "")
        if stringWithoutSpaces == "" then
            return 0
        end
        return 0 / 0
    elseif valueType == "boolean" then
        return value and 1 or 0
    else
        return 0 / 0
    end
end

local function __TS__NumberIsFinite(value)
    return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

local function __TS__NumberIsNaN(value)
    return value ~= value
end

local __TS__NumberToString
do
    local radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
    function __TS__NumberToString(self, radix)
        if radix == nil or radix == 10 or self == math.huge or self == -math.huge or self ~= self then
            return tostring(self)
        end
        radix = math.floor(radix)
        if radix < 2 or radix > 36 then
            error("toString() radix argument must be between 2 and 36", 0)
        end
        local integer, fraction = __TS__MathModf(math.abs(self))
        local result = ""
        if radix == 8 then
            result = string.format("%o", integer)
        elseif radix == 16 then
            result = string.format("%x", integer)
        else
            repeat
                do
                    result = __TS__StringAccess(radixChars, integer % radix) .. result
                    integer = math.floor(integer / radix)
                end
            until not (integer ~= 0)
        end
        if fraction ~= 0 then
            result = result .. "."
            local delta = 1e-16
            repeat
                do
                    fraction = fraction * radix
                    delta = delta * radix
                    local digit = math.floor(fraction)
                    result = result .. __TS__StringAccess(radixChars, digit)
                    fraction = fraction - digit
                end
            until not (fraction >= delta)
        end
        if self < 0 then
            result = "-" .. result
        end
        return result
    end
end

local function __TS__ObjectDefineProperty(target, key, desc)
    local ____temp_0
    if type(key) == "number" then
        ____temp_0 = key + 1
    else
        ____temp_0 = key
    end
    local luaKey = ____temp_0
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = desc.get ~= nil or desc.set ~= nil
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        local ____desc_set_5 = desc.set
        local ____desc_get_6 = desc.get
        local ____temp_1
        if desc.configurable ~= nil then
            ____temp_1 = desc.configurable
        else
            ____temp_1 = valueExists
        end
        local ____temp_2
        if desc.enumerable ~= nil then
            ____temp_2 = desc.enumerable
        else
            ____temp_2 = valueExists
        end
        local ____temp_3
        if desc.writable ~= nil then
            ____temp_3 = desc.writable
        else
            ____temp_3 = valueExists
        end
        local ____temp_4
        if desc.value ~= nil then
            ____temp_4 = desc.value
        else
            ____temp_4 = value
        end
        descriptor = {
            set = ____desc_set_5,
            get = ____desc_get_6,
            configurable = ____temp_1,
            enumerable = ____temp_2,
            writable = ____temp_3,
            value = ____temp_4
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

local function __TS__ObjectFromEntries(entries)
    local obj = {}
    local iterable = entries
    if iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                break
            end
            local value = result.value
            obj[value[1]] = value[2]
        end
    else
        for ____, entry in ipairs(entries) do
            obj[entry[1]] = entry[2]
        end
    end
    return obj
end

local function __TS__ObjectKeys(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = key
    end
    return result
end

local function __TS__ObjectRest(target, usedProperties)
    local result = {}
    for property in pairs(target) do
        if not usedProperties[property] then
            result[property] = target[property]
        end
    end
    return result
end

local function __TS__ObjectValues(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = obj[key]
    end
    return result
end

local function __TS__ParseFloat(numberString)
    local infinityMatch = __TS__Match(numberString, "^%s*(-?Infinity)")
    if infinityMatch then
        local ____temp_0
        if __TS__StringAccess(infinityMatch, 0) == "-" then
            ____temp_0 = -math.huge
        else
            ____temp_0 = math.huge
        end
        return ____temp_0
    end
    local number = tonumber(__TS__Match(numberString, "^%s*(-?%d+%.?%d*)"))
    return number or 0 / 0
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local __TS__ParseInt
do
    local parseIntBasePattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
    function __TS__ParseInt(numberString, base)
        if base == nil then
            base = 10
            local hexMatch = __TS__Match(numberString, "^%s*-?0[xX]")
            if hexMatch then
                base = 16
                local ____TS__Match_result__0_0
                if __TS__Match(hexMatch, "-") then
                    ____TS__Match_result__0_0 = "-" .. __TS__StringSubstring(numberString, #hexMatch)
                else
                    ____TS__Match_result__0_0 = __TS__StringSubstring(numberString, #hexMatch)
                end
                numberString = ____TS__Match_result__0_0
            end
        end
        if base < 2 or base > 36 then
            return 0 / 0
        end
        local ____temp_1
        if base <= 10 then
            ____temp_1 = __TS__StringSubstring(parseIntBasePattern, 0, base)
        else
            ____temp_1 = __TS__StringSubstring(parseIntBasePattern, 0, 10 + 2 * (base - 10))
        end
        local allowedDigits = ____temp_1
        local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
        local number = tonumber(
            __TS__Match(numberString, pattern),
            base
        )
        if number == nil then
            return 0 / 0
        end
        if number >= 0 then
            return math.floor(number)
        else
            return math.ceil(number)
        end
    end
end

local function __TS__PromiseAll(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = item.value
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = item
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = data
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        reject(nil, reason)
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAllSettled(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = {status = "fulfilled", value = item.value}
            elseif item.state == 2 then
                results[i + 1] = {status = "rejected", reason = item.rejectionReason}
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = {status = "fulfilled", value = item}
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = {status = "fulfilled", value = data}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        results[index + 1] = {status = "rejected", reason = reason}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAny(iterable)
    local rejections = {}
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                rejections[#rejections + 1] = item.rejectionReason
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    if #pending == 0 then
        return __TS__Promise.reject("No promises to resolve with .any()")
    end
    local numResolved = 0
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, data)
                        resolve(nil, data)
                    end,
                    function(____, reason)
                        rejections[#rejections + 1] = reason
                        numResolved = numResolved + 1
                        if numResolved == #pending then
                            reject(nil, {name = "AggregateError", message = "All Promises rejected", errors = rejections})
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseRace(iterable)
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, value) return resolve(nil, value) end,
                    function(____, reason) return reject(nil, reason) end
                )
            end
        end
    )
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next and previous then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    Set[Symbol.species] = Set
end

local function __TS__SparseArrayNew(...)
    local sparseArray = {...}
    sparseArray.sparseLength = __TS__CountVarargs(...)
    return sparseArray
end

local function __TS__SparseArrayPush(sparseArray, ...)
    local args = {...}
    local argsLen = __TS__CountVarargs(...)
    local listLen = sparseArray.sparseLength
    for i = 1, argsLen do
        sparseArray[listLen + i] = args[i]
    end
    sparseArray.sparseLength = listLen + argsLen
end

local function __TS__SparseArraySpread(sparseArray)
    local _unpack = unpack or table.unpack
    return _unpack(sparseArray, 1, sparseArray.sparseLength)
end

local WeakMap
do
    WeakMap = __TS__Class()
    WeakMap.name = "WeakMap"
    function WeakMap.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "WeakMap"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self.items[value[1]] = value[2]
            end
        else
            for ____, kvp in ipairs(entries) do
                self.items[kvp[1]] = kvp[2]
            end
        end
    end
    function WeakMap.prototype.delete(self, key)
        local contains = self:has(key)
        self.items[key] = nil
        return contains
    end
    function WeakMap.prototype.get(self, key)
        return self.items[key]
    end
    function WeakMap.prototype.has(self, key)
        return self.items[key] ~= nil
    end
    function WeakMap.prototype.set(self, key, value)
        self.items[key] = value
        return self
    end
    WeakMap[Symbol.species] = WeakMap
end

local WeakSet
do
    WeakSet = __TS__Class()
    WeakSet.name = "WeakSet"
    function WeakSet.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "WeakSet"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self.items[result.value] = true
            end
        else
            for ____, value in ipairs(values) do
                self.items[value] = true
            end
        end
    end
    function WeakSet.prototype.add(self, value)
        self.items[value] = true
        return self
    end
    function WeakSet.prototype.delete(self, value)
        local contains = self:has(value)
        self.items[value] = nil
        return contains
    end
    function WeakSet.prototype.has(self, value)
        return self.items[value] == true
    end
    WeakSet[Symbol.species] = WeakSet
end

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. message)
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap and fileSourceMap[line] then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (tostring(data.file) .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "(%S+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap and fileSourceMap[line] then
                    local chunkName = __TS__Match(file, "%[string \"([^\"]+)\"%]")
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (tostring(data.file) .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end

local function __TS__Spread(iterable)
    local arr = {}
    if type(iterable) == "string" then
        for i = 0, #iterable - 1 do
            arr[i + 1] = __TS__StringAccess(iterable, i)
        end
    else
        local len = 0
        for ____, item in __TS__Iterator(iterable) do
            len = len + 1
            arr[len] = item
        end
    end
    return __TS__Unpack(arr)
end

local function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

local function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    return string.byte(self, index + 1) or 0 / 0
end

local function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

local function __TS__StringPadEnd(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return self .. string.sub(
        fillString,
        1,
        math.floor(maxLength)
    )
end

local function __TS__StringPadStart(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return string.sub(
        fillString,
        1,
        math.floor(maxLength)
    ) .. self
end

local __TS__StringReplace
do
    local sub = string.sub
    function __TS__StringReplace(source, searchValue, replaceValue)
        local startPos, endPos = string.find(source, searchValue, nil, true)
        if not startPos then
            return source
        end
        local before = sub(source, 1, startPos - 1)
        local ____temp_0
        if type(replaceValue) == "string" then
            ____temp_0 = replaceValue
        else
            ____temp_0 = replaceValue(nil, searchValue, startPos - 1, source)
        end
        local replacement = ____temp_0
        local after = sub(source, endPos + 1)
        return (before .. replacement) .. after
    end
end

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local __TS__StringReplaceAll
do
    local sub = string.sub
    local find = string.find
    function __TS__StringReplaceAll(source, searchValue, replaceValue)
        if type(replaceValue) == "string" then
            local concat = table.concat(
                __TS__StringSplit(source, searchValue),
                replaceValue
            )
            if #searchValue == 0 then
                return (replaceValue .. concat) .. replaceValue
            end
            return concat
        end
        local parts = {}
        local partsIndex = 1
        if #searchValue == 0 then
            parts[1] = replaceValue(nil, "", 0, source)
            partsIndex = 2
            for i = 1, #source do
                parts[partsIndex] = sub(source, i, i)
                parts[partsIndex + 1] = replaceValue(nil, "", i, source)
                partsIndex = partsIndex + 2
            end
        else
            local currentPos = 1
            while true do
                local startPos, endPos = find(source, searchValue, currentPos, true)
                if not startPos then
                    break
                end
                parts[partsIndex] = sub(source, currentPos, startPos - 1)
                parts[partsIndex + 1] = replaceValue(nil, searchValue, startPos - 1, source)
                partsIndex = partsIndex + 2
                currentPos = endPos + 1
            end
            parts[partsIndex] = sub(source, currentPos)
        end
        return table.concat(parts)
    end
end

local function __TS__StringSlice(self, start, ____end)
    if start == nil or start ~= start then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

local function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if length ~= length or length <= 0 then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

local function __TS__StringTrimEnd(self)
    local result = string.gsub(self, "[%s ﻿]*$", "")
    return result
end

local function __TS__StringTrimStart(self)
    local result = string.gsub(self, "^[%s ﻿]*", "")
    return result
end

local __TS__SymbolRegistryFor, __TS__SymbolRegistryKeyFor
do
    local symbolRegistry = {}
    function __TS__SymbolRegistryFor(key)
        if not symbolRegistry[key] then
            symbolRegistry[key] = __TS__Symbol(key)
        end
        return symbolRegistry[key]
    end
    function __TS__SymbolRegistryKeyFor(sym)
        for key in pairs(symbolRegistry) do
            if symbolRegistry[key] == sym then
                return key
            end
        end
    end
end

local function __TS__TypeOf(value)
    local luaType = type(value)
    if luaType == "table" then
        return "object"
    elseif luaType == "nil" then
        return "undefined"
    else
        return luaType
    end
end

return {
  __TS__ArrayConcat = __TS__ArrayConcat,
  __TS__ArrayEntries = __TS__ArrayEntries,
  __TS__ArrayEvery = __TS__ArrayEvery,
  __TS__ArrayFilter = __TS__ArrayFilter,
  __TS__ArrayForEach = __TS__ArrayForEach,
  __TS__ArrayFind = __TS__ArrayFind,
  __TS__ArrayFindIndex = __TS__ArrayFindIndex,
  __TS__ArrayFrom = __TS__ArrayFrom,
  __TS__ArrayIncludes = __TS__ArrayIncludes,
  __TS__ArrayIndexOf = __TS__ArrayIndexOf,
  __TS__ArrayIsArray = __TS__ArrayIsArray,
  __TS__ArrayJoin = __TS__ArrayJoin,
  __TS__ArrayMap = __TS__ArrayMap,
  __TS__ArrayPush = __TS__ArrayPush,
  __TS__ArrayPushArray = __TS__ArrayPushArray,
  __TS__ArrayReduce = __TS__ArrayReduce,
  __TS__ArrayReduceRight = __TS__ArrayReduceRight,
  __TS__ArrayReverse = __TS__ArrayReverse,
  __TS__ArrayUnshift = __TS__ArrayUnshift,
  __TS__ArraySort = __TS__ArraySort,
  __TS__ArraySlice = __TS__ArraySlice,
  __TS__ArraySome = __TS__ArraySome,
  __TS__ArraySplice = __TS__ArraySplice,
  __TS__ArrayToObject = __TS__ArrayToObject,
  __TS__ArrayFlat = __TS__ArrayFlat,
  __TS__ArrayFlatMap = __TS__ArrayFlatMap,
  __TS__ArraySetLength = __TS__ArraySetLength,
  __TS__AsyncAwaiter = __TS__AsyncAwaiter,
  __TS__Await = __TS__Await,
  __TS__Class = __TS__Class,
  __TS__ClassExtends = __TS__ClassExtends,
  __TS__CloneDescriptor = __TS__CloneDescriptor,
  __TS__CountVarargs = __TS__CountVarargs,
  __TS__Decorate = __TS__Decorate,
  __TS__DecorateParam = __TS__DecorateParam,
  __TS__Delete = __TS__Delete,
  __TS__DelegatedYield = __TS__DelegatedYield,
  Error = Error,
  RangeError = RangeError,
  ReferenceError = ReferenceError,
  SyntaxError = SyntaxError,
  TypeError = TypeError,
  URIError = URIError,
  __TS__FunctionBind = __TS__FunctionBind,
  __TS__Generator = __TS__Generator,
  __TS__InstanceOf = __TS__InstanceOf,
  __TS__InstanceOfObject = __TS__InstanceOfObject,
  __TS__Iterator = __TS__Iterator,
  __TS__LuaIteratorSpread = __TS__LuaIteratorSpread,
  Map = Map,
  __TS__Match = __TS__Match,
  __TS__MathAtan2 = __TS__MathAtan2,
  __TS__MathModf = __TS__MathModf,
  __TS__MathSign = __TS__MathSign,
  __TS__New = __TS__New,
  __TS__Number = __TS__Number,
  __TS__NumberIsFinite = __TS__NumberIsFinite,
  __TS__NumberIsNaN = __TS__NumberIsNaN,
  __TS__NumberToString = __TS__NumberToString,
  __TS__ObjectAssign = __TS__ObjectAssign,
  __TS__ObjectDefineProperty = __TS__ObjectDefineProperty,
  __TS__ObjectEntries = __TS__ObjectEntries,
  __TS__ObjectFromEntries = __TS__ObjectFromEntries,
  __TS__ObjectGetOwnPropertyDescriptor = __TS__ObjectGetOwnPropertyDescriptor,
  __TS__ObjectGetOwnPropertyDescriptors = __TS__ObjectGetOwnPropertyDescriptors,
  __TS__ObjectKeys = __TS__ObjectKeys,
  __TS__ObjectRest = __TS__ObjectRest,
  __TS__ObjectValues = __TS__ObjectValues,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__ParseInt = __TS__ParseInt,
  __TS__Promise = __TS__Promise,
  __TS__PromiseAll = __TS__PromiseAll,
  __TS__PromiseAllSettled = __TS__PromiseAllSettled,
  __TS__PromiseAny = __TS__PromiseAny,
  __TS__PromiseRace = __TS__PromiseRace,
  Set = Set,
  __TS__SetDescriptor = __TS__SetDescriptor,
  __TS__SparseArrayNew = __TS__SparseArrayNew,
  __TS__SparseArrayPush = __TS__SparseArrayPush,
  __TS__SparseArraySpread = __TS__SparseArraySpread,
  WeakMap = WeakMap,
  WeakSet = WeakSet,
  __TS__SourceMapTraceBack = __TS__SourceMapTraceBack,
  __TS__Spread = __TS__Spread,
  __TS__StringAccess = __TS__StringAccess,
  __TS__StringCharAt = __TS__StringCharAt,
  __TS__StringCharCodeAt = __TS__StringCharCodeAt,
  __TS__StringEndsWith = __TS__StringEndsWith,
  __TS__StringIncludes = __TS__StringIncludes,
  __TS__StringPadEnd = __TS__StringPadEnd,
  __TS__StringPadStart = __TS__StringPadStart,
  __TS__StringReplace = __TS__StringReplace,
  __TS__StringReplaceAll = __TS__StringReplaceAll,
  __TS__StringSlice = __TS__StringSlice,
  __TS__StringSplit = __TS__StringSplit,
  __TS__StringStartsWith = __TS__StringStartsWith,
  __TS__StringSubstr = __TS__StringSubstr,
  __TS__StringSubstring = __TS__StringSubstring,
  __TS__StringTrim = __TS__StringTrim,
  __TS__StringTrimEnd = __TS__StringTrimEnd,
  __TS__StringTrimStart = __TS__StringTrimStart,
  __TS__Symbol = __TS__Symbol,
  Symbol = Symbol,
  __TS__SymbolRegistryFor = __TS__SymbolRegistryFor,
  __TS__SymbolRegistryKeyFor = __TS__SymbolRegistryKeyFor,
  __TS__TypeOf = __TS__TypeOf,
  __TS__Unpack = __TS__Unpack
}
 end,
["constants"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.HIGHLIGHT_COLORS = {
    "#12C2E9",
    "#30B5EA",
    "#4DA7EA",
    "#6B9AEB",
    "#898CEC",
    "#A67FEC",
    "#C471ED",
    "#CC6BD4",
    "#D566BC",
    "#DD60A3",
    "#E55A8A",
    "#EE5572",
    "#F64F59",
    "#EE5572",
    "#E55A8A",
    "#DD60A3",
    "#D566BC",
    "#CC6BD4",
    "#C471ED",
    "#A67FEC",
    "#898CEC",
    "#6B9AEB",
    "#4DA7EA",
    "#30B5EA"
}
return ____exports
 end,
["icons"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local devicons = require("nvim-web-devicons")
local icons = devicons:get_icons()
local defaultIcon = {icon = "", color = "#6E6E6E"}
function ____exports.getIcon(self, filename, extname)
    return icons[filename] or icons[string.sub(extname, 2)] or defaultIcon
end
return ____exports
 end,
["pick"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArraySort = ____lualib.__TS__ArraySort
local ____exports = {}
local fzy = require("fzy-lua-native")
function ____exports.getEntries(opts, args)
    local entries
    if opts.values ~= nil then
        local valuesOpt = opts.values
        local values = type(valuesOpt) == "function" and valuesOpt(unpack(args)) or valuesOpt
        entries = __TS__ArrayMap(
            values,
            function(____, v) return {label = v, text = v, value = v} end
        )
    else
        local entriesOpt = opts.entries
        entries = type(entriesOpt) == "function" and entriesOpt(unpack(args)) or entriesOpt
    end
    return entries
end
function ____exports.onChangeFZY(selector, input)
    local sensitive = input ~= string.lower(input)
    local filtered = __TS__ArrayFilter(
        selector.initialEntries,
        function(____, e, i)
            local hasMatch = fzy.has_match(input, e.text, sensitive)
            if hasMatch then
                e.score = fzy.score(input, e.text, sensitive)
                e.positions = fzy.positions(input, e.text, sensitive)
                __TS__ArrayForEach(
                    e.positions,
                    function(____, _, i)
                        local ____e_positions_0, ____temp_1 = e.positions, i + 1
                        ____e_positions_0[____temp_1] = ____e_positions_0[____temp_1] - 1
                    end
                )
            end
            return hasMatch
        end
    )
    __TS__ArraySort(
        filtered,
        function(____, a, b) return (b.score or 0) - (a.score or 0) end
    )
    selector:setEntries(filtered)
end
return ____exports
 end,
["components.Selector"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__New = ____lualib.__TS__New
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local ____exports = {}
local getWindowDimensions, clamp
local ____kui = require("kui")
local settings = ____kui.settings
local editor = ____kui.editor
local EventEmitter = ____kui.EventEmitter
local Renderer = ____kui.Renderer
local Container = ____kui.Container
local Graphics = ____kui.Graphics
local Text = ____kui.Text
local TextStyle = ____kui.TextStyle
local Input = ____kui.Input
local ____constants = require("constants")
local HIGHLIGHT_COLORS = ____constants.HIGHLIGHT_COLORS
local ____pick = require("pick")
local onChangeFZY = ____pick.onChangeFZY
function getWindowDimensions(self)
    local row, col = unpack(vim.fn.win_screenpos(0))
    local width = vim.fn.winwidth(0)
    local height = vim.fn.winheight(0)
    return {row = row, col = col, width = width, height = height}
end
function clamp(self, min, max, value)
    return math.max(
        min,
        math.min(max, value)
    )
end
local cellPixels = settings.DIMENSIONS.cell_pixels
local screenCells = settings.DIMENSIONS.screen_cells
local setKeymap = vim.api.nvim_buf_set_keymap
local COLOR = {FOCUS = 1919121}
local DESIRED_CELL_WIDTH = 100
____exports.Selector = __TS__Class()
local Selector = ____exports.Selector
Selector.name = "Selector"
__TS__ClassExtends(Selector, EventEmitter)
function Selector.prototype.____constructor(self, opts)
    EventEmitter.prototype.____constructor(self)
    self.onMountInput = function(____, bufferId)
        setKeymap(
            bufferId,
            "i",
            "<CR>",
            "<Esc>:lua require(\"kirby\").selector:accept()<CR>",
            {noremap = true, silent = true}
        )
        setKeymap(
            bufferId,
            "i",
            "<Esc>",
            "<Esc>:lua require(\"kirby\").selector:close()<CR>",
            {noremap = true, silent = true}
        )
        setKeymap(
            bufferId,
            "i",
            "<A-j>",
            "<C-o>:lua require(\"kirby\").selector:select(1)<CR>",
            {noremap = true, silent = true}
        )
        setKeymap(
            bufferId,
            "i",
            "<A-k>",
            "<C-o>:lua require(\"kirby\").selector:select(-1)<CR>",
            {noremap = true, silent = true}
        )
        vim.cmd("startinsert")
    end
    self.opts = __TS__ObjectAssign({}, opts)
    self.opts.prefix = opts.prefix or ""
    local ____self_opts_1 = self.opts
    local ____temp_0
    if opts.singleLine == nil then
        ____temp_0 = true
    else
        ____temp_0 = opts.singleLine
    end
    ____self_opts_1.singleLine = ____temp_0
    opts = self.opts
    local cw = cellPixels.width
    local ch = cellPixels.height
    local window = getWindowDimensions(nil)
    local marginHorizontal = 5
    local row = window.row + 2
    local col = window.col + marginHorizontal
    local availableWidth = window.width
    local desiredCellWidth = opts.width or DESIRED_CELL_WIDTH
    local ____temp_2 = clamp(nil, 10, availableWidth - marginHorizontal * 2, desiredCellWidth) * cw
    self.width = ____temp_2
    local width = ____temp_2
    local ____temp_3 = 20 * ch
    self.height = ____temp_3
    local height = ____temp_3
    local ____temp_4 = 2 * cw
    self.paddingX = ____temp_4
    local paddingX = ____temp_4
    local ____temp_5 = 1 * ch
    self.paddingY = ____temp_5
    local paddingY = ____temp_5
    self.iconWidth = opts.hasIcon and (opts.singleLine and 4 * cw or 3 * cw) or 0
    self.textPaddingX = self.paddingX + self.iconWidth
    local ____TS__New_result_6 = __TS__New(Renderer, {col = col, row = row, width = width, height = height})
    self.renderer = ____TS__New_result_6
    local renderer = ____TS__New_result_6
    local ____TS__New_result_7 = __TS__New(Container)
    self.stage = ____TS__New_result_7
    local stage = ____TS__New_result_7
    local hlFloat = editor:getHighlight("NormalFloat")
    local backgroundColor = hlFloat.background or 4408131
    local foregroundColor = hlFloat.foreground or 16777215
    local borderColor = backgroundColor + 3158064
    local titleTextColor = 13421772
    self.separatorColor = backgroundColor + 3158064
    local background = stage:addChild(__TS__New(Graphics))
    background.x = 0
    background.y = 0
    background:beginFill(backgroundColor)
    background:drawRoundedRect(
        0,
        0,
        width,
        height,
        20
    )
    background:endFill()
    background:lineStyle(2, borderColor, 1)
    background:drawRoundedRect(
        0,
        0,
        width,
        height,
        20
    )
    local prefix = opts.prefix
    local inputX = paddingX + #prefix * cw
    local ____temp_8 = stage:addChild(__TS__New(Input, {width = width - 4 * cw - #prefix * cw, color = foregroundColor}))
    self.input = ____temp_8
    local input = ____temp_8
    input.x = inputX
    input.y = 1 * ch
    input:onMount(self.onMountInput)
    self.focus = nil
    if opts.name ~= nil then
        local name = __TS__New(
            Text,
            opts.name,
            __TS__New(TextStyle, {fill = titleTextColor, fontSize = settings.DEFAULT_FONT_SIZE * 0.8})
        )
        name.x = inputX
        name.y = 0
        stage:addChild(name)
    end
    if opts.prefix ~= nil then
        local color = opts.prefixColor == nil and titleTextColor or (type(opts.prefixColor) == "number" and opts.prefixColor or (editor:getHighlight(opts.prefixColor).foreground or 16777215))
        local prefix = __TS__New(
            Text,
            opts.prefix,
            __TS__New(TextStyle, {fill = color})
        )
        prefix.x = paddingX
        prefix.y = 1 * ch
        stage:addChild(prefix)
    end
    local containerY = input.y + input.height + 0.5 * ch
    local containerHeight = height - containerY - paddingY
    local ____temp_9 = stage:addChild(__TS__New(Graphics))
    self.container = ____temp_9
    local container = ____temp_9
    container.x = 0
    container.y = input.y + input.height + 0.5 * ch
    self.labelStyle = __TS__New(TextStyle, {fill = foregroundColor})
    self.detailsStyle = __TS__New(TextStyle, {fill = foregroundColor - 4210752, fontSize = opts.singleLine and settings.DEFAULT_FONT_SIZE or settings.DEFAULT_FONT_SIZE * 0.9})
    self.didInit = false
    self.initialEntries = {}
    self.entries = {}
    self.maxEntries = math.floor(containerHeight / ch)
    self.activeIndex = -1
    self.entryHeight = self.opts.singleLine and 2 * ch or 3 * ch
    renderer:render(stage)
    self:onAccept(opts.onAccept)
    self:onChange(opts.onChange or onChangeFZY)
end
function Selector.prototype.onChange(self, fn)
    local ____self = self
    self.input:onChange(function(self, input)
        fn(____self, input)
    end)
end
function Selector.prototype.onDidClose(self, fn)
    self:on("didClose", fn)
end
function Selector.prototype.onAccept(self, callback)
    local fn = type(callback) == "function" and callback or (function(____, entry)
        vim.cmd((callback .. " ") .. entry.text)
    end)
    self:on("accept", fn)
end
function Selector.prototype.accept(self)
    self:close()
    local entry = self.entries[self.activeIndex + 1]
    if entry ~= nil then
        self:emit("accept", entry)
    end
end
function Selector.prototype.select(self, direction)
    if self.activeIndex == -1 or not self.focus then
        return
    end
    self.activeIndex = self.activeIndex + direction
    if self.activeIndex < 0 then
        self.activeIndex = self.activeIndex + #self.entries
    end
    if self.activeIndex >= #self.entries then
        self.activeIndex = self.activeIndex - #self.entries
    end
    self.focus.y = self.activeIndex * self.entryHeight
    self:render()
end
function Selector.prototype.setInitialEntries(self, entries)
    self.didInit = true
    self.initialEntries = entries
    self:setEntries(self.initialEntries)
end
function Selector.prototype.drawMessage(self, message)
    local style = __TS__New(
        TextStyle,
        {
            fill = editor:getHighlight("comment").foreground or 16777215,
            fontSize = settings.DEFAULT_FONT_SIZE
        }
    )
    local textEntry = self.container:addChild(__TS__New(Text, message, style))
    textEntry.y = 0.5 * cellPixels.height
    textEntry.x = self.textPaddingX
end
function Selector.prototype.setEntries(self, entries)
    local isEmpty = #entries == 0
    self.entries = entries
    self.activeIndex = not isEmpty and 0 or -1
    local cw = cellPixels.width
    local ch = cellPixels.height
    local container = self.container
    while #container.children > 0 do
        container:removeChildAt(0)
    end
    if isEmpty then
        self:drawMessage(self.didInit and "No results" or "Loading entries...")
        self:render()
        return
    end
    local ____self_opts_10 = self.opts
    local hasIcon = ____self_opts_10.hasIcon
    local singleLine = ____self_opts_10.singleLine
    local function yForIndex(____, i)
        return i * self.entryHeight
    end
    if not isEmpty then
        local ____temp_11 = container:addChild(__TS__New(Graphics))
        self.focus = ____temp_11
        local focus = ____temp_11
        focus.y = yForIndex(nil, self.activeIndex)
        local bg = focus:addChild(__TS__New(Graphics))
        bg:beginFill(COLOR.FOCUS)
        bg:drawRect(0 - 5, 0, self.width + 10, self.entryHeight)
    end
    local i = 0
    for ____, entry in ipairs(entries) do
        local line = container:addChild(__TS__New(Container))
        line.y = yForIndex(nil, i)
        local currentX = self.paddingX
        if hasIcon then
            if entry.icon then
                local style = self.labelStyle:clone()
                if entry.iconColor then
                    style.fill = __TS__ParseInt(
                        string.sub(entry.iconColor, 2),
                        16
                    )
                end
                if not singleLine then
                    style.fontSize = settings.DEFAULT_FONT_SIZE * 1.2
                end
                local textIcon = line:addChild(__TS__New(Text, entry.icon, style))
                textIcon.x = singleLine and currentX or 1.5 * cw
                textIcon.y = singleLine and 0 or 0.8 * ch
            end
            currentX = currentX + self.iconWidth
        end
        do
            local label = entry.label
            local textEntry = line:addChild(__TS__New(Text, label, self.labelStyle))
            textEntry.y = singleLine and 0.5 * ch or 0.5 * ch
            textEntry.x = currentX
            currentX = currentX + textEntry.width
        end
        currentX = currentX + 1 * cw
        if entry.details ~= nil then
            local details = entry.details
            local textEntry = line:addChild(__TS__New(Text, details, self.detailsStyle))
            if not singleLine then
                textEntry.y = 1.5 * ch
                textEntry.x = self.textPaddingX
            else
                textEntry.y = 0.5 * ch
                textEntry.x = currentX
            end
            currentX = currentX + textEntry.width
        end
        do
            local separator = line:addChild(__TS__New(Graphics))
            separator.x = 0
            separator.y = 0
            separator:lineStyle(2, self.separatorColor, 0.5)
            separator:moveTo(0, 0)
            separator:lineTo(self.width, 0)
        end
        if i + 1 == self.maxEntries or entry == entries[#entries] then
            local separator = line:addChild(__TS__New(Graphics))
            separator.x = 0
            separator.y = self.entryHeight
            separator:lineStyle(2, self.separatorColor, 0.5)
            separator:moveTo(0, 0)
            separator:lineTo(self.width, 0)
        end
        i = i + 1
        if i >= self.maxEntries then
            break
        end
    end
    self:render()
end
function Selector.prototype.render(self)
    self.renderer:render(self.stage)
end
function Selector.prototype.close(self)
    local ____opt_12 = self.input
    if ____opt_12 ~= nil then
        ____opt_12:destroy()
    end
    local ____opt_14 = self.stage
    if ____opt_14 ~= nil then
        ____opt_14:destroy()
    end
    local ____opt_16 = self.renderer
    if ____opt_16 ~= nil then
        ____opt_16:destroy()
    end
    self:emit("didClose")
end
local labelHlStyle = nil
local function getLabelHighlightStyles(self, baseStyle)
    if labelHlStyle then
        return labelHlStyle
    end
    labelHlStyle = __TS__ArrayMap(
        HIGHLIGHT_COLORS,
        function(____, color)
            local style = baseStyle:clone()
            style.fill = color
            return style
        end
    )
    return labelHlStyle
end
local detailsHlStyle = nil
local function getDetailsHighlightStyles(self, baseStyle)
    if detailsHlStyle then
        return detailsHlStyle
    end
    detailsHlStyle = __TS__ArrayMap(
        HIGHLIGHT_COLORS,
        function(____, color)
            local style = baseStyle:clone()
            style.fill = color
            style.fontWeight = "bold"
            return style
        end
    )
    return detailsHlStyle
end
return ____exports
 end,
["types"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
return ____exports
 end,
["utils.lastIndexOf"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.default(self, haystack, needle)
    local i = -1
    local j = -1
    local k = 0
    repeat
        do
            i = j
            j, k = string.find(haystack, needle, k + 1, true)
        end
    until not (j ~= nil)
    if i ~= -1 then
        return i - 1
    end
    return i
end
return ____exports
 end,
["path.posix"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__StringAccess = ____lualib.__TS__StringAccess
local __TS__StringSlice = ____lualib.__TS__StringSlice
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__StringSubstr = ____lualib.__TS__StringSubstr
local __TS__ArrayConcat = ____lualib.__TS__ArrayConcat
local __TS__TypeOf = ____lualib.__TS__TypeOf
local ____exports = {}
local ____lastIndexOf = require("utils.lastIndexOf")
local lastIndexOf = ____lastIndexOf.default
function ____exports.isAbsolute(self, path)
    return string.sub(path, 1, 1) == "/"
end
local function isString(____, value)
    return type(value) == "string"
end
local function isObject(____, value)
    return type(value) == "table"
end
local function normalizeArray(self, parts, allowAboveRoot)
    local res = {}
    do
        local i = 0
        while i < #parts do
            do
                local p = parts[i + 1]
                if not p or p == "." then
                    goto __continue5
                end
                if p == ".." then
                    if #res and res[#res] ~= ".." then
                        table.remove(res)
                    elseif allowAboveRoot then
                        res[#res + 1] = ".."
                    end
                else
                    res[#res + 1] = p
                end
            end
            ::__continue5::
            i = i + 1
        end
    end
    return res
end
local function trimArray(self, arr)
    local lastIndex = #arr - 1
    local start = 0
    do
        while start <= lastIndex do
            if arr[start + 1] then
                break
            end
            start = start + 1
        end
    end
    local ____end = lastIndex
    do
        while ____end >= 0 do
            if arr[____end + 1] then
                break
            end
            ____end = ____end - 1
        end
    end
    if start == 0 and ____end == lastIndex then
        return arr
    end
    if start > ____end then
        return {}
    end
    return __TS__ArraySlice(arr, start, ____end + 1)
end
____exports.sep = "/"
____exports.delimiter = ":"
local function posixSplitPath(self, filepath)
    local root = __TS__StringAccess(filepath, 0) == "/" and "/" or ""
    local lastSeparator = lastIndexOf(nil, filepath, ____exports.sep)
    local dirname = lastSeparator == -1 and "" or __TS__StringSlice(filepath, #root, lastSeparator + 1)
    local filename = __TS__StringSlice(filepath, lastSeparator + 1)
    local lastDot = lastIndexOf(nil, filepath, ".")
    local _extname = __TS__StringSlice(filepath, lastDot)
    local extname = lastDot == -1 and "" or (_extname == filename and "" or _extname)
    return {root, dirname, filename, extname}
end
function ____exports.resolve(self, ...)
    local args = {...}
    local resolvedPath = ""
    local resolvedAbsolute = false
    do
        local i = #args - 1
        while i >= -1 and not resolvedAbsolute do
            do
                local path = i >= 0 and args[i + 1] or os.getenv("PWD")
                if not isString(nil, path) then
                    error(
                        __TS__New(TypeError, "Arguments to path.resolve must be strings"),
                        0
                    )
                elseif not path then
                    goto __continue20
                end
                resolvedPath = (path .. "/") .. resolvedPath
                resolvedAbsolute = __TS__StringAccess(path, 0) == "/"
            end
            ::__continue20::
            i = i - 1
        end
    end
    resolvedPath = table.concat(
        normalizeArray(
            nil,
            __TS__StringSplit(resolvedPath, "/"),
            not resolvedAbsolute
        ),
        "/"
    )
    return (resolvedAbsolute and "/" or "") .. resolvedPath or "."
end
function ____exports.normalize(self, path)
    local isAbsolute_ = ____exports.isAbsolute(nil, path)
    local trailingSlash = path and __TS__StringAccess(path, #path - 1) == "/"
    path = table.concat(
        normalizeArray(
            nil,
            __TS__StringSplit(path, "/"),
            not ____exports.isAbsolute
        ),
        "/"
    )
    if not path and not ____exports.isAbsolute then
        path = "."
    end
    if path and trailingSlash then
        path = path .. "/"
    end
    return (isAbsolute_ and "/" or "") .. path
end
function ____exports.join(self, ...)
    local args = {...}
    local path = ""
    do
        local i = 0
        while i < #args do
            local segment = args[i + 1]
            if not isString(nil, segment) then
                error(
                    __TS__New(TypeError, "Arguments to path.join must be strings"),
                    0
                )
            end
            if segment ~= nil and segment ~= "" then
                if not path then
                    path = path .. segment
                else
                    path = path .. "/" .. segment
                end
            end
            i = i + 1
        end
    end
    return ____exports.normalize(nil, path)
end
function ____exports.relative(self, from, to)
    from = __TS__StringSubstr(
        ____exports.resolve(nil, from),
        1
    )
    to = __TS__StringSubstr(
        ____exports.resolve(nil, to),
        1
    )
    local fromParts = trimArray(
        nil,
        __TS__StringSplit(from, "/")
    )
    local toParts = trimArray(
        nil,
        __TS__StringSplit(to, "/")
    )
    local length = math.min(#fromParts, #toParts)
    local samePartsLength = length
    do
        local i = 0
        while i < length do
            if fromParts[i + 1] ~= toParts[i + 1] then
                samePartsLength = i
                break
            end
            i = i + 1
        end
    end
    local outputParts = {}
    do
        local i = samePartsLength
        while i < #fromParts do
            outputParts[#outputParts + 1] = ".."
            i = i + 1
        end
    end
    outputParts = __TS__ArrayConcat(
        outputParts,
        __TS__ArraySlice(toParts, samePartsLength)
    )
    return table.concat(outputParts, "/")
end
function ____exports._makeLong(self, path)
    return path
end
function ____exports.dirname(self, path)
    local result = posixSplitPath(nil, path)
    local root = result[1]
    local dir = result[2]
    if not root and not dir then
        return "."
    end
    if dir ~= nil and dir ~= "" then
        dir = __TS__StringSubstr(dir, 0, #dir - 1)
    end
    return root .. dir
end
function ____exports.basename(self, path, ext)
    local f = posixSplitPath(nil, path)[3]
    if ext and __TS__StringSubstr(f, -1 * #ext) == ext then
        f = __TS__StringSubstr(f, 0, #f - #ext)
    end
    return f
end
function ____exports.extname(self, path)
    return posixSplitPath(nil, path)[4]
end
function ____exports.format(self, _pathObject)
    error(
        __TS__New(Error, "unimplemented"),
        0
    )
end
function ____exports.parse(self, pathString)
    if not isString(nil, pathString) then
        error(
            __TS__New(
                TypeError,
                "Parameter 'pathString' must be a string, not " .. __TS__TypeOf(pathString)
            ),
            0
        )
    end
    local allParts = posixSplitPath(nil, pathString)
    if not allParts or #allParts ~= 4 then
        error(
            __TS__New(TypeError, ("Invalid path '" .. pathString) .. "'"),
            0
        )
    end
    allParts[2] = allParts[2] or ""
    allParts[3] = allParts[3] or ""
    allParts[4] = allParts[4] or ""
    return {
        root = allParts[1],
        dir = allParts[1] .. string.sub(allParts[2], 1, -2),
        base = allParts[3],
        ext = allParts[4],
        name = __TS__StringSlice(allParts[3], 0, #allParts[3] - #allParts[4])
    }
end
____exports.default = {
    sep = ____exports.sep,
    delimiter = ____exports.delimiter,
    resolve = ____exports.resolve,
    normalize = ____exports.normalize,
    isAbsolute = ____exports.isAbsolute,
    join = ____exports.join,
    relative = ____exports.relative,
    _makeLong = ____exports._makeLong,
    dirname = ____exports.dirname,
    basename = ____exports.basename,
    extname = ____exports.extname,
    format = ____exports.format,
    parse = ____exports.parse
}
return ____exports
 end,
["path.index"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____posix = require("path.posix")
local posix = ____posix.default
do
    local ____export = require("path.posix")
    for ____exportKey, ____exportValue in pairs(____export) do
        if ____exportKey ~= "default" then
            ____exports[____exportKey] = ____exportValue
        end
    end
end
____exports.default = posix
return ____exports
 end,
["pickers.file"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySort = ____lualib.__TS__ArraySort
local ____exports = {}
local ____path = require("path.index")
local path = ____path.default
local ____icons = require("icons")
local getIcon = ____icons.getIcon
local fileCommand = vim.fn.executable("fd") ~= 0 and "fd -t f" or "git ls-files"
____exports.default = {
    id = "file",
    prefix = "Open ",
    prefixColor = "comment",
    hasIcon = true,
    singleLine = false,
    entries = function(args)
        local directory = unpack(args)
        if directory == nil then
            directory = "."
        end
        local entries = __TS__ArrayMap(
            __TS__StringSplit(
                __TS__StringTrim(vim.fn.system((("cd " .. tostring(directory)) .. " && ") .. fileCommand)),
                "\n"
            ),
            function(____, line)
                local parsed = path:parse(line)
                local ____getIcon_result_0 = getIcon(nil, parsed.base, parsed.ext)
                local icon = ____getIcon_result_0.icon
                local color = ____getIcon_result_0.color
                local directory = __TS__StringTrim(parsed.dir)
                if not directory or directory == "" then
                    directory = "."
                end
                directory = directory .. "/ "
                return {
                    icon = icon,
                    iconColor = color,
                    label = parsed.base,
                    details = directory,
                    text = line,
                    value = line,
                    labelOffset = #parsed.dir > 0 and #parsed.dir + 1 or 0,
                    detailsOffset = 0
                }
            end
        )
        __TS__ArraySort(
            entries,
            function(____, a, b)
                return #a.text - #b.text
            end
        )
        return entries
    end,
    onAccept = "edit"
}
return ____exports
 end,
["pickers.ctags"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__StringTrimStart = ____lualib.__TS__StringTrimStart
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySort = ____lualib.__TS__ArraySort
local ____exports = {}
local currentFile = {
    id = "ctags-current-file",
    prefix = "Jump to ",
    prefixColor = "comment",
    hasIcon = false,
    singleLine = true,
    entries = function()
        local file = vim.fn.bufname(0)
        if not file or file == "" then
            return {}
        end
        local lines = __TS__StringSplit(
            __TS__StringTrim(vim.fn.system("ctags --excmd=combine -f- " .. file)),
            "\n"
        )
        local entries = __TS__ArrayMap(
            lines,
            function(____, line)
                local symbol, _file, address, _type = unpack(__TS__StringSplit(line, "\t"))
                local addressParts = __TS__StringSplit(address, ";")
                local lineNumber = __TS__ParseInt(addressParts[1])
                local rest = table.concat(
                    __TS__ArraySlice(addressParts, 1),
                    ";"
                )
                local pattern = string.sub(
                    string.sub(rest, 3),
                    1,
                    -5
                )
                local code = __TS__StringTrim(pattern)
                local columnNumber = #pattern - #__TS__StringTrimStart(pattern)
                return {
                    label = symbol,
                    details = (tostring(lineNumber) .. ": ") .. code,
                    text = symbol,
                    value = symbol,
                    data = {lineNumber = lineNumber, columnNumber = columnNumber}
                }
            end
        )
        __TS__ArraySort(
            entries,
            function(____, a, b)
                return a.data.lineNumber - b.data.lineNumber
            end
        )
        return entries
    end,
    onAccept = function(____, entry)
        vim.api.nvim_win_set_cursor(0, {entry.data.lineNumber, entry.data.columnNumber})
    end
}
____exports.default = {currentFile = currentFile}
return ____exports
 end,
["index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local ____exports = {}
local ____Selector = require("components.Selector")
local Selector = ____Selector.Selector
local ____pick = require("pick")
local getEntries = ____pick.getEntries
local onChangeFZY = ____pick.onChangeFZY
local ____file = require("pickers.file")
local file = ____file.default
local ____ctags = require("pickers.ctags")
local ctags = ____ctags.default
____exports.selector = nil
____exports.pickers = {}
function ____exports.open(opts, ...)
    local args = {...}
    local ____opt_0 = ____exports.selector
    if ____opt_0 ~= nil then
        ____exports.selector:close()
    end
    ____exports.selector = __TS__New(Selector, opts)
    ____exports.selector:setInitialEntries(getEntries(opts, args))
    ____exports.selector:onChange(onChangeFZY)
    ____exports.selector:onDidClose(function()
        ____exports.selector = nil
    end)
end
function ____exports.listPickers(self)
    return __TS__ObjectKeys(____exports.pickers)
end
function ____exports.close(self)
    local ____opt_2 = ____exports.selector
    if ____opt_2 ~= nil then
        ____exports.selector:close()
    end
    ____exports.selector = nil
end
function ____exports.register(opts)
    ____exports.pickers[opts.id] = opts
end
function ____exports.openPickerByID(id, ...)
    local args = {...}
    if ____exports.pickers[id] ~= nil then
        ____exports.open(____exports.pickers[id], args)
    else
        print("Could not find picker " .. id)
    end
end
____exports.register(file)
____exports.register(ctags.currentFile)
function ____exports.openFilePicker(directory)
    if directory == nil then
        directory = "."
    end
    ____exports.openPickerByID("file", directory)
end
return ____exports
 end,
}
return require("index", ...)
