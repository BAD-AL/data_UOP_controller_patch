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
    public partial class MainForm : Form
    {
        private Dictionary<ControllerButton, Rectangle> mButtons = new Dictionary<ControllerButton, Rectangle>();
        private string mProfilePath = null;
        private byte[] ProfileBytes = null;

        public string ProfilePath
        {
            get { return mProfilePath; }
            set 
            {
                if (System.IO.File.Exists(value))
                {
                    mProfilePath = value;
                    ProfileBytes = System.IO.File.ReadAllBytes(mProfilePath);
                    btnSaveProfile.Enabled = true;
                    btnAutoFix.Enabled = true;
                }
            }
        }

        
        public MainForm()
        {
            InitializeComponent();
            mButtons.Add(ControllerButton.Y, new Rectangle(391, 112, 30, 30));
            mButtons.Add(ControllerButton.X, new Rectangle(355, 153, 30, 30));
            mButtons.Add(ControllerButton.A, new Rectangle(391, 182, 30, 30));
            mButtons.Add(ControllerButton.B, new Rectangle(436, 150, 30, 30));
            
            mButtons.Add(ControllerButton.Select, new Rectangle(185, 156, 30, 30));
            mButtons.Add(ControllerButton.Start, new Rectangle(299, 158, 30, 30));

            mButtons.Add(ControllerButton.L3, new Rectangle(88, 174, 30, 30));
            mButtons.Add(ControllerButton.R3, new Rectangle(316, 250, 30, 30));

            mButtons.Add(ControllerButton.LB, new Rectangle(53, 56, 90, 30));
            mButtons.Add(ControllerButton.RB, new Rectangle(369, 56, 90, 30));

            mButtons.Add(ControllerButton.LT, new Rectangle(105, 9, 30, 40));
            mButtons.Add(ControllerButton.RT, new Rectangle(384, 9, 30, 40));

            mButtons.Add(ControllerButton.D_pad_Up,    new Rectangle(163, 213, 30, 30));
            mButtons.Add(ControllerButton.D_pad_Down,  new Rectangle(168, 265, 30, 30));
            mButtons.Add(ControllerButton.D_pad_Left,  new Rectangle(137, 238, 30, 30));
            mButtons.Add(ControllerButton.D_pad_Right, new Rectangle(197, 237, 30, 30));



            comboBox_mode.SelectedIndex = 0;
        }


        private ControllerButton GetButton(int x, int y)
        {
            ControllerButton retVal = ControllerButton.None;
            foreach (KeyValuePair<ControllerButton, Rectangle> item in mButtons)
            {
                if (x >= item.Value.Left && x <= item.Value.Right &&
                    y >= item.Value.Top && y <= item.Value.Bottom)
                {
                    retVal = item.Key;
                    break;
                }
            }
            
            return retVal;
        }

        private void pictureBoxController_MouseClick(object sender, MouseEventArgs e)
        {
            if (ProfileBytes == null)
            {
                LoadProfile();
                return;
            }
            ControllerButton b = GetButton(e.X, e.Y);
            string text = string.Format("{0}: x:{1} y:{2}\n", b.ToString(), e.X, e.Y);
            text_info.AppendText(text);
            if (b == ControllerButton.None)
                return;

            try
            {
                if (b.ToString().Length > 0)
                {
                    FunctionSelectForm f = new FunctionSelectForm();
                    f.CurrentButton = b;
                    f.StartPosition = FormStartPosition.CenterParent;
                    f.ControlMode = (ControlMode)comboBox_mode.SelectedIndex;
                    string current = ProfileHelper.GetCurrentButtonFunction(b, f.ControlMode, ProfileBytes);
                    f.SetCurrentFunction(current);
                    if (f.ShowDialog(this) == DialogResult.OK)
                    {
                        string newVal = f.GetSelection();
                        ProfileHelper.SetButtonFunction(b, f.ControlMode, newVal, ProfileBytes);
                    }
                    f.Dispose();
                }
            }
            catch (Exception )
            {
                MessageBox.Show(string.Format("Setting button for {0}, is not supported in this mode ({1})", 
                    b.ToString(), ((ControlMode)comboBox_mode.SelectedIndex).ToString() ));
            }
        }

        private void btnLoadProfile_Click(object sender, EventArgs e)
        {
            LoadProfile();
        }

        private void LoadProfile()
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Title = "Load SWBF2 Profile";
            dlg.Filter = "profiles|*.profile";
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                this.ProfilePath = dlg.FileName;
            }
            dlg.Dispose();
        }

        private void btnSaveProfile_Click(object sender, EventArgs e)
        {
            try
            {
                System.IO.File.WriteAllBytes(mProfilePath, ProfileBytes);
                MessageBox.Show(String.Format("Saved to '{0}'", mProfilePath));
                
            }
            catch
            { }
        }

        private void btnAutoFix_Click(object sender, EventArgs e)
        {
            if (ProfileBytes != null)
            {
                ProfileHelper.SetButtonFunction(
                    ControllerButton.B, ControlMode.Ifantry, "Roll", ProfileBytes);
                ProfileHelper.SetButtonFunction(
                    ControllerButton.B, ControlMode.Jedi, "Roll", ProfileBytes);
                ProfileHelper.SetButtonFunction(
                    ControllerButton.B, ControlMode.Vehicle, "Roll/Transform", ProfileBytes);
                ProfileHelper.SetButtonFunction(
                    ControllerButton.B, ControlMode.Turret, "Next", ProfileBytes);
            }
            else {
                MessageBox.Show("Please Load A profile first.");
            }
        }
    }

}
