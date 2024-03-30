using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BF2_Steam_Controller_Profile_Config
{
    public class ProfileHelper
    {
        static ProfileHelper()
        {
        }

        private static Dictionary<ControllerButton, uint> infAddresses = null;
        public static Dictionary<ControllerButton, uint> InfAddresses
        {
            get
            {
                if(infAddresses  == null)
                    infAddresses = new Dictionary<ControllerButton, uint>() { 
                        {ControllerButton.Start,0x1104},
                        {ControllerButton.Select,0x1108},
                        {ControllerButton.D_pad_Left,0x110C},
                        {ControllerButton.D_pad_Right,0x1110},
                        {ControllerButton.D_pad_Up,0x1114},
                        {ControllerButton.D_pad_Down,0x1118},
                        {ControllerButton.L3,0x111C},
                        {ControllerButton.R3,0x1120},
                        {ControllerButton.X,0x1124},
                        {ControllerButton.B,0x1128},
                        {ControllerButton.Y,0x112C},
                        {ControllerButton.A,0x1130},
                        {ControllerButton.LT,0x1134},
                        {ControllerButton.RT,0x1138},
                        {ControllerButton.LB,0x113C},
                        {ControllerButton.RB,0x1140},
                    };
                return infAddresses; 
            }
        }

        private static Dictionary<ControllerButton, uint> vehDroidikaAddresses = null;

        public static Dictionary<ControllerButton, uint> VehDroidikaAddresses 
        {
            get
            {
                if(vehDroidikaAddresses == null)
                    vehDroidikaAddresses = new Dictionary<ControllerButton, uint>() { 
                    {ControllerButton.Start, 0x1184},
                    {ControllerButton.Select, 0x1188},
                    {ControllerButton.D_pad_Left, 0x118C},
                    {ControllerButton.D_pad_Right, 0x1190},
                    {ControllerButton.D_pad_Up, 0x1194},
                    {ControllerButton.D_pad_Down, 0x1198},
                    {ControllerButton.L3, 0x119C},
                    {ControllerButton.R3, 0x11A0},
                    {ControllerButton.X, 0x11A4},
                    {ControllerButton.B, 0x11A8},
                    {ControllerButton.Y, 0x11AC},
                    {ControllerButton.A, 0x11B0},
                    {ControllerButton.LT, 0x11B4},
                    {ControllerButton.RT, 0x11B8},
                    {ControllerButton.LB, 0x11BC},
                    {ControllerButton.RB, 0x11C0},
                };
                return vehDroidikaAddresses; 
            }
        }

        private static Dictionary<ControllerButton, uint> starfighterAddresses = null;
        public static Dictionary<ControllerButton, uint> StarfighterAddresses
        {
            get
            {
                if (starfighterAddresses == null )
                    starfighterAddresses = new Dictionary<ControllerButton, uint>() { 
                        {ControllerButton.Start, 0x1204},
                        {ControllerButton.Select, 0x1208},
                        {ControllerButton.D_pad_Left, 0x120C},
                        {ControllerButton.D_pad_Right, 0x1210},
                        {ControllerButton.D_pad_Up, 0x1214},
                        {ControllerButton.D_pad_Down, 0x1218},
                        {ControllerButton.L3, 0x121C},
                        {ControllerButton.R3, 0x1220},
                        {ControllerButton.X, 0x1224},
                        {ControllerButton.B, 0x1228},
                        {ControllerButton.Y, 0x122C},
                        {ControllerButton.A, 0x1230},
                        {ControllerButton.LT, 0x1234},
                        {ControllerButton.RT, 0x1238},
                        {ControllerButton.LB, 0x123C},
                        {ControllerButton.RB, 0x1240},
                    };
                return starfighterAddresses; 
            }
        }

        private static Dictionary<ControllerButton, uint> jediAddresses = null;
        public static Dictionary<ControllerButton, uint> JediAddresses
        {
            get {
                if (jediAddresses == null)
                    jediAddresses = new Dictionary<ControllerButton, uint>() { 
                    {ControllerButton.Start, 0x1284},
                    {ControllerButton.Select, 0x1288},
                    {ControllerButton.D_pad_Left, 0x128C},
                    {ControllerButton.D_pad_Right, 0x1290},
                    {ControllerButton.D_pad_Up, 0x1294},
                    {ControllerButton.D_pad_Down, 0x1298},
                    {ControllerButton.L3, 0x129C},
                    {ControllerButton.R3, 0x12A0},
                    {ControllerButton.X, 0x12A4},
                    {ControllerButton.B, 0x12A8},
                    {ControllerButton.Y, 0x12AC},
                    {ControllerButton.A, 0x12B0},
                    {ControllerButton.LT, 0x12B4},
                    {ControllerButton.RT, 0x12B8},
                    {ControllerButton.LB, 0x12BC},
                    {ControllerButton.RB, 0x12C0},
                };    
                return jediAddresses; 
            }
        }

        private static Dictionary<ControllerButton, uint> turretAddresses = null;
        public static Dictionary<ControllerButton, uint> TurretAddresses
        {
            get
            {
                if (turretAddresses == null)
                    turretAddresses = new Dictionary<ControllerButton, uint>() { 
                        {ControllerButton.Start, 0x1304},
                        {ControllerButton.Select, 0x1308},
                        {ControllerButton.D_pad_Left, 0x130C},
                        {ControllerButton.D_pad_Right, 0x1310},
                        {ControllerButton.D_pad_Up, 0x1314},
                        {ControllerButton.D_pad_Down, 0x1318},
                        {ControllerButton.L3, 0x131C},
                        {ControllerButton.R3, 0x1320},
                        {ControllerButton.X, 0x1324},
                        {ControllerButton.B, 0x1328},
                        {ControllerButton.Y, 0x132C},
                        {ControllerButton.A, 0x1330},
                        {ControllerButton.LT, 0x1334},
                        {ControllerButton.RT, 0x1338},
                        {ControllerButton.LB, 0x133C},
                        {ControllerButton.RB, 0x1340},
                    };
                return turretAddresses; 
            }
        }


        private static Dictionary<string, byte> infFunctions = null;
        public static Dictionary<string, byte> InfFunctions
        {
            get {
                if (infFunctions == null)
                    infFunctions = new Dictionary<string, byte>() { 
                    {"Map",              0x1C	},
                    {"Accept",           0x0A	},
                    {"Decline",          0x0B	},
                    {"Squad",            0x09	},
                    {"Reload",           0x07	},
                    {"Sprint",           0x02	},
                    {"Zoom",             0x05	},
                    {"Lock Target",      0x0C	},
                    {"Crouch",           0x04	},
                    {"Enter/Use",        0x08	},
                    {"Jump",             0x03	},
                    {"Secondary Attack", 0x01	},
                    {"Primary Attack",   0x00	},
                    {"Secondary Next",   0x0F	},
                    {"Primary Next",     0x0D	},
                    {"1st/3rd Person View", 0x06},
                    {"Primary Prev",     0x0E	},
                    {"Roll",             0x3D	},
            };    
                return infFunctions; 
            }
        }

        private static Dictionary<string, byte> vehFunctions = null;
        public static Dictionary<string, byte> VehFunctions
        {
            get {
                if (vehFunctions == null)
                vehFunctions = new Dictionary<string, byte>() { 
                        {"Map", 0x1C},
                        {"Accept", 0x0A},
                        {"Decline", 0x0B},
                        {"Squad", 0x09},
                        {"Reload ", 0x07},
                        {"Boost", 0x02},
                        {"Zoom", 0x05},
                        {"Lock Target", 0x0C},
                        {"Exit", 0x08},
                        {"Jump", 0x03},
                        {"Secondary Attack", 0x01},
                        {"Primary Attack", 0x00},
                        {"Next Position",  0x0D},
                        {"Roll/Transform", 0x04},
                };
                return vehFunctions; 
            }
        }

        private static Dictionary<string, byte> starfighterFunctions = null;
        public static Dictionary<string, byte> StarfighterFunctions
        {
            get
            {
                if (starfighterFunctions == null)
                    starfighterFunctions = new Dictionary<string, byte>() { 
                        {"Map", 0x1C},
                        {"Accept", 0x0A},
                        {"Decline", 0x0B},
                        {"Squad", 0x09},
                        {"Reload (None)", 0x07},
                        {"Zoom", 0x05},
                        {"Boost", 0x02},
                        {"Lock Target", 0x0C},
                        {"Trick", 0x04},
                        {"Exit", 0x08},
                        {"Land/Takeoff", 0x03},
                        {"Secondary Attack", 0x01},
                        {"Primary Attack", 0x00},
                        {"Lock Target", 0x0C},
                        {"Next Position", 0x0D},
                };
                return starfighterFunctions;
            }
        }

        private static Dictionary<string, byte> jediFunctions = null;
        public static Dictionary<string, byte> JediFunctions
        {
            get {
                if (jediFunctions == null)
                    jediFunctions = new Dictionary<string, byte>() { 
                    {"Map",         0x1C},
                    {"Accept",      0x0A},
                    {"Decline",     0x0B},
                    {"Squad",       0x09},
                    {"Sprint",      0x02},
                    {"Zoom",        0x05},
                    {"Lock Target", 0x0C},
                    {"Crouch",      0x04},
                    {"Enter/Use",   0x08},
                    {"Jump",        0x03},
                    {"Force Power", 0x07},
                    {"Lightsaber",  0x00},
                    {"Switch Force",0x0F},
                    {"Block",       0x01},

                    {"Roll",             0x3D	},

            };
                return jediFunctions; 
            }
        }

        // extra
        //0x00001340 - 0D 00 00 00 //Turret - RB for next weapon

        private static Dictionary<string, byte> turretFunctions = null;
        public static Dictionary<string, byte> TurretFunctions
        {
            get {
                if (turretFunctions == null)
                    turretFunctions = new Dictionary<string, byte>() { 
                    {"Map", 0x1C},
                    {"Accept", 0x0A},
                    {"Decline", 0x0B},
                    {"Zoom", 0x05},
                    {"Lock Target", 0x0C},
                    {"Exit", 0x08},
                    {"Primary Attack", 0x00},
                    {"Next", 0x0D},

                    //{"Primary Next",     0x0D	},
                    {"Prev",     0x0E	},
            };    
                return turretFunctions; 
            }
        }

        
        public static byte GetFunctionValue(string functionName, ControlMode mode)
        {
            Dictionary<string, byte> current = ProfileHelper.InfFunctions;
            switch (mode)
            {
                case ControlMode.Ifantry: current = ProfileHelper.InfFunctions; break;
                case ControlMode.Vehicle: current = ProfileHelper.VehFunctions; break;
                case ControlMode.Starfighter: current = ProfileHelper.StarfighterFunctions; break;
                case ControlMode.Jedi: current = ProfileHelper.JediFunctions; break;
                case ControlMode.Turret: current = ProfileHelper.TurretFunctions; break;
            }
            foreach (KeyValuePair<string, byte> kvp in current)
            {
                if (functionName == kvp.Key)
                {
                    return kvp.Value;
                }
            }
            throw new InvalidOperationException(
                string.Format("Unable to map {0} in mode {1}", functionName, mode.ToString())
                );
        }

        public static string GetCurrentButtonFunction(ControllerButton button, ControlMode mode, byte[] profile)
        {
            var buttonDict = TurretAddresses;
            Dictionary<string, byte> functions = null;
            switch (mode)
            {
                case ControlMode.Ifantry: 
                    buttonDict = ProfileHelper.InfAddresses;
                    functions = ProfileHelper.InfFunctions;
                    break;
                case ControlMode.Vehicle: 
                    buttonDict = ProfileHelper.VehDroidikaAddresses;
                    functions = ProfileHelper.VehFunctions;
                    break;
                case ControlMode.Starfighter: 
                    buttonDict = ProfileHelper.StarfighterAddresses;
                    functions = ProfileHelper.StarfighterFunctions;
                    break;
                case ControlMode.Jedi: 
                    buttonDict = ProfileHelper.JediAddresses;
                    functions = ProfileHelper.JediFunctions;
                    break;
                case ControlMode.Turret: 
                    buttonDict = ProfileHelper.TurretAddresses;
                    functions = ProfileHelper.TurretFunctions;
                    break;
            }
            uint address = buttonDict[button];
            byte funcValue = profile[address];
            foreach (KeyValuePair<string, byte> kvp in functions)
            {
                if (kvp.Value == funcValue)
                    return kvp.Key;
            }
            return null;
        }

        internal static void SetButtonFunction(
                            ControllerButton b, ControlMode mode, 
                            string newVal, byte[] profileBytes )
        {
            // set profileBytes[loc] = byteVal;
            var addresses = TurretAddresses;
            Dictionary<string, byte> functions = null;
            switch (mode)
            {
                case ControlMode.Ifantry:
                    addresses = ProfileHelper.InfAddresses;
                    functions = ProfileHelper.InfFunctions;
                    break;
                case ControlMode.Vehicle:
                    addresses = ProfileHelper.VehDroidikaAddresses;
                    functions = ProfileHelper.VehFunctions;
                    break;
                case ControlMode.Starfighter:
                    addresses = ProfileHelper.StarfighterAddresses;
                    functions = ProfileHelper.StarfighterFunctions;
                    break;
                case ControlMode.Jedi:
                    addresses = ProfileHelper.JediAddresses;
                    functions = ProfileHelper.JediFunctions;
                    break;
                case ControlMode.Turret:
                    addresses = ProfileHelper.TurretAddresses;
                    functions = ProfileHelper.TurretFunctions;
                    break;
            }
            var loc = addresses[b];
            var val = functions[newVal];
            profileBytes[loc] = val;
        }
    }

    public enum ControlMode
    {
        Ifantry,
        Vehicle,
        Starfighter,
        Jedi,
        Turret,
        None
    }

    public enum ControllerButton
    {
        None,
        Start,
        Select,
        D_pad_Left,
        D_pad_Right,
        D_pad_Up,
        D_pad_Down,
        L3,
        R3,
        X,
        B,
        Y,
        A,
        LT,
        RT,
        LB,
        RB,
    }
}
