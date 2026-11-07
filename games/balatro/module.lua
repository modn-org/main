local fs = mods_host.fs
local dir = mods_host.directory

local policy = {
    game_id = "balatro",
    api_version = mods_host.api_version,
    version = "0.1.0",
    marker = "Balatro.exe",
    steam_manifest = "steamapps/appmanifest_2379780.acf",
    common_paths = {},
}

local function metadata(root_id, relative)
    local ok, value = pcall(fs.metadata, root_id, relative)
    if ok then return value end
    return nil
end

local function present(root_id, relative, kind)
    local item = metadata(root_id, relative)
    return item ~= nil and item.kind == kind
end

function policy.validate()
    return present(1, policy.marker, "file")
end

local function quoted_value(text, key)
    for line in string.gmatch(text, "[^\r\n]+") do
        local words = {}
        for word in string.gmatch(line, '"([^"]*)"') do
            table.insert(words, word)
        end
        if #words >= 2 and string.lower(words[1]) == string.lower(key) then
            return words[2]
        end
    end
    return nil
end

function policy.steam_name()
    local ok, contents = pcall(dir.read_text, 1, policy.steam_manifest)
    local name = ok and quoted_value(contents, "installdir") or nil
    if type(name) ~= "string" or name == "" or name == "." or name == ".."
        or string.find(name, "[/\\]") then
        return "Balatro"
    end
    return name
end

function policy.is_epic()
    return false
end

local function split_path(value)
    local parts = {}
    for part in string.gmatch(value, "[^/]+") do table.insert(parts, part) end
    return parts
end

local function lower(value)
    return string.lower(value)
end

local function extension(value)
    return string.match(lower(value), "%.([^%.]+)$") or ""
end

local function is_lua(value)
    return extension(value) == "lua"
end

local function is_documentation(value)
    local ext = extension(value)
    return ext == "txt" or ext == "md" or ext == "rst"
end

local function is_save_or_settings(relative)
    local parts = split_path(relative)
    if parts[1] == "1" or parts[1] == "2" or parts[1] == "3" then return true end
    for _, part in ipairs(parts) do
        local name = lower(part)
        if string.sub(name, -4) == ".jkr" or string.sub(name, 1, 8) == "settings" then
            return true
        end
    end
    return false
end

local function is_executable_payload(relative)
    local ext = extension(relative)
    return ext == "exe" or ext == "bat" or ext == "dll" or ext == "cmd"
        or ext == "com" or ext == "scr" or ext == "ps1" or ext == "vbs"
        or ext == "msi" or ext == "lnk" or ext == "url"
end

local function top_names(files)
    local seen, names = {}, {}
    for _, file in ipairs(files) do
        local top = string.match(file.source, "^([^/]+)")
        if top ~= nil and not seen[top] then
            seen[top] = true
            table.insert(names, top)
        end
    end
    table.sort(names)
    return names
end

