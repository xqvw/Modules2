-- // ( Variables )
local http_service = cloneref(game:GetService("HttpService"));
local SaveManager = {};


do
	SaveManager.Folder = "LinoriaLibSettings";
	SaveManager.Ignore = {};


	SaveManager.Parser = {
		Toggle = {
			Save = function(index, object) 
				return { type = "Toggle", index = index, value = object.Value};
			end;
			Load = function(index, object)
				if (Toggles[index]) then 
					Toggles[index]:SetValue(object.value);
				end;
			end;
		},


		Slider = {
			Save = function(index, object)
				return { type = "Slider", index = index, value = tostring(object.Value)};
			end;
			Load = function(index, object)
				if (Options[index]) then 
					Options[index]:SetValue(object.value);
				end;
			end;
		},


		Dropdown = {
			Save = function(index, object)
				return { type = "Dropdown", index = index, value = object.Value, mutli = object.Multi};
			end;
			Load = function(index, object)
				if (Options[index]) then 
					Options[index]:SetValue(object.value);
				end;
			end;
		},


		ColorPicker = {
			Save = function(index, object)
				return { type = "ColorPicker", index = index, value = object.Value:ToHex(), transparency = object.Transparency};
			end;
			Load = function(index, object)
				if (Options[index]) then 
					Options[index]:SetValueRGB(Color3.fromHex(object.value), (Options[index].HasTransparency and object.transparency) or (0));
				end;
			end;
		},


		KeyPicker = {
			Save = function(index, object)
				return { type = "KeyPicker", index = index, mode = object.Mode, key = object.Value};
			end;
			Load = function(index, object)
				if (Options[index]) then
					Options[index]:SetValue({object.key, object.mode});
				end;
			end;
		},

		Input = {
			Save = function(index, object)
				return { type = "Input", index = index, text = object.Value};
			end;
			Load = function(index, object)
				if (Options[index] and type(object.text) == "string") then
					Options[index]:SetValue(object.text)
				end;
			end;
		}
	};



	-- >> ( Callbacks )
	function SaveManager:SetIgnoreIndexes(list)
		for _, v in next, list do
			self.Ignore[v] = true;
		end;
	end;


	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree();
	end;


	function SaveManager:Save(name)
		if not (name) then
			return false, "No config file is selected";
		end;

		local k = {
			objects = {};
		};


		for index, toggle in next, Toggles do
			if (self.Ignore[index]) then
				continue;
			end;

			table.insert(k.objects, self.Parser[toggle.Type].Save(index, toggle));
		end;


		for idx, option in next, Options do
			if not (self.Parser[option.Type]) then
				continue;
			end;
			if (self.Ignore[idx]) then
				continue;
			end;

			table.insert(k.objects, self.Parser[option.Type].Save(idx, option));
		end;


		local ok, encoded = pcall(http_service.JSONEncode, http_service, k);
		if not (ok) then
			return false, "Failed to encode config";
		end;

		writefile(self.Folder .. "/settings/" .. name .. ".json", encoded);
		return true;
	end;



	function SaveManager:Load(name)
		if not (name) then
			return false, "No config is selected";
		end;
		
		local file = self.Folder .. "/settings/" .. name .. ".json";
		if not (isfile(file)) then
			return false, "Invalid file";
		end;

		local ok, decoded = pcall(http_service.JSONDecode, http_service, readfile(file));
		if not (ok) then
			return false, "Decode error";
		end;


		for _, option in next, decoded.objects do
			if (self.Parser[option.type]) then
				task.spawn(function()
					self.Parser[option.type].Load(option.index, option);
				end);
			end;
		end;

		return true;
	end;



	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({"BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor",
			"ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName"
		});
	end;


	function SaveManager:BuildFolderTree()
		local paths = {self.Folder, self.Folder .. "/themes", self.Folder .. "/settings"};

		for i = 1, #paths do
			if not (isfolder(paths[i])) then
				makefolder(paths[i]);
			end;
		end;
	end;


	function SaveManager:RefreshConfigList()
		local list = listfiles(self.Folder .. "/settings");
		local k = {};

		for i = 1, #list do
			local file = list[i];

			if (file:sub(-5) == ".json") then
				local pos = file:find(".json", 1, true);
				local start = pos;

				local char = file:sub(pos, pos);
				while (char ~= "/" and char ~= "\\" and char ~= "") do
					pos = pos - 1;
					char = file:sub(pos, pos);
				end;

				if (char == "/") or (char == "\\") then
					table.insert(k, file:sub(pos + 1, start - 1));
				end;
			end;
		end;
		
		return k;
	end;



	function SaveManager:SetLibrary(library)
		self.Library = library;
	end;



	function SaveManager:LoadAutoloadConfig()
		if (isfile(self.Folder .. "/settings/autoload.txt")) then
			local name = readfile(self.Folder .. "/settings/autoload.txt");
			local success, err = self:Load(name);

			if not (success and not silent) then
				return self.Library:Notify("Failed to load autoload config: " .. err);
			end;

			if not (silent) then
				self.Library:Notify("Auto loaded config " .. name);
			end;
		end;
	end;



	-- // ( Ui )
	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, "Must set SaveManager.Library");


		local configuration = tab:AddRightGroupbox("Configuration");
		configuration:AddInput("SaveManager_ConfigName", { Text = "Config name" });
		configuration:AddDropdown("SaveManager_ConfigList", { Text = "Selected config", Values = self:RefreshConfigList(), AllowNull = true });
		configuration:AddDivider();


		configuration:AddButton({ Text = "Create config", 
			Func = function()
				local value = Options.SaveManager_ConfigName.Value;
				if (value:gsub(" ", "") == "") then
					return self.Library:Notify("Invalid config name (empty)", 5);
				end;


				local ok, err = self:Save(value);
				if not (ok) then
					return self.Library:Notify("Failed to save config: " .. err, 5);
				end;


				self.Library:Notify("Created config " .. value);
				Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList());
				Options.SaveManager_ConfigList:SetValue(nil);
			end;
		}):AddButton({ Text = "Load config", 
			Func = function()
				local value = Options.SaveManager_ConfigList.Value;
				local ok, err = self:Load(value);

				if not (ok) then
					return self.Library:Notify("Failed to load config: " .. err);
				end;


				self.Library:Notify("Loaded config " .. value);
			end;
		});
		

		configuration:AddButton({ Text = "Overwrite config", DoubleClick = true, 
			Func = function()
				local value = Options.SaveManager_ConfigList.Value
				local ok, err = self:Save(value)

				if not (ok) then
					return self.Library:Notify("Failed to overwrite config: " .. err);
				end;

				self.Library:Notify("Overwrote config " .. value);
			end;
		});


		configuration:AddButton({ Text = "Refresh list", 
			Func = function()
				Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList());
				Options.SaveManager_ConfigList:SetValue(nil);
			end;
		});
		

		configuration:AddButton({ Text = "Set autoload", 
			Func = function()
				local value = Options.SaveManager_ConfigList.Value;
				if not (value) then
					return;
				end;

				writefile(self.Folder .. "/settings/autoload.txt", value);
				SaveManager.AutoloadLabel:SetText("current autoload config: " .. value);
				self.Library:Notify("Set " .. value .. " to auto load");
			end;
		}):AddButton({ Text = "Remove autoload", DoubleClick = true, 
			Func = function()
				if (isfile(self.Folder .. "/settings/autoload.txt")) then
					delfile(self.Folder .. "/settings/autoload.txt");
				end;


				SaveManager.AutoloadLabel:SetText("Current autoload config: none");
				self.Library:Notify("Removed autoload config");
			end;
		});

		SaveManager.AutoloadLabel = configuration:AddLabel("Current autoload config: none", true);


		if (isfile(self.Folder .. "/settings/autoload.txt")) then
			local file = readfile(self.Folder .. "/settings/autoload.txt");
			SaveManager.AutoloadLabel:SetText("Current autoload config: " .. file);
		end;


		SaveManager:SetIgnoreIndexes({"SaveManager_ConfigList", "SaveManager_ConfigName"});
	end;
	

	SaveManager:BuildFolderTree();
end;



getgenv().SaveManager = SaveManager;
return SaveManager;
