local PLUGIN = PLUGIN;

surface.CreateFont("MiddleLabels", {
    font = "DermaLarge",
    size = 21,
    weight = 0,
})

surface.CreateFont("TopBoldLabel", {
    font = "DermaLarge",
    size = 21,
    weight = 500,
    antialias = true,
})

surface.CreateFont("TopLabel", {
    font = "Helvetica",
    size = 23,
    weight = 0,
    antialias = true,
})

local colours = {
    white = Color(180, 180, 180, 255),
    red = Color(231, 76, 60, 255),
    green = Color(39, 174, 96),
    blue = Color(41, 128, 185, 255),
};

// Remove an entry, send extra data for validation purposes.
function cwDatafile:RemoveEntry(target, key, date, category, text)
	Clockwork.datastream:Start("removeLine", {target, key, date, category, text});
end;

// Update a player their Civil Status.
function cwDatafile:UpdateCivilStatus(target, tier)
	Clockwork.datastream:Start("updateCivilStatus", {target, tier});
	cwDatafile:Refresh(target);
end;

// Update a player their Employment Status.
function cwDatafile:UpdateEmploymentStatus(target, tier)
	Clockwork.datastream:Start("updateEmploymentStatus", {target, tier});
	cwDatafile:Refresh(target);
end;

// A small delay is added for callback reasons. Really disgusting solution.
function cwDatafile:Refresh(target)
	timer.Simple(0.05, function()
		PLUGIN.cwDatafile:Close();
		Clockwork.datastream:Start("refreshFile", {target});
	end);
end;