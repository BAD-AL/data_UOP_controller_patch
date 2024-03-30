using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace BF2_Steam_Controller_Profile_Config
{
    public partial class FunctionSelectForm : Form
    {
        public FunctionSelectForm()
        {
            InitializeComponent();
        }

        private ControlMode mControlMode = ControlMode.None;
        public ControlMode ControlMode
        {
            get { return mControlMode;  }
            set 
            {
                if (mControlMode != value)
                {
                    mControlMode = value;
                    OnControlModeChanged();
                }
            }
        }

        private ControllerButton mCurrentButton = ControllerButton.None;

        public ControllerButton CurrentButton
        {
            get { return mCurrentButton; }
            set
            {
                mCurrentButton = value;
                label_button.Text = mCurrentButton.ToString();
                Text = "Choice for button: " + mCurrentButton.ToString();
            }
        }

        public string GetSelection()
        {
            string retVal = "";
            if (comboBox_values.SelectedIndex > -1)
                retVal = comboBox_values.Items[comboBox_values.SelectedIndex].ToString();
            return retVal;
        }

        public void SetCurrentFunction(string c)
        {
            for (int i = 0; i < comboBox_values.Items.Count; i++ )
            {
                if (c == comboBox_values.Items[i].ToString())
                {
                    comboBox_values.SelectedIndex = i;
                    break;
                }
            }
        }

        private void OnControlModeChanged()
        {
            comboBox_values.BeginUpdate();
            comboBox_values.Items.Clear();

            Dictionary<string, byte> current = ProfileHelper.InfFunctions;
            switch (this.ControlMode)
            {
                case ControlMode.Ifantry:       current = ProfileHelper.InfFunctions;           break;
                case ControlMode.Vehicle:       current = ProfileHelper.VehFunctions;           break;
                case ControlMode.Starfighter:   current = ProfileHelper.StarfighterFunctions;   break;
                case ControlMode.Jedi:          current = ProfileHelper.JediFunctions;          break;
                case ControlMode.Turret:        current = ProfileHelper.TurretFunctions;        break;
            }
            foreach (KeyValuePair<string, byte> kvp in current)
            {
                comboBox_values.Items.Add(kvp.Key);
            }
            comboBox_values.EndUpdate();
        }

    }
}
