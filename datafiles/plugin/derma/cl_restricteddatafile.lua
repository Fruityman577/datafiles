local PLUGIN = PLUGIN;

local colours = {
	white = Color(180, 180, 180, 255),
	red = Color(231, 76, 60, 255),
	green = Color(39, 174, 96),
	blue = Color(41, 128, 185, 255),
};

// Main datafile panel.
local PANEL = {};

function PANEL:Init()
	self:SetTitle("");

	self:SetSize(475, 570);
	self:Center();

	self:MakePopup();

	self.Status = "";

	// Creation of all elements, text is set in the population functions.
	self.TopPanel = vgui.Create("cwDfPanel", self);
	
	// TODO: Add the CID here!
	self.NameLabel = vgui.Create("DLabel", self.TopPanel);
	self.NameLabel:SetTextColor(Color(255, 255, 255));
	self.NameLabel:SetFont("DermaLarge");
	self.NameLabel:Dock(TOP);
	self.NameLabel:DockMargin(5, 5, 0, 0);
	self.NameLabel:SizeToContents(true);

	self.InfoPanel = vgui.Create("cwDfInfoPanel", self.TopPanel);
	self.InfoPanel:MakeRestricted(true);

	self.HeaderPanel = vgui.Create("cwDfHeaderPanel", self);
	self.HeaderPanel:MakeRestricted(true);

	self.Entries = vgui.Create("cwDfEntriesPanel", self);
	self.Entries:MakeRestricted(true);

	// Lower button panel.
	self.dButtons = vgui.Create("cwDfPanel", self);
	self.dButtons:Dock(BOTTOM);
	self.dButtons:SetTall(35);

	// Upper button panel.
	self.uButtons = vgui.Create("cwDfPanel", self);
	self.uButtons:Dock(BOTTOM);
	self.uButtons:SetTall(35);

	// Upper buttons. Population will be done below.
	self.uLeftButton = vgui.Create("cwDfButton", self.dButtons);
	self.uLeftButton:SetText("ADD NOTE");
	self.uLeftButton:SetMetroColor(colours.blue);
	self.uLeftButton:Dock(RIGHT);

	// Bottom buttons.
	self.dLeftButton = vgui.Create("cwDfButton", self.dButtons);
	self.dLeftButton:SetText("UPDATE LAST SEEN");
	self.dLeftButton:Dock(LEFT);

	self.DoClose = function()
        PLUGIN.cwDatafile = nil;
    end;
	
	self.OnClose = function()
	net.Start("DatafileClosed")
	net.WriteInt( 0, 3 ) 
	net.SendToServer()
	end;
end;

function PANEL:PopulateDatafile(target, datafile)
	for k, v in pairs(datafile) do
		local text = datafile[k].text;
		local date = datafile[k].date;
		local poster = datafile[k].poster[1];
		local points = tonumber(datafile[k].points);
		local color = datafile[k].poster[3];
        
        if (datafile[k].category == "union") then
            local entry = vgui.Create("cwDfEntry", self.Entries.Left);
            entry:SetEntryText(text, date, "~ " .. poster, points, color);
        end;    
	end;
end;

function PANEL:PopulateGenericData(target, datafile, GenericData)
	local bIsCombine = Schema:PlayerIsCombine(target);
	local bIsAntiCitizen;
	local bHasBOL = GenericData.bol[1];
	local civilStatus = GenericData.civilStatus;
	local employmentStatus = GenericData.employmentStatus;
	local lastSeen = GenericData.lastSeen

	if (bIsCombine) then
        points = GenericData.sc;
        self.InfoPanel:SetInfoText(civilStatus, employmentStatus, points, lastSeen);
    else
        points = GenericData.points;
        self.InfoPanel:SetInfoText(civilStatus, employmentStatus, points, lastSeen);
    end;

	if (GenericData.civilStatus == "Anti-Citizen") then
        bIsAntiCitizen = true;
    end;

    if (bHasBol) then
        self.Status = "yellow";
    elseif (bIsAntiCitizen) then
        self.Status = "red";
    elseif (bIsCombine) then
        self.Status = "blue";
    end;

    self.NameLabel:SetText(target:Name());

 	self.dLeftButton.DoClick = function()
		Clockwork.datastream:Start("updateLastSeen", {target});
		cwDatafile:Refresh(target);
	end;

    self.uLeftButton.DoClick = function()
        local entryPanel = vgui.Create("cwDfNoteEntry");
        entryPanel:SendInformation(target);
    end;
end;

function PANEL:Paint(w, h)
    local sineToColor = math.abs(math.sin(RealTime() * 1.5) * 255);
    local color;

    if (self.Status == "yellow") then
        color = Color(sineToColor, sineToColor, 0, 200);

    elseif (self.Status == "red") then
        color = Color(sineToColor, 0, 0, 200);

    elseif (self.Status == "blue") then
        color = Color(0, 200, 200, 200)
    else
        color = Color(170, 170, 170, 255);
    end;

	surface.SetDrawColor(Color(40, 40, 40, 150));
	surface.DrawRect(0, 0, w, h);

	surface.SetDrawColor(color);
	surface.DrawOutlinedRect(0, 0, w, h)
end;

vgui.Register("cwRestrictedDatafile", PANEL, "DFrame");