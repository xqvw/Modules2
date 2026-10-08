local objects = {};



do
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xqvw/Modules/refs/heads/main/Variables.luau"))();

    -- // ( Hit sounds )
    objects["hit_sounds"] = {
        ["Bow"] = "rbxassetid://101967493171799",
        ["Click"] = "rbxassetid://1347140027",
        ["Neverlose"] = "rbxassetid://6607204501",
        ["Gamesense"] = "rbxassetid://4817809188",
        ["Sparkle"] = "rbxassetid://110241936966089",
        ["Rust"] = "rbxassetid://125189826728499",
        ["TF2"] = "rbxassetid://137392628136734",
        ["Impact"] = "rbxassetid://6759025689",
        ["Pop"] = "rbxassetid://18803667669",
        ["Windows xp error"] = "rbxassetid://160715357",
        ["Minecraft damage"] = "rbxassetid://6361963422"
    };
    objects["hit_sounds_key"] = {"Custom", "Bow", "Click", "Neverlose", "Gamesense", "Sparkle", "Rust", "TF2", "Impact", "Pop", "Windows xp error", "Minecraft damage"};



    -- // ( Shoot sounds )
    objects["shoot_sounds"] = {
        ["Bow"] = "rbxassetid://3442683707",
        ["Crossbow"] = "rbxassetid://8616930816",
        ["Plasma shotgun"] = "rbxassetid://2605233927",
        ["Plasma pistol"] = "rbxassetid://5312934759",
        ["Plasma machine"] = "rbxassetid://2605256561",
    };
    objects["shoot_sounds_key"] = {"Custom", "Bow", "Crossbow", "Plasma shotgun", "Plasma pistol", "Plasma machine"};



    -- // ( Auras )
    objects["auras"] = {
        ["Angel"] = game:GetObjects("rbxassetid://118170929417615")[1],
        ["Flow"] = game:GetObjects("rbxassetid://119913533725648")[1],
        ["Heavenly"] = game:GetObjects("rbxassetid://139300897520961")[1],
        ["Ribbon"] = game:GetObjects("rbxassetid://132069507632161")[1],
        ["Wind"] = game:GetObjects("rbxassetid://80694081850877")[1],
        ["Hearts"] = game:GetObjects("rbxassetid://82132594242160")[1],
        ["Triangles"] = game:GetObjects("rbxassetid://103816036088614")[1],
        ["Starlight"] = game:GetObjects("rbxassetid://103382181949401")[1]
    };
    objects["aura_key"] = {"Angel", "Heavenly", "Starlight", "Hearts", "Flow", "Ribbon", "Wind", "Triangles"};



    -- // ( Animations )
    objects["animation_ids"] = {
        ["Bodybuilder"] = "rbxassetid://3994130516",
        ["Bouncy twirl"] = "rbxassetid://14353423348",
        ["Take the L"] = "rbxassetid://114846964045392",
        ["Floss"] = "rbxassetid://5917570207",
        ["Caramelldansen"] = "rbxassetid://90782855438572",
        ["Hype"] = "rbxassetid://3696757129",
        ["Kicking feet"] = "rbxassetid://112540347880956",
        ["Take me under"] = "rbxassetid://6797938823"
    };
    objects["animations_key"] = {"Custom", "Bodybuilder", "Bouncy twirl", "Floss", "Caramelldansen", "Hype", "Kicking feet", "Take me under", "Take the L"};



    -- // ( Hit effects )
    objects["hit_effects"] = {
        ["Orbs"] = {
            {
                {
                    ["FlipbookMode"] = Enum["ParticleFlipbookMode"]["OneShot"],
                    ["RotSpeed"] = number_range_new(-10, 10),
                    ["FlipbookFramerate"] = number_range_new(40, 40),
                    ["Drag"] = 1,
                    ["Rate"] = 1,
                    ["Texture"] = "rbxassetid://15011464541",
                    ["Rotation"] = number_range_new(-1000, 1000),
                    ["Transparency"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 0),
                        number_sequence_keypoint_new(1, 1)
                    },
                    ["SpreadAngle"] = vector2_new(-1000, 1000),
                    ["Lifetime"] = number_range_new(0.44999998807907104, 0.44999998807907104),
                    ["LightEmission"] = 1,
                    ["Brightness"] = 10,
                    ["FlipbookLayout"] = Enum["ParticleFlipbookLayout"]["Grid8x8"],
                    ["Size"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 5.5),
                        number_sequence_keypoint_new(1, 5.5)
                    },
                    ["Enabled"] = false
                },
                1
            }
        },
        ["Sparkles"] = {
            {
                {
                    ["Acceleration"] = vector3_new(0, -50, 0),
                    ["Color"] = color_sequence_new{
                        color_sequence_keypoint_new(0, Color3.new(1, 0.999969, 0.999985)),
                        color_sequence_keypoint_new(0.25, Color3.new(0.333333, 1, 0)),
                        color_sequence_keypoint_new(1, Color3.new(0.333333, 1, 0.498039))
                    },
                    ["Lifetime"] = number_range_new(0.5, 1),
                    ["LightEmission"] = 1,
                    ["Orientation"] = Enum.ParticleOrientation.VelocityParallel,
                    ["Rate"] = 0,
                    ["Size"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 0.6, 0),
                        number_sequence_keypoint_new(0.5, 0.6, 0),
                        number_sequence_keypoint_new(1, 0, 0)
                    },
                    ["Speed"] = number_range_new(15, 15),
                    ["SpreadAngle"] = vector2_new(50, -50),
                    ["Texture"] = "rbxassetid://18540695516",
                    ["Transparency"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 0, 0),
                        number_sequence_keypoint_new(0.5, 0, 0),
                        number_sequence_keypoint_new(1, 1, 0)
                    },
                    ["Enabled"] = false
                },
                30
            }
        },
        ["Vortex"] = {
            {
                {
                    ["Texture"] = "rbxassetid://14426232568",
                    ["Brightness"] = 15,
                    ["Lifetime"] = number_range_new(1, 2),
                    ["Size"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 15, 0),
                        number_sequence_keypoint_new(0.101354, 12, 0),
                        number_sequence_keypoint_new(0.261354, 7.65, 0),
                        number_sequence_keypoint_new(0.461354, 4, 0),
                        number_sequence_keypoint_new(0.713354, 1.41667, 0),
                        number_sequence_keypoint_new(1, 0, 0)
                    },
                    ["Rate"] = 10,
                    ["Rotation"] = number_range_new(-180, 180),
                    ["RotSpeed"] = number_range_new(150, 150),
                    ["LightEmission"] = 1,
                    ["Speed"] = number_range_new(0.01, 0.01),
                    ["Transparency"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 1, 0),
                        number_sequence_keypoint_new(0.500126, 0.14, 0),
                        number_sequence_keypoint_new(1, 0.456667, 0)
                    },
                    ["ZOffset"] = -0.5,
                    ["Enabled"] = false
                },
                3
            }
        },
        ["Bubble"] = {
            {
                {
                    ["FlipbookMode"] = Enum.ParticleFlipbookMode.OneShot,
                    ["Color"] = color_sequence_new{
                        color_sequence_keypoint_new(0, color3_fromrgb(85, 255, 255)),
                        color_sequence_keypoint_new(1, color3_fromrgb(85, 255, 255))
                    },
                    ["LockedToPart"] = true,
                    ["Rate"] = 1.5,
                    ["Rotation"] = number_range_new(-5, 5),
                    ["Transparency"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 1),
                        number_sequence_keypoint_new(0.464, 0.768750011920929),
                        number_sequence_keypoint_new(1, 1)
                    },
                    ["Texture"] = "rbxassetid://17086075673",
                    ["Lifetime"] = number_range_new(0.450000001192092896, 0.450000001192092896),
                    ["LightEmission"] = 1,
                    ["Brightness"] = 5,
                    ["Speed"] = number_range_new(0, 0),
                    ["Size"] = number_sequence_new{
                        number_sequence_keypoint_new(0, 0.10000000149011612),
                        number_sequence_keypoint_new(1, 6)
                    },
                    ["Enabled"] = false
                },
                1
            }
        }
    };
    objects["hit_effects_key"] = {"Bubble", "Clone", "Sparkles", "Orbs", "Vortex"};



    -- // ( Bullet tracers )
    objects["bullet_tracers"] = {
        ["Laser"] = {
            Texture = "rbxassetid://12781800668",
            FaceCamera = true,
            TextureLength = 2
        },
        ["Line"] = {
            Texture = "http://www.roblox.com/asset/?id=5059545109",
            FaceCamera = true
        },
        ["Wavy"] = {
            Texture = "http://www.roblox.com/asset/?id=5320412027",
            FaceCamera = true,
            TextureLength = 1
        },
        ["Zigzag"] = {
            Texture = "http://www.roblox.com/asset/?id=1274380363",
            FaceCamera = true,
            TextureLength = 1
        }
    };
    objects["bullet_tracers_key"] = {"Laser","Line","Wavy","Zigzag"};



    -- // ( Fonts )
    objects["fonts"] = {
        ["Smallest pixel"] = "meimei ware/fonts/smallestpixel_font",
        ["Pixel arial"] = "meimei ware/fonts/pixel_arial_font",
        ["Proggy tiny"] = "meimei ware/fonts/proggy_tiny_font",
        ["Proggy clean"] = "meimei ware/fonts/proggyclean_font",
        ["Monocraft"] = "meimei ware/fonts/monocraft_font",
        ["Tahoma"] = "meimei ware/fonts/tahoma_font",
        ["Ubuntu"] = nil
    };
    objects["fonts_key"] = {"Smallest pixel", "Pixel arial", "Proggy tiny", "Proggy clean", "Monocraft", "Tahoma", "Ubuntu"};



    -- // ( Ambience )
    objects["ambience_sounds"] = {
        ["Rain"] = "rbxassetid://9112854440",
        ["Wind"] = "rbxassetid://6670092634",
        ["Night"] = "rbxassetid://179507208",
        ["Day"] = "rbxassetid://9112738322"
    };
    objects["ambience_key"] = {"Rain", "Wind", "Night", "Day"};



    -- // ( Skyboxes )
    objects["skyboxes"] = {
        ["Afternoon"] = { Bk = "rbxassetid://162001887", Dn = "rbxassetid://161998893", Ft = "rbxassetid://162001897", Lf = "rbxassetid://162001904", Rt = "rbxassetid://162001919", Up = "rbxassetid://162001926"},
        ["Cloudy"] = { Bk = "rbxassetid://246480323", Dn = "rbxassetid://246480523", Ft = "rbxassetid://246480105", Lf = "rbxassetid://246480549", Rt = "rbxassetid://246480565", Up = "rbxassetid://246480504" },
        ["Dawn"] = { Bk = "rbxassetid://9778108979", Dn = "rbxassetid://9778110864", Ft = "rbxassetid://9778101192", Lf = "rbxassetid://9778103329", Rt = "rbxassetid://9778104889", Up = "rbxassetid://9778106496" },
        ["Earth"] = { Bk = "rbxassetid://15753305495", Dn = "rbxassetid://15753362674", Ft = "rbxassetid://15753305823", Lf = "rbxassetid://15753310707", Rt = "rbxassetid://15753304774", Up = "rbxassetid://15753304473" },
        ["Horizontal milky way"] = { Bk = "rbxassetid://714276643", Dn = "rbxassetid://714276541", Ft = "rbxassetid://714276657", Lf = "rbxassetid://714276648", Rt = "rbxassetid://714276638", Up = "rbxassetid://714276621" },
        ["Jungle"] = { Bk = "rbxassetid://214399891", Dn = "rbxassetid://214399887", Ft = "rbxassetid://214399894", Lf = "rbxassetid://214405668", Rt = "rbxassetid://214399899", Up = "rbxassetid://214399889" },
        ["Mountains"] = { Bk = "rbxassetid://368385273", Dn = "rbxassetid://48015300", Ft = "rbxassetid://368388290", Lf = "rbxassetid://368390615", Rt = "rbxassetid://368385190", Up = "rbxassetid://48015387" },
        ["Pink skies"] = { Bk = "rbxassetid://271042516", Dn = "rbxassetid://271077243", Ft = "rbxassetid://271042556", Lf = "rbxassetid://271042310", Rt = "rbxassetid://271042467", Up = "rbxassetid://271077958" },
        ["Saturn"] = { Bk = "rbxassetid://1898724755", Dn = "rbxassetid://1898727189", Ft = "rbxassetid://1898722814", Lf = "rbxassetid://1898729298", Rt = "rbxassetid://1898741025", Up = "rbxassetid://1898736761" },
        ["Sunset"] = { Bk = "rbxassetid://264908339", Dn = "rbxassetid://264907909", Ft = "rbxassetid://264909420", Lf = "rbxassetid://264909758", Rt = "rbxassetid://264908886", Up = "rbxassetid://264907379" },
        ["Vertical milky way"] = { Bk = "rbxassetid://15146674442", Dn = "rbxassetid://15146673704", Ft = "rbxassetid://15146672849", Lf = "rbxassetid://15146672013", Rt = "rbxassetid://15146671172", Up = "rbxassetid://15146670489" },
        ["Night sky"] = { Bk = "rbxassetid://15502511288", Dn = "rbxassetid://15502508460", Ft = "rbxassetid://15502510289", Lf = "rbxassetid://15502507918", Rt = "rbxassetid://15502509398", Up = "rbxassetid://15502511911"},
        ["Ocean sky"] = { Bk = "rbxassetid://11854686548", Dn = "rbxassetid://11854687121", Ft = "rbxassetid://11854693863", Lf = "rbxassetid://11854696162", Rt = "rbxassetid://11854698541", Up = "rbxassetid://11854708161" },
    };
    objects["skyboxes_key"] = {"Afternoon", "Cloudy", "Dawn", "Earth", "Horizontal milky way", "Jungle", "Mountains", "Pink skies", "Saturn", "Sunset", "Vertical milky way", "Ocean sky", "Night sky"};



    -- // ( Weather )
    objects["weathers"] = {
        ["Light rain"] = {
            ["LockedToPart"] = true,
            ["Rate"] = 500,
            ["Squash"] = number_sequence_new{
                number_sequence_keypoint_new(0, 3),
                number_sequence_keypoint_new(1, 3)
            },
            ["LightInfluence"] = 0.30000001192092896,
            Transparency = number_sequence_new{
                number_sequence_keypoint_new(0, 0),
                number_sequence_keypoint_new(0.435, 0),
                number_sequence_keypoint_new(1, 0)
            },
            ["Texture"] = "rbxasset://textures/particles/sparkles_main.dds",
            ["Speed"] = number_range_new(30, 50),
            ["Lifetime"] = number_range_new(9, 9),
            ["LightEmission"] = 0.5,
            ["Brightness"] = 2,
            ["EmissionDirection"] = Enum.NormalId.Bottom,
            ["Orientation"] = Enum.ParticleOrientation.FacingCameraWorldUp,
            ["Size"] = number_sequence_new{
                number_sequence_keypoint_new(0, 0.20000000298023224),
                number_sequence_keypoint_new(1, 0.20000000298023224)
            }
        },
        ["Heavy rain"] = {
            ["Speed"] = number_range_new(60, 60),
            ["LockedToPart"] = true,
            ["Rate"] = 600,
            ["Texture"] = "rbxassetid://1822883048",
            ["EmissionDirection"] = Enum.NormalId.Bottom,
            ["Transparency"] = number_sequence_new{
                number_sequence_keypoint_new(0, 1),
                number_sequence_keypoint_new(0.25, 0.7842668294906616),
                number_sequence_keypoint_new(0.75, 0.7842668294906616),
                number_sequence_keypoint_new(1, 1)
            },
            ["Lifetime"] = number_range_new(0.800000011920929, 0.800000011920929),
            ["LightEmission"] = 0.05000000074505806,
            ["LightInfluence"] = 0.8999999761581421,
            ["Orientation"] = Enum.ParticleOrientation.FacingCameraWorldUp,
            ["Size"] = number_sequence_new{
                number_sequence_keypoint_new(0, 10),
                number_sequence_keypoint_new(1, 10)
            },
        },
        ["Snow"] = {
            ["Transparency"] = number_sequence_new{
                number_sequence_keypoint_new(0, 0.7374999523162842),
                number_sequence_keypoint_new(0.973, 0.768750011920929),
                number_sequence_keypoint_new(1, 1)
            },
            ["Lifetime"] = number_range_new(0.800000011920929, 0.800000011920929),
            ["Texture"] = "rbxassetid://99851851",
            ["SpreadAngle"] = vector2_new(50, 50),
            ["Speed"] = number_range_new(30, 30),
            ["LightEmission"] = 0.5,
            ["Rate"] = 1000,
            ["EmissionDirection"] = Enum.NormalId.Bottom,
            ["Size"] = number_sequence_new{
                number_sequence_keypoint_new(0, 0.25),
                number_sequence_keypoint_new(0.5, 0.35),
                number_sequence_keypoint_new(1, 0.3)
            }
        }
    };
    objects["weather_key"] = {"Light rain", "Heavy rain", "Snow"};



    -- // ( Misc stuff )
    objects["materials_key"] = {"Neon", "ForceField"};
    objects["highlight_mode_key"] = {"Occluded", "AlwaysOnTop"};
    objects["body_parts_key"] = {
        "Head", "UpperTorso", "LowerTorso",
        "LeftUpperArm", "LeftLowerArm", "RightUpperArm", "RightLowerArm",
        "LeftHand", "RightHand",
        "LeftUpperLeg", "LeftLowerLeg", "RightUpperLeg", "RightLowerLeg",
        "LeftFoot", "RightFoot"
    };
end;


for index, table in pairs(objects) do
    if (index:lower():find("key")) then
        table_sort(table);
    end;
end;



return objects;