local function all_under(files, top)
    local prefix = top .. "/"
    for _, file in ipairs(files) do
        if string.sub(file.source, 1, #prefix) ~= prefix then return false end
    end
    return true
end

local function relative_to(files, top)
    local prefix_length = #top + 2
    local result = {}
    for _, file in ipairs(files) do
        table.insert(result, {
            source = string.sub(file.source, prefix_length),
            bytes = file.bytes,
        })
    end
    return result
end

local function has_root_file(files, wanted)
    for _, file in ipairs(files) do
        if not string.find(file.source, "/", 1, true) and lower(file.source) == wanted then
            return true
        end
    end
    return false
end

local function is_mod_folder(files)
    for _, file in ipairs(files) do
        if not string.find(file.source, "/", 1, true) then
            local name = lower(file.source)
            if name == "lovely.toml" or string.sub(name, -5) == ".json" then
                return true
            end
        end
    end
    return false
end

local function is_steamodded_tree(files)
    local has_manifest, has_src, has_lovely = false, false, false
    for _, file in ipairs(files) do
        local source = file.source
        if string.match(source, "^[^/]+%.json$") ~= nil then has_manifest = true end
        if string.sub(source, 1, 4) == "src/" then has_src = true end
        if string.sub(source, 1, 7) == "lovely/" then has_lovely = true end
    end
    return has_manifest and has_src and has_lovely
end

local function is_native_only(files)
    local has_injector = false
    for _, file in ipairs(files) do
        if string.find(file.source, "/", 1, true) ~= nil then return false end
        local name = lower(file.source)
        if name == "winmm.dll" then
            has_injector = true
        elseif not is_documentation(name) then
            return false
        end
    end
    return has_injector
end

local function classify_folder(inner, folder)
    if is_steamodded_tree(inner) then
        return { kind = "smods", destination = "smods", files = inner, prefix = "" }
    end
    if is_native_only(inner) then
        return { kind = "native", destination = "", files = inner, prefix = "" }
    end
    if is_mod_folder(inner) then
        local kind = has_root_file(inner, "lovely.toml") and "lovely" or "mod"
        return { kind = kind, destination = folder, files = inner, prefix = "" }
    end
    return nil
end

local function classify(files, allow_wrapper)
    if #files == 0 then return nil, "EMPTY_PACKAGE" end
    if is_steamodded_tree(files) then
        return { kind = "smods", destination = "smods", files = files, prefix = "" }
    end
    if is_native_only(files) then
        return { kind = "native", destination = "", files = files, prefix = "" }
    end
    local tops = top_names(files)
    if #tops ~= 1 then return nil, "MULTIPLE_TOP_LEVEL_ROOTS" end
    local top = tops[1]
    if all_under(files, top) then
        local inner = relative_to(files, top)
        local nested = classify_folder(inner, top)
        if nested ~= nil then
            nested.prefix = top
            return nested
        end
        if not allow_wrapper then return nil, "UNRECOGNIZED_LAYOUT" end
        local inner_tops = top_names(inner)
        if #inner_tops == 1 and lower(inner_tops[1]) == "mods" and all_under(inner, inner_tops[1]) then
            local after_mods = relative_to(inner, inner_tops[1])
            local mod_wrapped, mod_code = classify(after_mods, false)
            if mod_wrapped ~= nil then
                local prefix = inner_tops[1]
                if mod_wrapped.prefix ~= "" then
                    prefix = prefix .. "/" .. mod_wrapped.prefix
                end
                mod_wrapped.prefix = top .. "/" .. prefix
                return mod_wrapped
            end
            return nil, mod_code
        end
        local wrapped, code = classify(inner, false)
        if wrapped == nil then return nil, code end
        if wrapped.prefix == "" then
            wrapped.prefix = top
        else
            wrapped.prefix = top .. "/" .. wrapped.prefix
        end
        return wrapped
    end
    if #files == 1 and is_lua(top) then
        return { kind = "single", destination = "", files = files, prefix = "" }
    end
    return nil, "UNRECOGNIZED_LAYOUT"
end

local function plan_kind(classified, relative)
    if classified.kind == "lovely" then return "lovely-mod-file" end
    if classified.kind == "smods" then return "steamodded-file" end
    if classified.kind == "mod" then return "balatro-mod-file" end
    return "balatro-mod-file"
end

function policy.plan(files)
    local operations = {}
    local blockers = {}
    local skipped = {}

    local function block(code, message)
        table.insert(blockers, { code = code, message = message })
    end

    if #files == 0 then
        block("EMPTY_PACKAGE", "Archive contains no files")
        return { schema_version = 1, operations = operations, blockers = blockers }
    end

    for _, file in ipairs(files) do
        if is_save_or_settings(file.source) then
            block("SAVE_DATA_PAYLOAD", "Save or settings payload is not installed: " .. file.source)
        end
    end
    if #blockers > 0 then
        return { schema_version = 1, operations = operations, blockers = blockers }
    end

    local relative, mods_prefix = files, ""
    local first_top = string.match(files[1].source, "^([^/]+)")
    if first_top ~= nil and lower(first_top) == "mods" and all_under(files, first_top) then
        relative = relative_to(files, first_top)
        mods_prefix = first_top
    end

    local classified, code = classify(relative, true)
    if classified == nil then
        block(code or "UNRECOGNIZED_LAYOUT", "Unsupported Balatro package layout")
        return { schema_version = 1, operations = operations, blockers = blockers }
    end

    local base = mods_prefix
    if classified.prefix ~= "" then
        base = base == "" and classified.prefix or (base .. "/" .. classified.prefix)
    end

    for _, file in ipairs(classified.files) do
        local path = file.source
        local source = base == "" and path or (base .. "/" .. path)
        if classified.kind == "native" then
            if lower(path) == "winmm.dll" then
                table.insert(operations, {
                    source = source, destination = "winmm.dll",
                    kind = "native-library", package_root = base,
                })
            else
                table.insert(skipped, source)
            end
        else
            local destination
            if classified.kind == "single" then
                destination = path
            elseif classified.kind == "smods" then
                destination = "smods/" .. path
            else
                destination = classified.destination .. "/" .. path
            end
            local kind = plan_kind(classified, path)
            if is_save_or_settings(path) then
                block("SAVE_DATA_PAYLOAD", "Save or settings payload is not installed: " .. destination)
            elseif is_executable_payload(path) then
                block("EXECUTABLE_PAYLOAD", "Executable payload is not supported: " .. destination)
            else
                table.insert(operations, {
                    source = source, destination = destination, kind = kind,
                    package_root = base, root = "content",
                })
            end
        end
    end

    if #operations == 0 and #blockers == 0 then
        block("NO_INSTALLABLE_FILES", "No installable files")
    end
    return {
        schema_version = 1, operations = operations, blockers = blockers,
        skipped_generated_files = skipped,
    }
end

local function note_listing(response, issues)
    local incomplete = false
    if not response.incomplete then return false end
    if response.truncated then
        issues.SCAN_INCOMPLETE = true
        incomplete = true
    end
    for _ in ipairs(response.unsafe_names or {}) do
        issues.SCAN_UNSAFE_ENTRY = true
        incomplete = true
    end
    if response.unreadable then
        issues.SCAN_UNREADABLE_ENTRY = true
        incomplete = true
    end
    if not incomplete then
        issues.SCAN_INCOMPLETE = true
        incomplete = true
    end
    return incomplete
end

function policy.scan(limit)
    local mods = {}
    local signals = {}
    local issues = {}
    local incomplete = false

    if present(1, "winmm.dll", "file") then
        table.insert(signals, { name = "Lovely", relative_path = "winmm.dll", kind = "file" })
    end
    if present(1, "version.dll", "file") then
        table.insert(signals, {
            name = "Lovely (legacy)", relative_path = "version.dll", kind = "file",
        })
    end

    local roots = mods_host.discovery.roots()
    if #roots >= 2 and present(2, "smods", "directory") then
        local function push(relative)
            table.insert(mods, { relative_path = relative, kind = "steamodded", root = "content" })
        end
        local visited = 0
        local stack = { "smods" }
        while #stack > 0 do
            local folder = table.remove(stack)
            local ok, response = pcall(dir.list, 2, folder, math.max(limit - visited, 1))
            if not ok then
                incomplete = true
                issues.SCAN_UNREADABLE_ENTRY = true
            else
                if note_listing(response, issues) then incomplete = true end
                for _, entry in ipairs(response.items) do
                    if visited >= limit then
                        incomplete = true
                        issues.SCAN_INCOMPLETE = true
                        break
                    end
                    visited = visited + 1
                    local relative = folder .. "/" .. entry.name
                    if entry.kind == "directory" then
                        table.insert(stack, relative)
                    elseif entry.kind == "file" then
                        push(relative)
                    end
                end
                if #response.items == 0 and folder == "smods" then push(folder) end
            end
        end
    end

    local scan_issues = {}
    for code in pairs(issues) do table.insert(scan_issues, code) end
    table.sort(scan_issues)
    table.sort(mods, function(a, b) return a.relative_path < b.relative_path end)
    return {
        mods = mods, framework_signals = signals, incomplete = incomplete,
        scan_issues = scan_issues, redmod_available = false,
    }
end

function policy.doctor(report)
    local findings = {}
    local function add(code, severity, message, action)
        table.insert(findings, {
            code = code, severity = severity, message = message, action = action,
        })
    end

    local has_winmm, has_version = false, false
    for _, signal in ipairs(report.framework_signals or {}) do
        if signal.relative_path == "winmm.dll" then has_winmm = true end
        if signal.relative_path == "version.dll" then has_version = true end
    end
    if has_winmm then
        add("LOVELY_PRESENT", "info", "Lovely injector detected (winmm.dll).")
    elseif has_version then
        add("LOVELY_LEGACY", "warning",
            "Legacy Lovely injector detected (version.dll); current Lovely uses winmm.dll.",
            "Replace version.dll with the current Lovely winmm.dll, then run `modn doctor` again.")
    else
        add("LOVELY_MISSING", "warning",
            "Lovely injector not detected; mods in the Balatro Mods folder will not load.",
            "Install Lovely so winmm.dll sits beside Balatro.exe, then run `modn doctor` again.")
    end

    for _, code in ipairs(report.scan_issues or {}) do
        if code == "SCAN_INCOMPLETE" then
            add(code, "warning", "Inventory truncated by the scan entry limit.")
        elseif code == "SCAN_UNSAFE_ENTRY" then
            add(code, "warning", "Unsafe or linked directory entries were skipped.")
        elseif code == "SCAN_UNREADABLE_ENTRY" then
            add(code, "warning", "Unreadable directory entries were skipped.")
        elseif code == "SCAN_IGNORED_GENERATED_LOG" then
            add(code, "info", "Generated log content was ignored.")
        end
    end
    if report.incomplete and #(report.scan_issues or {}) == 0 then
        add("SCAN_INCOMPLETE", "warning", "Inventory is incomplete; some content was not inspected.")
    end

    for _, item in ipairs(report.mods or {}) do
        if not item.managed then
            add("UNMANAGED_CONTENT", "warning",
                "Some detected Balatro mods are not owned by this manager; no changes will be made.",
                "Inspect the listed paths and follow their original uninstall instructions before a clean install.")
            break
        end
    end

    local actions = {
        missing = "Restore the original package files from the installation archive, or uninstall the package, then run `modn doctor` again.",
        modified = "Restore the original package files from the installation archive, or uninstall the package, then run `modn doctor` again.",
        unsafe = "Inspect the content root and resolve the unsafe path before retrying.",
        unreadable = "Restore access to the content root, then run `modn doctor` again.",
    }
    for _, status in ipairs({ "missing", "modified", "unsafe", "unreadable" }) do
        local count = 0
        for _, file in ipairs(report.owned_files or {}) do
            if file.status == status then count = count + 1 end
        end
        if count > 0 then
            add("OWNED_FILE_" .. string.upper(status), "warning",
                string.format("%d manager-owned file(s) are %s; inspect scan ownership details.",
                    count, status), actions[status])
        end
    end

    return findings
end

return policy
