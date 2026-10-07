-- // ( Variables )
local http_service = cloneref(game:GetService("HttpService"));
local ThemeManager = {};


do
	ThemeManager.Folder = "LinoriaLibSettings";
	ThemeManager.Library = nil;
	ThemeManager["BuiltInThemes"] = {
		["Default"] = {
			1, 
			http_service:JSONDecode('{"FontColor":"ffffff","MainColor":"181818","AccentColor":"c8c8c8","BackgroundColor":"141414","OutlineColor":"1f1f1f"}')
		},
		["Blue"] = {
			2,
			http_service:JSONDecode('{"FontColor":"ffffff","MainColor":"181818","AccentColor":"4777b6","BackgroundColor":"141414","OutlineColor":"1f1f1f"}')
		},
	};



	-- // ( Callbacks )
	function ThemeManager:ApplyTheme(theme)
		local custom = self:GetCustomTheme(theme);
		local index = (custom) or (self.BuiltInThemes[theme]);
		if not (index) then
			return;
		end;


		for i, color in next, (custom) or (index[2]) do
			self.Library[i] = Color3.fromHex(color);
			if (Options[i]) then
				Options[i]:SetValueRGB(Color3.fromHex(color));
			end;
		end;

		self:ThemeUpdate();
	end;


	function ThemeManager:ThemeUpdate()
		local options = {"FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor"};
		for i, v in next, options do
			if (Options and Options[v]) then
				self.Library[v] = Options[v].Value;
			end;
		end;

		self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
		self.Library:UpdateColorsUsingRegistry();
	end;


	function ThemeManager:LoadDefault()		
		local theme = "Default";
		local file = (isfile(self.Folder .. "/themes/default.txt")) and (readfile(self.Folder .. "/themes/default.txt"));
		local ok = true;


		if (file) then
			if self.BuiltInThemes[file] then
				theme = file;
			elseif self:GetCustomTheme(file) then
				theme = file;
				ok = false;
			end;
		elseif (self.BuiltInThemes[self.DefaultTheme]) then
		 	theme = self.DefaultTheme;
		end;


		if (ok) then
			Options.ThemeManager_ThemeList:SetValue(theme);
		else
			self:ApplyTheme(theme);
		end;
	end;


	function ThemeManager:SaveDefault(theme)
		writefile(self.Folder .. "/themes/default.txt", theme);
	end;



	-- // ( Ui )
	function ThemeManager:CreateThemeManager(groupbox)
		groupbox:AddLabel("Main color"):AddColorPicker("MainColor", { Title = "Main color", Default = self.Library.MainColor });
		groupbox:AddLabel("Background color"):AddColorPicker("BackgroundColor", { Title = "Background color", Default = self.Library.BackgroundColor });
		groupbox:AddLabel("Outline color"):AddColorPicker("OutlineColor", { Title = "Outline color", Default = self.Library.OutlineColor });
		groupbox:AddLabel("Accent color"):AddColorPicker("AccentColor", { Title = "Accent color", Default = self.Library.AccentColor });
		groupbox:AddLabel("Font color"):AddColorPicker("FontColor", { Title = "Font color", Default = self.Library.FontColor });
		groupbox:AddDivider();


		local default_themes = {};
		for index, v in next, self.BuiltInThemes do
			table.insert(default_themes, index);
		end;

		table.sort(default_themes, function(a, b)
			return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1];
		end);


		groupbox:AddDropdown("ThemeManager_ThemeList", { Text = "Selected theme", Values = default_themes, Default = 1,
			Callback = function(value)
				self:ApplyTheme(value);
			end;
		});
		groupbox:AddButton({ Text = "Set as default", 
			Func = function()
				self:SaveDefault(Options.ThemeManager_ThemeList.Value);
				self.Library:Notify("Set default theme to " .. Options.ThemeManager_ThemeList.Value);
			end;
		});

		groupbox:AddDivider();
		groupbox:AddInput("ThemeManager_CustomThemeName", { Text = "Custom theme name" });
		groupbox:AddDropdown("ThemeManager_CustomThemeList", { Text = "selected custom theme", Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 });

		groupbox:AddButton({ Text = "Save theme", 
			Func = function() 
				self:SaveCustomTheme(Options.ThemeManager_CustomThemeName.Value);
				Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes());
				Options.ThemeManager_CustomThemeList:SetValue(nil);
			end;
		}):AddButton({ Text = "Load theme", 
			Func = function() 
				self:ApplyTheme(Options.ThemeManager_CustomThemeList.Value);
			end;
		});


		groupbox:AddButton({ Text = "Refresh list",
			Func = function()
				Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes());
				Options.ThemeManager_CustomThemeList:SetValue(nil);
			end;
		});

		groupbox:AddButton({Text = "Set as default", 
			Func = function()
				if (Options.ThemeManager_CustomThemeList.Value ~= nil and Options.ThemeManager_CustomThemeList.Value ~= "") then
					self:SaveDefault(Options.ThemeManager_CustomThemeList.Value);
					self.Library:Notify("Set default theme to " .. Options.ThemeManager_CustomThemeList.Value);
				end;
			end;
		});


		ThemeManager:LoadDefault();

		local function UpdateTheme()
			self:ThemeUpdate();
		end;


		Options.BackgroundColor:OnChanged(UpdateTheme);
		Options.MainColor:OnChanged(UpdateTheme);
		Options.AccentColor:OnChanged(UpdateTheme);
		Options.OutlineColor:OnChanged(UpdateTheme);
		Options.FontColor:OnChanged(UpdateTheme);
	end;



	
	function ThemeManager:GetCustomTheme(file)
		local path = self.Folder .. "/themes/" .. file;
		if not (isfile(path)) then
			return nil;
		end;

		local ok, decoded = pcall(http_service.JSONDecode, http_service, readfile(path));
		if not (ok) then
			return nil;
		end;

		return decoded;
	end;


	function ThemeManager:SaveCustomTheme(file)
		if (file:gsub(" ", "") == "") then
			return self.Library:Notify("Invalid file name for theme (empty)", 5);
		end;

		local theme = {};
		local options = {"FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor"};

		for _, v in next, options do
			theme[v] = Options[v].Value:ToHex();
		end;

		writefile(self.Folder .. "/themes/" .. file .. ".json", http_service:JSONEncode(theme));
	end;


	function ThemeManager:ReloadCustomThemes()
		local list = listfiles(self.Folder .. "/themes");
		local k = {};


		for i = 1, #list do
			local file = list[i];

			if (file:sub(-5) == ".json") then
				local pos = file:find(".json", 1, true);
				local char = file:sub(pos, pos);

				while (char ~= "/" and char ~= "\\" and char ~= "") do
					pos = pos - 1;
					char = file:sub(pos, pos);
				end;

				if (char == "/" or char == "\\") then
					table.insert(k, file:sub(pos + 1));
				end;
			end;
		end;

		return k;
	end;


	function ThemeManager:SetLibrary(lib)
		self.Library = lib;
	end;


	function ThemeManager:BuildFolderTree()
		local k = {};
		local split = self.Folder:split("/");


		for idx = 1, #split do
			k[#k + 1] = table.concat(split, "/", 1, idx);
		end;

		table.insert(k, self.Folder .. "/themes");
		table.insert(k, self.Folder .. "/settings");

		for i = 1, #k do
			if not (isfolder(k[i])) then
				makefolder(k[i]);
			end;
		end;
	end;


	function ThemeManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree();
	end;


	function ThemeManager:CreateGroupBox(tab)
		assert(self.Library, "Must set ThemeManager.Library first");
		return tab:AddLeftGroupbox("Theme");
	end;


	function ThemeManager:ApplyToTab(tab)
		assert(self.Library, "Must set ThemeManager.Library first");
		local groupbox = self:CreateGroupBox(tab);
		self:CreateThemeManager(groupbox);
	end;


	function ThemeManager:ApplyToGroupbox(groupbox)
		assert(self.Library, "Must set ThemeManager.Library first");
		self:CreateThemeManager(groupbox);
	end;


	ThemeManager:BuildFolderTree();
end;



return ThemeManager;
